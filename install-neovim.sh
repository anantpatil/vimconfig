#!/usr/bin/env bash

# Install from repo
# This will only install stable version.
# On Ubuntu 16.04 it installs ancient version; not useful
# sudo add-apt-repository ppa:neovim-ppa/stable
# sudo apt-get update
# sudo apt-get install neovim

# Install using github release and add symbolic link
# e.g. nvim -> /opt/adminuser/squashfs-root/usr/bin/nvim
# Here nvim.appimage is extracted in home dir /opt/adminuser

# Make it as default
sudo update-alternatives --install /usr/bin/vi vi /usr/bin/nvim 60
sudo update-alternatives --config vi
sudo update-alternatives --install /usr/bin/vim vim /usr/bin/nvim 60
sudo update-alternatives --config vim
sudo update-alternatives --install /usr/bin/editor editor /usr/bin/nvim 60
sudo update-alternatives --config editor

# Make it fancy
sudo apt-get install python-dev python-pip python3-dev python3-pip curl vim exuberant-ctags git ack-grep
sudo pip install neovim pep8 flake8 pyflakes pylint isort
sudo pip3 install neovim pep8 flake8 pyflakes pylint isort

# Install Fuzzy search (fzf), Silver search (ag), ripgrep (rg)
# delta, bat etc tools
#
# Install fzf in ~/.fzf
# bat-musl_0.17.1_amd64.deb
# gcc-10-base_10.2.0-5ubuntu1~20.04_amd64.deb
# git-delta_0.6.0_amd64.deb
# libgcc-s1_10.2.0-5ubuntu1~20.04_amd64.deb
# ripgrep_12.1.1_amd64.deb# 
