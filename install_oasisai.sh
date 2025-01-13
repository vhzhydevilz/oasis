#!/bin/bash

# Banner
echo -e "\n     _               _                "
echo -e " ___| |__  _   _  __| | _____   ______"
echo -e "|_  / '_ \| | | |/ _` |/ _ \ \ / /_  /"
echo -e " / /| | | | |_| | (_| |  __/\ V / / / "
echo -e "/___|_| |_|\__, |\__,_|\___| \_/ /___|"
echo -e "           |___/      "


echo -e "=========================================="
echo -e "Install Oasis AI Script"
echo -e "==========================================\n"

# Meminta input port
read -p "Enter the port you want to use (default 9999): " port
port=${port:-9999}  # Default to 9999 if empty input

echo "Selected port: $port"

# Update sistem dan instal dependensi
echo "Updating system and installing dependencies..."
sudo apt update -y
sudo apt install -y curl wget unzip

# Unduh file Oasis AI dari Google Drive
echo "Downloading Oasis AI from Google Drive..."
wget --no-check-certificate 'https://drive.google.com/uc?export=download&id=1TW2wauO0aNnoCaKEHhuG5KYD3j67XC8z' -O oasis_ai_appimage

# Memberikan izin eksekusi pada file AppImage
chmod +x oasis_ai_appimage

# Menjalankan file AppImage
echo "Running Oasis AI AppImage..."
./oasis_ai_appimage &

# Menampilkan instruksi akses
echo -e "\nInstallation completed."
echo -e "=========================================="
echo -e "You can now access Oasis AI via your browser."
echo -e "Go to: http://<your_server_ip>:$port"
echo -e "Replace <your_server_ip> with your server's IP address."
