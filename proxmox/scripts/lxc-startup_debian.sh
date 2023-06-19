#!/bin/bash
#
# Debian container startup in proxmox
#

# User input
read -p "Enter the desired container ID: " VMID
read -p "Enter the number of cores (e.g., 1): " CORES
read -p "Enter the amount of RAM in MB (e.g., 512): " MEMORY
read -p "Enter the amount of swap in MB (e.g., 512): " SWAP
read -p "Enter the storage location (local-lvm, catalyst, magellan): " STORAGE
read -p "Enter the hostname for the container: " HOSTNAME
#read -p "Enter the password for the container, please change this later: " PASSWORD

# Create Debian container
pct create $VMID local:vztmpl/debian-11-standard_11.7-1_amd64.tar.zst --cores $CORES --memory $MEMORY --swap $SWAP --storage $STORAGE --net0 name=eth0,ip=dhcp,ip6=dhcp,bridge=vmbr0 --ostype archlinux --features nesting=1 --start 1 --onboot 1 --unprivileged 1 --hostname $HOSTNAME #--password $PASSWORD

# Start the container
#pct start $VMID

sleep 15

# set root passwd
pct exec $VMID -- passwd

# arch keyring stuff
pct exec $VMID -- pacman-key --init
pct exec $VMID -- pacman-key --populate
# below not needed currently
#pct exec $VMID -- pacman-key --refresh-keys

# install python and rsync
pct exec $VMID -- pacman -Syu python3 rsync

# make .ssh directory
#pct exec $VMID -- mkdir /root/.ssh

# make authorized keys file
pct exec $VMID -- touch /root/.ssh/authorized_keys

# enable and start sshd service
pct exec $VMID -- systemctl enable sshd
pct exec $VMID -- systemctl start sshd

# ip address output 
pct exec $VMID -- ip a
