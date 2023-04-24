# ansible

Hello, I am learning Ansible.

I also run a small homelab on Proxmox VE.

This repository contains playbooks to setup LXC containers on proxmox.

## inventory 

This file contains a list of local IP addresses for LXC containers.

## ansible.cfg

Denotes ssh key to use for ansible.

## lxc-start.yml

This is a baseline playbook for a Debian LXC container.

## user-pkgs.yml

This is a baseline playbook to ensure user "phil" was created correctly. It also installs initial packages such as git, vim, sudo, etc.

## container templates

- photoprism.yml
- wireguard.yml
- plex.yml
- filebrowser.yml
- philcifone.yml

These are set to my desired specifications and distros for each container. While I have snapshots of all of these I figured it wouldn't hurt to create playbooks for them as well.
