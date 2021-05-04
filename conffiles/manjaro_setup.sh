#!/bin/bash
cat <<EOF>> ~/.zshrc
alias setpxy='export ALL_PROXY=http://127.0.0.1:8889'
alias unpxy='unset ALL_PROXY'
alias ls='ls --color=auto'
alias grep='grep --colour=auto'
alias egrep='egrep --colour=auto'
alias fgrep='fgrep --colour=auto'
EOF
source .zshrc
sudo pacman -S --noconfirm gvim neovim ibus-rime deepin-screenshot appimagelauncher doublecmd-gtk2 git python-pip curl wget python2-pip min brave virt-manager qemu libvirt  ebtables dnsmasq bridge-utils openbsd-netcat
setpxy
sudo pamac install --no-confirm syncthing-gtk-python3 xdman wechat-uos linuxqq minder-git visual-studio-code-bin utools wps-office-cn wps-office-mime-cn wps-office-mui-zh-cn ttf-wps-fonts skypeforlinux-stable-bin baidunetdisk-bin typora libguestfs
sed -i '/unix_sock_group/s/^#//' /etc/libvirt/libvirtd.conf
sed -i '/unix_sock_rw_perms/s/^#//' /etc/libvirt/libvirtd.conf
sudo usermod -a -G libvirt $(whoami)
sudo modprobe -r kvm_intel
sudo modprobe kvm_intel nested=1
sudo systemctl enable libvirtd --now
pip3 install --user flake8 jedi yapf isort autopep8 ansible==2.7.18
curl -sLf https://spacevim.org/cn/install.sh | bash
