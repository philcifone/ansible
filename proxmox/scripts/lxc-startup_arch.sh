#!/bin/bash
#
# arch container startup in proxmox
#

# User input
read -p "Enter the desired container ID: " VMID
read -p "Enter the number of cores (e.g., 1): " CORES
read -p "Enter the amount of RAM in MB (e.g., 512): " MEMORY
read -p "Enter the amount of swap in MB (e.g., 512): " SWAP
read -p "Enter the storage location (local-lvm, catalyst, magellan): " STORAGE
read -p "Enter the hostname for the container: " HOSTNAME
#read -p "Enter the password for the container, please change this later: " PASSWORD

# Create Arch container
pct create $VMID local:vztmpl/archlinux-base_20230608-1_amd64.tar.zst --cores $CORES --memory $MEMORY --swap $SWAP --storage $STORAGE --net0 name=eth0,ip=dhcp,ip6=dhcp,bridge=vmbr0 --hostname $HOSTNAME #--password $PASSWORD

# Start the container
pct start $VMID

sleep 15

# enter the container
#pct enter $VMID

pct exec $VMID -- passwd
pct exec $VMID -- pacman-key --init
pct exec $VMID -- pacman-key --populate
pct exec $VMID -- pacman-key --refresh-keys
pct exec $VMID -- pacman -Syu python3 rsync

# User input for password
#read -s -p "Enter the password for the 'root' user: " ROOT_PASSWORD

# Set root password inside the container
#pct exec $VMID -- chroot / -- sh -c "echo 'root:$ROOT_PASSWORD' | chpasswd"

