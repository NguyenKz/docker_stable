#!/bin/bash

# Set your Docker Hub username
DOCKER_HUB_USERNAME="yourusername"
IMAGE_NAME="webui-forge"
VERSION="latest"

# Check if username is provided as argument
if [ "$1" != "" ]; then
    DOCKER_HUB_USERNAME="$1"
fi

# Check if version is provided as argument
if [ "$2" != "" ]; then
    VERSION="$2"
fi

echo "Building Docker image: $DOCKER_HUB_USERNAME/$IMAGE_NAME:$VERSION"
echo "==============================================================="

# Build the Docker image
docker build -t "$DOCKER_HUB_USERNAME/$IMAGE_NAME:$VERSION" .

# Check if build was successful
if [ $? -ne 0 ]; then
    echo "❌ Docker build failed"
    exit 1
fi

echo "✅ Build completed successfully"
echo ""
echo "Logging in to Docker Hub..."
echo "==============================================================="

# Login to Docker Hub
docker login

# Check if login was successful
if [ $? -ne 0 ]; then
    echo "❌ Docker Hub login failed"
    exit 1
fi

echo "✅ Login successful"
echo ""
echo "Pushing image to Docker Hub: $DOCKER_HUB_USERNAME/$IMAGE_NAME:$VERSION"
echo "==============================================================="

# Push the Docker image
docker push "$DOCKER_HUB_USERNAME/$IMAGE_NAME:$VERSION"

# Check if push was successful
if [ $? -ne 0 ]; then
    echo "❌ Docker push failed"
    exit 1
fi

echo "✅ Image successfully pushed to Docker Hub"
echo ""
echo "Image URL: https://hub.docker.com/r/$DOCKER_HUB_USERNAME/$IMAGE_NAME" 