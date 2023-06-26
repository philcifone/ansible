#!/bin/bash
#
# ubuntu container startup in proxmox
#

# User input
read -p "Enter the desired container ID: " VMID
read -p "Enter the number of cores (e.g., 1): " CORES
read -p "Enter the amount of RAM in MB (e.g., 512): " MEMORY
read -p "Enter the amount of swap in MB (e.g., 512): " SWAP
read -p "Enter the storage location (local-lvm, catalyst, magellan): " STORAGE
read -p "Enter the hostname for the container: " HOSTNAME
#read -p "Enter the password for the container, please change this later: " PASSWORD

# Create ubuntu container
pct create $VMID local:vztmpl/ubuntu-23.04-standard_23.04-1_amd64.tar.zst --cores $CORES --memory $MEMORY --swap $SWAP --storage $STORAGE --net0 name=eth0,ip=dhcp,ip6=dhcp,bridge=vmbr0 --hostname $HOSTNAME #--password $PASSWORD

# Start the container
pct start $VMID

sleep 15

# enter the container
#pct enter $VMID

# create root password
pct exec $VMID -- passwd

# update container
pct exec $VMID -- apt update && apt upgrade

# install python and rsync
pct exec $VMID -- apt install python rsync

# ip address output for ansible
pct exec $VMID -- ip a

# User input for password
#read -s -p "Enter the password for the 'root' user: " ROOT_PASSWORD

# Set root password inside the container
#pct exec $VMID -- chroot / -- sh -c "echo 'root:$ROOT_PASSWORD' | chpasswd"
