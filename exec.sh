#!/bin/bash

set -e

END='\033[0m\n'
RED='\033[0;31m'
GRN='\033[0;32m'
CYN='\033[0;36m'

if [ "$EUID" -ne 0 ]; then
    printf $RED"Please run as root using sudo!"$END
    exit 1
fi

USER_HOME=$(eval printf ~$SUDO_USER)

cp -r etc /
cp -r usr /
sudo -u "$SUDO_USER" cp -r .bashrc "$USER_HOME"
sudo -u "$SUDO_USER" cp -r .bashrc.d "$USER_HOME"
sudo -u "$SUDO_USER" cp -r .config "$USER_HOME"
sudo -u "$SUDO_USER" cp -r .scripts "$USER_HOME"
dnf5 install -y --nogpgcheck --repofrompath 'terra,https://repos.fyralabs.com/terra$releasever' terra-release
dnf5 install -y \
    "https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm" \
    "https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm"
dnf5 install --allowerasing -y \
    baobab \
    btrfs-assistant \
    default-fonts \
    elisa-player \
    evince \
    fastfetch \
    ffmpeg \
    flatseal \
    gamescope \
    gimp \
    gnome-characters \
    gnome-font-viewer \
    gnome-logs \
    gnome-software \
    google-android-emoji-fonts \
    google-arimo-fonts \
    google-droid-fonts-all \
    google-go-fonts \
    google-noto-fonts-all \
    google-noto-sans-cjk-fonts \
    google-noto-sans-hk-fonts \
    google-noto-serif-cjk-fonts \
    google-roboto-fonts \
    google-roboto-mono-fonts \
    google-roboto-slab-fonts \
    google-rubik-fonts \
    google-tinos-fonts \
    gstreamer-plugins-espeak \
    gstreamer1-plugins-bad-freeworld \
    gstreamer1-plugins-ugly \
    inotify-tools \
    jetbrains-mono-fonts-all \
    jetbrainsmono-nerd-fonts \
    kvantum \
    libaacs \
    libavcodec-freeworld \
    libbdplus \
    libcurl-devel \
    libde265 \
    libdnf5-plugin-actions \
    libfreeaptx \
    libheif-freeworld \
    libmimic \
    libndi \
    libxcrypt-compat \
    loupe \
    material-icons-fonts \
    memtest86+ \
    mesa-va-drivers-freeworld \
    mesa-vdpau-drivers-freeworld \
    mesa-vulkan-drivers-freeworld.i686 \
    mesa-vulkan-drivers-freeworld.x86_64 \
    mission-center \
    mozilla-openh264 \
    pipewire-codec-aptx \
    qt5ct \
    qt6ct \
    rpmfusion-free-appstream-data \
    rpmfusion-free-obsolete-packages \
    rpmfusion-nonfree-appstream-data \
    rpmfusion-nonfree-obsolete-packages \
    rsms-inter-fonts \
    rsms-inter-vf-fonts \
    simple-scan \
    snapper \
    snapshot \
    steam \
    terminus-fonts \
    terminus-fonts-console \
    vlc \
    vlc-plugins-all \
    vlc-plugins-freeworld \
    x264 \
    x265 \
    yazi \
    zed 
dnf5 remove -y \
    cosmic-edit \
    cosmic-player \
    cosmic-store \
    gnome-system-monitor \
    im-chooser \
    nheko \
    okular \
    rhythmbox \
    system-config-language \
    thunderbird
dnf5 autoremove -y
dnf5 swap mesa-va-drivers mesa-va-drivers-freeworld -y
dnf5 swap mesa-vdpau-drivers mesa-vdpau-drivers-freeworld -y
dnf5 upgrade --refresh -y
dnf5 autoremove -y
systemctl disable NetworkManager-wait-online.service
plymouth-set-default-theme -R fedora-mac-style
dracut --regenerate-all -f
fastfetch
