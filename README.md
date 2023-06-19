# Ansible & Proxmox

This repository contains playbooks to initialize LXC container settings on proxmox and beyond.

I have since made interactive scripts (see below) that offers an interactive way to setup containers
with default parameters as desired. They are used first, and then Ansible playbooks are used to 
add user phil and install packages. 

## Files

#### inventory 

This file contains a list and groups of local IP addresses for LXC containers.

#### ansible.cfg

Denotes ssh key from controller to use for Ansible.

## General playbooks

#### initial-pkgs.yml

This installs initial packages.

#### adduser-phil.yml

This is a baseline playbook to ensure user "phil" was created correctly and given sudo privledges. It also copies SSH keys to authorized keys file.

#### remove-pkgs.yml

This removes above packages aside from sudo. Made for testing.

#### update-upgrade.yml

This updates && upgrades Arch, Debian, and Ubuntu containers in my pve node on Proxmox.

### Proxmox playbooks

## UPDATE: these proxmox playbooks no longer work due to TFA I have setup. Trying to find a fix.

All proxmox playbooks include passwords encrypted using:

```shell
sudo ansible-vault encrypt_string --vault-password-file ~/.vault_key
```

This generates an encrypted password with your vault key using AES256 encryption. When creating a new password, enter the desired password after running the command and then press ctrl-d twice without pressing enter to exit and receive your encryption key.

Playbook commands are run using:

```shell
ansible-playbook --ask-become-pass --ask-vault-pass example-playbook.yml
``` 

Be sure to pass the --ask-vault-pass option when using a playbook with a vault.

#### lxc-start.yml

This is a baseline playbook for a Debian LXC container. It creates an LXC container with the name and number "test" and 300, 1 CPU core, 512MB of both memory and swap, and an 8gb mount point on an external array (in my case a ZFS array named magellan).

### Container templates

- photoprism.yml
- wireguard.yml
- plex.yml
- filebrowser.yml
- philcifone.yml

These are set to my desired specifications and distros for each container. While I have backup snapshots of all of these I figured it wouldn't hurt to create playbooks for them as well. Would like to add additional playbooks for installing/configuring the services they each provide in the future as I continue to learn.

### Proxmox Scripts

#### lxc-startup_arch.yml
#### lxc-startup_debian.yml

Thank you for checking out this repository. 
