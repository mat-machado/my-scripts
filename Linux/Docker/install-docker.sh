#! /bin/bash

# Check if the OS is Ubuntu
if [ ! -n "$(uname -a | grep Ubuntu)" ]; then
    echo "ERROR: Script only works on Ubuntu!"
    exit 1
fi

# Needs to run with sudo
if [ "$EUID" -ne 0 ]; then
    echo "ERROR: Please run as root!"
    exit 2
fi

command_exists() {
    command -v "$@" >/dev/null 2>&1
}

do_install() {
    echo "# Executing docker install script"
    echo ""

    if command_exists docker; then
        cat >&2 <<-"EOF"
			Warning: the "docker" command appears to already exist on this system.

			If you already have Docker installed, this script can cause trouble, which is
			why we"re displaying this warning and provide the opportunity to cancel the
			installation.

			If you installed the current Docker package using this script and are using it
			again to update Docker, you can safely ignore this message.

			You may press Ctrl+C now to abort this script.
		EOF
        (
            set -x
            sleep 20
        )
    fi

    sh_c="sh -c"
    pre_reqs="apt-transport-https ca-certificates curl gnupg lsb-release"
    download_url="https://download.docker.com"
    apt_repo="deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] $download_url/linux/ubuntu $(lsb_release -cs) stable"
    docker_pkgs="docker-ce docker-ce-cli containerd.io docker-compose-plugin docker-ce-rootless-extras"

    echo ""
    echo "# Initializing Docker install..."
    echo "It is not stuck! Just wait until the script close it self!!"
    $sh_c "apt-get update -qq >/dev/null"
    $sh_c "DEBIAN_FRONTEND=noninteractive apt-get install -y -qq $pre_reqs >/dev/null"
    $sh_c "mkdir -p /etc/apt/keyrings && chmod -R 0755 /etc/apt/keyrings"
    $sh_c "curl -fsSL \"$download_url/linux/ubuntu/gpg\" | gpg --dearmor --yes -o /etc/apt/keyrings/docker.gpg"
    $sh_c "chmod a+r /etc/apt/keyrings/docker.gpg"
    $sh_c "echo \"$apt_repo\" > /etc/apt/sources.list.d/docker.list"
    $sh_c "apt-get update -qq >/dev/null"
    $sh_c "DEBIAN_FRONTEND=noninteractive apt-get install -y -qq --no-install-recommends $docker_pkgs >/dev/null"
    $sh_c "groupadd docker"
    $sh_c "usermod -aG docker $USER"
    $sh_c "newgrp docker"
    $sh_c "systemctl enable docker.service >/dev/null"
    $sh_c "systemctl enable containerd.service >/dev/null"
}

do_install
echo ""
echo "Docker has been succesfully installed!"
echo ""
echo "Now logout and log in again to use Docker commands."
exit 0
