#!/bin/bash

# LEGEND
# 0: Add repo and update
# 1.x: Installation
# 2.x: Removal
# 3.x: System level configurations


##### 0. Upadate and add additional package repositories #####
##### Basics #####

echo 'fastestmirror=1' | sudo tee -a /etc/dnf/dnf.conf
echo 'max_parallel_downloads=10' | sudo tee -a /etc/dnf/dnf.conf
echo 'deltarpm=true' | sudo tee -a /etc/dnf/dnf.conf

dnf update -y

##### 1.0 Firmware
fwupdmgr get-devices
fwupdmgr refresh --force
fwupdmgr get-updates
fwupdmgr update

# rpmfusion have packages which can't be made part of fedora because of licensing.
#dnf install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm -y
dnf install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm -y
#dnf install https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm -y
dnf install https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm -y
# VSCode is my favorite. I do Python, Go, and sometimes JavaScript
rpm --import https://packages.microsoft.com/keys/microsoft.asc -y
sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'
dnf check-update -y
dnf install dnf-plugins-core -y

dnf upgrade --refresh
dnf groupupdate core
dnf install -y rpmfusion-free-release-tainted
dnf install -y rpmfusion-nonfree-release-tainted 
dnf install -y dnf-plugins-core
dnf install -y *-firmware 

##### 1.1 Programming stuffs #####
dnf groupinstall "Development Tools" -y
dnf groupinstall "Container Management" -y
dnf groupinstall "Headless Management" -y
dnf groupinstall "Sound and Video" -y
dnf groupinstall "System Tools" -y
dnf groupinstall "Virtualization" -y
# vim-X11 because 'vim' package isn't compiled with X support (no global clipboard access)
dnf install vim-X11 code python3 python3-devel go docker -y

##### 1.2 Other utilities which comes in daily use #####
dnf install https://dl.google.com/linux/direct/google-chrome-stable_current_x86_64.rpm -y
dnf install vlc  -y
dnf install -y gstreamer1-plugins-{bad-*,good-*,ugly-*,base} gstreamer1-libav --exclude=gstreamer1-plugins-bad-free-devel ffmpeg gstreamer-ffmpeg
dnf install -y lame* --exclude=lame-devel 
dnf -y groupupdate sound-and-video

dnf config-manager --set-enabled fedora-cisco-openh264
dnf install -y gstreamer1-plugin-openh264 mozilla-openh264

dnf group upgrade --with-optional Multimedia

##### 1.3 Some eye candy #####
dnf install fira-code-fonts 'mozilla-fira*' 'google-roboto*' zsh bat -y

flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak update

dnf install -y snapd
ln -s /var/lib/snapd/snap /snap # for classic snap support

dnf -y install unzip p7zip p7zip-plugins unrar 

dnf -y install dropbox nautilus-dropbox 
dnf -y install gparted 

dnf install -y gnome-tweaks gnome-extensions-app

dnf install dnf-plugins-core

dnf -y install switchdesk switchdesk-gui

##### 2.1 Bloat removal #####
dnf remove firefox kwalletmanager 'calligra-*' kontact kmail korganizer kaddressbook -y

##### 3.1 System level configurations #####
systemctl start docker
systemctl enable docker
usermod -aG docker jonathan

dnf install barrier
