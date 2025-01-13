#!/bin/bash

# Banner
echo "
     _               _                
 ___| |__  _   _  __| | _____   ______
|_  / '_ \| | | |/ _` |/ _ \ \ / /_  /
 / /| | | | |_| | (_| |  __/\ V / / / 
/___|_| |_|\__, |\__,_|\___| \_/ /___|
           |___/      
"

# Ask for the port to use
read -p "Enter the port number to use for Oasis AI (default: 9999): " port
port=${port:-9999}  # Default to 9999 if no input

# Update & Install dependencies
echo "[INFO] Installing dependencies..."
sudo apt update -y
sudo apt install -y wget curl libfuse2 docker.io

# Start Docker service
echo "[INFO] Starting Docker..."
sudo systemctl enable docker
sudo systemctl start docker

# Set working directory
WORKDIR="/opt"
mkdir -p $WORKDIR
cd $WORKDIR

# Download the .appimage file from Google Drive
echo "[INFO] Downloading Oasis AI .appimage file..."
wget -O oasisai.appimage "https://drive.google.com/uc?id=1TW2wauO0aNnoCaKEHhuG5KYD3j67XC8z&export=download"

# Make the .appimage file executable
echo "[INFO] Making .appimage file executable..."
chmod +x oasisai.appimage

# Create Dockerfile
echo "[INFO] Creating Dockerfile..."
cat <<EOF > Dockerfile
# Use Ubuntu as the base image
FROM ubuntu:latest

# Install dependencies
RUN apt update -y && apt install -y wget curl libfuse2

# Set working directory
WORKDIR /opt

# Download Oasis AI .appimage file
RUN wget -O oasisai.appimage "https://drive.google.com/uc?id=1TW2wauO0aNnoCaKEHhuG5KYD3j67XC8z&export=download"

# Make the .appimage executable
RUN chmod +x oasisai.appimage

# Expose the specified port
EXPOSE $port

# Start Oasis AI appimage
CMD ["/opt/oasisai.appimage"]
EOF

# Build the Docker image
echo "[INFO] Building Docker image..."
sudo docker build -t oasisai-image $WORKDIR

# Run the Docker container on the user-specified port
echo "[INFO] Running Docker container on port $port..."
sudo docker run -d -p $port:$port oasisai-image

# Installation Complete
echo "[INFO] Installation completed successfully! Oasis AI is now running on port $port."

# Access Instructions
echo "
[INFO] To access Oasis AI, follow these steps:
1. Open a web browser.
2. Enter the following URL: http://<your_server_ip>:$port

Replace <your_server_ip> with the public IP address of your VPS or localhost if you are running it locally.

Example: http://123.45.67.89:$port

This will allow you to access the Oasis AI user interface.
"
