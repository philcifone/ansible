# ansible

Hello, I am learning Ansible.

I also run a small homelab on Proxmox VE.

This repository contains playbooks to setup LXC containers on proxmox.

### inventory 

This file contains a list of local IP addresses for LXC containers.

### ansible.cfg

Denotes ssh key to use for ansible.

### user-pkgs.yml

This is a baseline playbook to ensure user "phil" was created correctly. It also installs initial packages such as git, vim, sudo, etc.

## Proxmox Playbooks

All proxmox playbooks include passwords encrypted using:

```shell
sudo ansible-vault encrypt_string --vault-password-file ~/.vault_key
```
Enter the desired password and then press ctrl-d twice without pressing enter.

Playbook commands are run using:

```shell
ansible-playbook --ask-become-pass --ask-vault-pass example-playbook.yml
``` 
Be sure to pass the --ask-vault-pass when using a playbook with a vault.

### lxc-start.yml

This is a baseline playbook for a Debian LXC container. Creates a container with the name "test".

### container templates

- photoprism.yml
- wireguard.yml
- plex.yml
- filebrowser.yml
- philcifone.yml

These are set to my desired specifications and distros for each container. While I have snapshots of all of these I figured it wouldn't hurt to create playbooks for them as well.
