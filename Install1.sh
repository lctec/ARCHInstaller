#### Se instalaran programas automaticamente
pacman -Syu --noconfirm
pacman -S --needed --noconfirm htop
pacman -S --needed --noconfirm vim
pacman -S --needed --noconfirm smplayer
pacman -S --needed --noconfirm base-devel
pacman -S --needed --noconfirm qbittorrent
pacman -S --needed --noconfirm pamac
pacman -S --needed --noconfirm gparted
pacman -S --needed --noconfirm chromium
pacman -S --needed --noconfirm youtube-dl
pacman -S --needed --noconfirm remmina
pacman -S --needed --noconfirm openshot
pacman -S --needed --noconfirm neofetch
pacman -S --needed --noconfirm bleachbit
pacman -S --needed --noconfirm guake
pacman -S --needed --noconfirm

#### Se instalaran programas automaticamente  desde AUR
pamac build timeshift --no-confirm
pamac build gotop --no-confirm
pamac build google-chrome --no-confirm
pamac build google-drive-ocamlfuse --no-confirm
pamac build youtube-dl-gui-git --no-confirm
pamac build github-desktop --no-confirm
pamac build  --no-confirm
