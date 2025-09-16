#!/bin/bash

# UFW Firewall Configuration Script
# This script enables UFW, allows SSH, denies HTTP, and displays firewall status.

echo "=== UFW Firewall Configuration Script ==="

# Update package list (optional, for ensuring ufw is up to date)
sudo apt-get update -y

# Enable UFW if not already enabled
echo "[*] Enabling UFW..."
sudo ufw --force enable

# Allow SSH (port 22)
echo "[*] Allowing SSH (port 22)..."
sudo ufw allow ssh

# Deny HTTP (port 80)
echo "[*] Denying HTTP (port 80)..."
sudo ufw deny http

# Reload UFW to apply rules
echo "[*] Reloading UFW rules..."
sudo ufw reload

# Show current status with rules
echo "[*] Current UFW status and rules:"
sudo ufw status verbose

echo "=== Configuration Complete ==="
