#!/bin/bash
# Enable swap on Linux Mint — Best Practice Script
# Author: Jashanjot's AI buddy 😎

# === SETTINGS ===
SWAP_SIZE="16G"  # Change to your desired swap size (e.g., 8G)

# === 1. Create swap file ===
echo "[+] Creating $SWAP_SIZE swap file..."
sudo fallocate -l $SWAP_SIZE /swapfile || {
    echo "[!] fallocate failed, using dd..."
    sudo dd if=/dev/zero of=/swapfile bs=1M count=$((${SWAP_SIZE//[!0-9]/}*1024)) status=progress
}

# === 2. Set permissions ===
echo "[+] Setting swap file permissions..."
sudo chmod 600 /swapfile

# === 3. Format as swap ===
echo "[+] Formatting as swap..."
sudo mkswap /swapfile

# === 4. Enable immediately ===
echo "[+] Enabling swap..."
sudo swapon /swapfile

# === 5. Make it permanent ===
if ! grep -q "/swapfile" /etc/fstab; then
    echo "[+] Adding swap to /etc/fstab..."
    echo "/swapfile none swap sw 0 0" | sudo tee -a /etc/fstab
else
    echo "[=] Swap entry already exists in /etc/fstab"
fi

# === 6. Adjust swappiness ===
echo "[+] Setting swappiness to 10..."
echo 'vm.swappiness=10' | sudo tee /etc/sysctl.d/99-swappiness.conf >/dev/null
sudo sysctl --system >/dev/null

# === 7. Done ===
echo "[✓] Swap enabled successfully!"
echo "Current swap usage:"
swapon --show
free -h

