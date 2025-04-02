FROM python:3.10-alpine

WORKDIR /app

COPY . .

# Install aria2 and dependencies required for git and pip installations
RUN apk add --no-cache aria2 git build-base linux-headers
# RUN pip install xformers!=0.0.18 torch==2.5.1 torchvision torchaudio --extra-index-url https://download.pytorch.org/whl/cu121
RUN git clone https://github.com/lllyasviel/stable-diffusion-webui-forge
# RUN aria2c https://huggingface.co/TheBloke/Llama-3.1-8B-Instruct-GGUF/resolve/main/llama-3.1-8b-instruct.Q4_K_M.gguf -o llama-3.1-8b-instruct.Q4_K_M.gguf

RUN pip install -r stable-diffusion-webui-forge/requirements_versions.txt

RUN pip install 'accelerate>=0.26.0'

RUN git clone https://github.com/zanllp/sd-webui-infinite-image-browsing stable-diffusion-webui-forge/extensions/sd-webui-infinite-image-browsing
RUN git clone https://github.com/Coyote-A/ultimate-upscale-for-automatic1111 stable-diffusion-webui-forge/extensions/ultimateSD
RUN git clone https://github.com/Uminosachi/sd-webui-inpaint-anything.git stable-diffusion-webui-forge/extensions/sd-webui-inpaint-anything

ENTRYPOINT ["python", "stable-diffusion-webui-forge/launch.py", "--share", "--port", "7860", "--api", "--precision", "half", "--xformers"]
