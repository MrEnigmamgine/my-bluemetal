#!/bin/bash

set -ouex pipefail

# Copy the contents of system_files/ of the git repo to /
cp -avf "/ctx/system_files"/. /

### Install packages

# Packages can be installed from any enabled yum repo on the image.
# RPMfusion repos are available by default in ublue main images
# List of rpmfusion packages can be found here:
# https://mirrors.rpmfusion.org/mirrorlist?path=free/fedora/updates/43/x86_64/repoview/index.html&protocol=https&redirect=1

# Declared this ways so that I can comment

my_list=(
    # Some apps I just want installed at the system level
    cockpit		    # The base image includes a bunch of plugins already and its a good tool.
    kde-partitionmanager    # Default on kinoite and it's good
    keepassxc		    # To use as secrets service
    tmux
    zsh
    # Virtualization tools
    libvirt
    qemu
    podman-compose
    # Niri
    niri
    noctalia
    
)


# this installs a package from fedora repos
dnf5 install -y "${my_list[@]}"


# Use a COPR Example:
#
# dnf5 -y copr enable ublue-os/staging
# dnf5 -y install package
# Disable COPRs so they don't end up enabled on the final image:
# dnf5 -y copr disable ublue-os/staging

#### Example for enabling a System Unit File

systemctl enable podman.socket
