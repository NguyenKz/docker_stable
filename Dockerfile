FROM nvidia/cuda:12.1.0-devel-ubuntu22.04

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive
ENV PYTHONUNBUFFERED=1
ENV PATH="${PATH}:/root/.local/bin"

# Install system dependencies
RUN apt-get update && apt-get install -y \
    git \
    python3-pip \
    python3-dev \
    aria2 \
    wget \
    unzip \
    && rm -rf /var/lib/apt/lists/*

# Create workspace directories
RUN mkdir -p /content/out
RUN chmod -R 777 /content/out

# Clone WebUI Forge repository
WORKDIR /content
RUN git clone https://github.com/lllyasviel/stable-diffusion-webui-forge
WORKDIR /content/stable-diffusion-webui-forge

# Install Python dependencies
RUN pip3 install --upgrade pip
RUN pip3 install xformers!=0.0.18 torch==2.5.1 torchvision torchaudio --extra-index-url https://download.pytorch.org/whl/cu121
RUN pip3 install -r requirements_versions.txt
RUN pip3 install 'accelerate>=0.26.0'

# Install extensions
RUN git clone https://github.com/zanllp/sd-webui-infinite-image-browsing /content/stable-diffusion-webui-forge/extensions/sd-webui-infinite-image-browsing
RUN git clone https://github.com/Coyote-A/ultimate-upscale-for-automatic1111 /content/stable-diffusion-webui-forge/extensions/ultimateSD
RUN git clone https://github.com/BlafKing/sd-civitai-browser-plus /content/stable-diffusion-webui-forge/extensions/sd-civitai-browser-plus

# Create model directories
RUN mkdir -p /content/stable-diffusion-webui-forge/models/VAE
RUN mkdir -p /content/stable-diffusion-webui-forge/models/text_encoder

# Download models
WORKDIR /content/stable-diffusion-webui-forge
RUN aria2c --console-log-level=error -c -x 16 -s 16 -k 1M -c https://huggingface.co/black-forest-labs/FLUX.1-schnell/resolve/main/ae.safetensors -d /content/stable-diffusion-webui-forge/models/VAE -o ae.safetensors
RUN aria2c --console-log-level=error -c -x 16 -s 16 -k 1M -c https://huggingface.co/comfyanonymous/flux_text_encoders/resolve/main/clip_l.safetensors -d /content/stable-diffusion-webui-forge/models/text_encoder -o clip_l.safetensors
RUN aria2c --console-log-level=error -c -x 16 -s 16 -k 1M -c https://huggingface.co/comfyanonymous/flux_text_encoders/resolve/main/t5xxl_fp8_e4m3fn.safetensors -d /content/stable-diffusion-webui-forge/models/text_encoder -o t5xxl_fp8_e4m3fn.safetensors

# Set working directory
WORKDIR /content/stable-diffusion-webui-forge

# Expose port for WebUI
EXPOSE 7860

# Start the WebUI
CMD ["python", "launch.py", "--share", "--port", "7860", "--api", "--precision", "half", "--xformers"] 