  pacman -S --needed --noconfirm bc rsync mlocate bash-completion pkgstats arch-wiki-lite zip unzip unrar p7zip lzop cpio avahi nss-mdns alsa-utils alsa-plugins pulseaudio pulseaudio-alsa ntfs-3g dosfstools exfat-utils f2fs-tools fuse fuse-exfat autofs mtpfs
  timedatectl set-ntp true
bash 03-xorg.sh

####### Extra Install
mkinitcpio -p linux
 pacman -S --needed --noconfirm  htop
