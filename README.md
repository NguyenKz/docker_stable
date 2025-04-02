# Stable Diffusion WebUI Docker Setup

This repository contains Docker configuration for running [Stable Diffusion WebUI Forge](https://github.com/lllyasviel/stable-diffusion-webui-forge) with several useful extensions pre-installed.

## Prerequisites

- Docker and Docker Compose installed on your system
- NVIDIA GPU with appropriate drivers for optimal performance
- NVIDIA Container Toolkit installed (for GPU support)

## Getting Started

1. Clone this repository:
   ```bash
   git clone https://github.com/yourusername/docker_stable.git
   cd docker_stable
   ```

2. Build and start the container:
   ```bash
   docker-compose up -d
   ```

3. Access the Stable Diffusion WebUI at:
   ```
   http://localhost:7860
   ```

## Included Extensions

- [Infinite Image Browsing](https://github.com/zanllp/sd-webui-infinite-image-browsing)
- [Ultimate Upscale](https://github.com/Coyote-A/ultimate-upscale-for-automatic1111)
- [Inpaint Anything](https://github.com/Uminosachi/sd-webui-inpaint-anything)

## Managing Models

Models are stored in the `stable-diffusion-webui-forge/models` directory, which is mounted as a volume in the container. You can add your models to this directory, and they will be available in the WebUI.

## Volumes

The following directories are mounted as volumes:
- `./stable-diffusion-webui-forge/models`: For storing models
- `./stable-diffusion-webui-forge/outputs`: For generated images
- `./stable-diffusion-webui-forge/extensions`: For extensions

## Stopping the Container

```bash
docker-compose down
``` 