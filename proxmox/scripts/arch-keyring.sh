#!/bin/bash
#
#
# for initializing arch containers

# initialize keyring
pacman-key --init

# populate keyring
pacman-key --populate

# refresh keyring
pacman-key --refresh-keys

