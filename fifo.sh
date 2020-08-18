loadkeys es
mount -o remount,size=2G /run/archiso/cowspace
pacman -Sy --needed --noconfirm git
git clone git://github.com/helmuthdu/aui
cd aui
bash fifo
