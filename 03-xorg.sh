pacman -Sy --needed --noconfirm xorg-server xorg-apps xorg-xinit xorg-xkill xorg-xinput xf86-input-libinput mesa weston xorg-server-xwayland
modprobe uinput
pacman -S --asdeps --needed cairo fontconfig freetype2
