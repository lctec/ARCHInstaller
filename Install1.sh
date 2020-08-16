#### Se instalaran programas automaticamente
pacman -Sy
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


#### Se instalaran programas automaticamente  desde AUR
pamac build gotop --no-confirm
pamac build google.chrome --no-confirm
pamac build google-drive-ocamlfuse --no-confirm
