#!/bin/bash

# Banner with script name
echo "*****************"
echo "NixOS bootstraper"
echo "*****************"

# Function to display usage information
usage() {
  echo "Usage: $0 [--help] HOST"
  echo "  --help     Display this help message."
  echo "  HOST       The hostname to be bootstraped."
}

if [ "$#" -eq 0 ] && [ "$1" = "--help" ]; then
  usage
  exit 0
fi

# Check if the script is run with root privileges
if [ "$EUID" -ne 0 ]; then
  echo "ERROR - This script must be run with root privileges. Please use 'sudo' or run as the root user."
  exit 1
fi

# Check if there is exactly one argument
if [ "$#" -ne 1 ]; then
  echo "Please provide a single argument."
  exit 1
fi

host=$1

url="https://raw.githubusercontent.com/auricom/nix-config/main/hosts/nixos/${host}/disko.nix"

# Prompt for confirmation
read -p "Do you want to format the disk and install nixos ? (y/n) " choice
if [ "$choice" != "y" ]; then
  echo "Script execution aborted."
  exit 1
fi

# Download diko configuration
if ! curl --silent --location  "${url}" --output /tmp/disko.nix ; then
  echo "ERROR - Disko configuration download failed. "
  exit 1
fi

# Apply disko configuration and format disks
nix \
  --extra-experimental-features flakes \
  --extra-experimental-features nix-command \
  run github:nix-community/disko -- \
  --mode disko /tmp/disko.nix

# Generate nixos base configuration
nixos-generate-config --root /mnt

nixos-install
