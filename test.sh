#!/bin/bash
# FIX THIS ISSUES | NON-ACUTE
#shellcheck disable=SC1001,SC1091,SC2001,SC2010,SC2015,SC2034,SC2104,SC2154
#shellcheck disable=SC2154,SC2153,SC2155,SC2165,SC2167,SC2181,SC2207

: 'ATTENTION!:
--------------------------------------------------
|  Created by helmuthdu <helmuthdu@gmail.com>    |
|  Contributed by flexiondotorg                  |
|  Shellchecked by uniminin <uniminin@zoho.com>  |
--------------------------------------------------
This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.
------------------------------------------------------------------------
Run this script after your first boot with archlinux (as root)
'

if [[ -f $(pwd)/sharedfuncs ]]; then
  source sharedfuncs
else
  echo "missing file: sharedfuncs"
  exit 1
fi

#ARCHLINUX U INSTALL {{{
#WELCOME {{{
welcome(){
  clear
  echo -e "${Bold}Welcome to the Archlinux U Install script by helmuthdu${White}"
  print_line
  echo "Requirements:"
  echo "-> Archlinux installation"
  echo "-> Run script as root user"
  echo "-> Working internet connection"
  print_line
  echo "Script can be cancelled at any time with CTRL+C"
  print_line
  echo "http://www.github.com/helmuthdu/aui"
  print_line
  echo -e "\nBackups:"
  print_line
  # backup old configs
  [[ ! -f /etc/pacman.conf.aui ]] && cp -v /etc/pacman.conf /etc/pacman.conf.aui || echo "/etc/pacman.conf.aui";
  [[ -f /etc/ssh/sshd_config.aui ]] && echo "/etc/ssh/sshd_conf.aui";
  [[ -f /etc/sudoers.aui ]] && echo "/etc/sudoers.aui";
  pause_function
  echo ""
}
#}}}
#LOCALE SELECTOR {{{
language_selector(){
  #AUTOMATICALLY DETECTS THE SYSTEM LOCALE {{{
  #automatically detects the system language based on your locale
  LOCALE=$(locale | grep LANG | sed 's/LANG=//' | cut -c1-5)
  #KDE #{{{
  if [[ $LOCALE == pt_BR || $LOCALE == en_GB || $LOCALE == zh_CN ]]; then
    LOCALE_KDE=$(echo "$LOCALE" | tr '[:upper:]' '[:lower:]')
  else
    LOCALE_KDE=$(echo "$LOCALE" | cut -d\_ -f1)
  fi
  #}}}
  #FIREFOX #{{{
  if [[ $LOCALE == pt_BR || $LOCALE == pt_PT || $LOCALE == en_GB || $LOCALE == en_US || $LOCALE == es_AR || $LOCALE == es_CL || $LOCALE == es_ES || $LOCALE == zh_CN ]]; then
    LOCALE_FF=$(echo "$LOCALE" | tr '[:upper:]' '[:lower:]' | sed 's/_/-/')
  else
    LOCALE_FF=$(echo "$LOCALE" | cut -d\_ -f1)
  fi
  #}}}
  #THUNDERBIRD #{{{
  if [[ $LOCALE == pt_BR || $LOCALE == pt_PT || $LOCALE == en_US || $LOCALE == en_GB || $LOCALE == es_AR || $LOCALE == es_ES || $LOCALE == zh_CN ]]; then
    LOCALE_TB=$(echo "$LOCALE" | tr '[:upper:]' '[:lower:]' | sed 's/_/-/')
  elif [[ $LOCALE == es_CL ]]; then
    LOCALE_TB="es-es"
  else
    LOCALE_TB=$(echo "$LOCALE" | cut -d\_ -f1)
  fi
  #}}}
  #HUNSPELL #{{{
  if [[ $LOCALE == pt_BR ]]; then
    LOCALE_HS=$(echo "$LOCALE" | tr '[:upper:]' '[:lower:]' | sed 's/_/-/')
  elif [[ $LOCALE == pt_PT ]]; then
    LOCALE_HS="pt_pt"
  else
    LOCALE_HS=$(echo "$LOCALE" | cut -d\_ -f1)
  fi
  #}}}
  #ASPELL #{{{
  LOCALE_AS=$(echo "$LOCALE" | cut -d\_ -f1)
  #}}}
  #LIBREOFFICE #{{{
  if [[ $LOCALE == pt_BR || $LOCALE == en_GB || $LOCALE == en_US || $LOCALE == zh_CN ]]; then
    LOCALE_LO=$(echo "$LOCALE" | sed 's/_/-/')
  else
    LOCALE_LO=$(echo "$LOCALE" | cut -d\_ -f1)
  fi
  #}}}
  #}}}
  print_title "LOCALE - https://wiki.archlinux.org/index.php/Locale"
  print_info "Locales are used in Linux to define which language the user uses. As the locales define the character sets being used as well, setting up the correct locale is especially important if the language contains non-ASCII characters."
  printf "%s" "Default system language: \"$LOCALE\" [Y/n]: " 
  read -r OPTION
  case "$OPTION" in
    "n")
      while [[ $OPTION != y ]]; do
        setlocale
        read_input_text "Confirm locale ($LOCALE)"
      done
      sed -i '/'"${LOCALE}"'/s/^#//' /etc/locale.gen
      locale-gen
      localectl set-locale LANG="${LOCALE_UTF8}"
      #KDE #{{{
      if [[ $LOCALE == pt_BR || $LOCALE == en_GB || $LOCALE == zh_CN ]]; then
        LOCALE_KDE=$(echo "$LOCALE" | tr '[:upper:]' '[:lower:]')
      else
        LOCALE_KDE=$(echo "$LOCALE" | cut -d\_ -f1)
      fi
      #}}}
      #FIREFOX #{{{
      if [[ $LOCALE == pt_BR || $LOCALE == pt_PT || $LOCALE == en_GB || $LOCALE == en_US || $LOCALE == es_AR || $LOCALE == es_CL || $LOCALE == es_ES || $LOCALE == zh_CN ]]; then
        LOCALE_FF=$(echo "$LOCALE" | tr '[:upper:]' '[:lower:]' | sed 's/_/-/')
      else
        LOCALE_FF=$(echo "$LOCALE" | cut -d\_ -f1)
      fi
      #}}}
      #THUNDERBIRD #{{{
      if [[ $LOCALE == pt_BR || $LOCALE == pt_PT || $LOCALE == en_US || $LOCALE == en_GB || $LOCALE == es_AR || $LOCALE == es_ES || $LOCALE == zh_CN ]]; then
        LOCALE_TB=$(echo "$LOCALE" | tr '[:upper:]' '[:lower:]' | sed 's/_/-/')
      elif [[ $LOCALE == es_CL ]]; then
        LOCALE_TB="es-es"
      else
        LOCALE_TB=$(echo "$LOCALE" | cut -d\_ -f1)
      fi
      #}}}
      #HUNSPELL #{{{
      if [[ $LOCALE == pt_BR ]]; then
        LOCALE_HS=$(echo "$LOCALE" | tr '[:upper:]' '[:lower:]' | sed 's/_/-/')
      elif [[ $LOCALE == pt_PT ]]; then
        LOCALE_HS="pt_pt"
      else
        LOCALE_HS=$(echo "$LOCALE" | cut -d\_ -f1)
      fi
      #}}}
      #ASPELL #{{{
      LOCALE_AS=$(echo "$LOCALE" | cut -d\_ -f1)
      #}}}
      #LIBREOFFICE #{{{
      if [[ $LOCALE == pt_BR || $LOCALE == en_GB || $LOCALE == en_US || $LOCALE == zh_CN ]]; then
        LOCALE_LO=$(echo "$LOCALE" | sed 's/_/-/')
      else
        LOCALE_LO=$(echo "$LOCALE" | cut -d\_ -f1)
      fi
      #}}}
      ;;
    *)
      ;;
  esac
}
#}}}
#SELECT/CREATE USER {{{
select_user(){
  #CREATE NEW USER {{{
  create_new_user(){
    printf "%s" "Username: "
    read -r username
    username=$(echo "$username" | tr '[:upper:]' '[:lower:]')
    useradd -m -g users -G wheel -s /bin/bash "${username}"
    chfn "${username}"
    passwd "${username}"
    while [[ $? -ne 0 ]]; do
      passwd "${username}"
    done
    pause_function
    configure_user_account
  }
  #}}}
  #CONFIGURE USER ACCOUNT {{{
  configure_user_account(){
    #BASHRC {{{
    print_title "BASHRC - https://wiki.archlinux.org/index.php/Bashrc"
    bashrc_list=("Get helmuthdu .bashrc from github" "Vanilla .bashrc" "Get personal .bashrc from github");
    PS3="$prompt1"
    echo -e "Choose your .bashrc\n"
    select OPT in "${bashrc_list[@]}"; do
      case "$REPLY" in
        1)
          package_install "git"
          package_install "colordiff"
          git clone https://github.com/helmuthdu/dotfiles
          cp dotfiles/.bashrc dotfiles/.dircolors dotfiles/.dircolors_256 dotfiles/.nanorc dotfiles/.yaourtrc ~/
          cp dotfiles/.bashrc dotfiles/.dircolors dotfiles/.dircolors_256 dotfiles/.nanorc dotfiles/.yaourtrc /home/"${username}"/
          rm -fr dotfiles
          ;;
        2)
          cp /etc/skel/.bashrc /home/"${username}"
          ;;
        3)
          package_install "git"
          printf "%s" "Enter your github username [ex: helmuthdu]: " 
          read -r GITHUB_USER
          printf "%s" "Enter your github repository [ex: aui]: "
          read -r GITHUB_REPO
          git clone https://github.com/"$GITHUB_USER"/"$GITHUB_REPO"
          cp -R "$GITHUB_REPO"/.* /home/"${username}"/
          rm -fr "$GITHUB_REPO"
          ;;
        *)
          invalid_option
          ;;
      esac
      [[ -n $OPT ]] && break
    done
    #}}}
    #EDITOR {{{
    print_title "DEFAULT EDITOR"
    editors_list=("emacs" "nano" "vi" "vim" "neovim" "zile");
    PS3="$prompt1"
    echo -e "Select editor\n"
    select EDITOR in "${editors_list[@]}"; do
      if contains_element "$EDITOR" "${editors_list[@]}"; then
        if [[ $EDITOR == vim || $EDITOR == neovim ]]; then
          [[ $EDITOR == vim ]] && (! is_package_installed "gvim" && package_install "vim ctags") || package_install "neovim python2-neovim python-neovim xclip"
          #VIMRC {{{
          if [[ ! -f /home/${username}/.vimrc ]]; then
            vimrc_list=("Get helmuthdu .vimrc from github" "Vanilla .vimrc" "Get personal .vimrc from github");
            PS3="$prompt1"
            echo -e "Choose your .vimrc\n"
            select OPT in "${vimrc_list[@]}"; do
              case "$REPLY" in
                1)
                  package_install "git"
                  git clone https://github.com/helmuthdu/vim /home/"${username}"/.vim
                  ln -sf /home/"${username}"/.vim/vimrc /home/"${username}"/.vimrc
                  cp -R vim /home/"${username}"/.vim/fonts /home/"${username}"/.fonts
                  GRUVBOX_NEEDED=1
                  ;;
                3)
                  package_install "git"
                  printf "%s" "Enter your github username [ex: helmuthdu]: "
                  read -r GITHUB_USER
                  printf "%s" "Enter your github repository [ex: vim]: "
                  read -r GITHUB_REPO
                  git clone https://github.com/"$GITHUB_USER"/"$GITHUB_REPO"
                  cp -R "$GITHUB_REPO"/.vim /home/"${username}"/
                  if [[ -f $GITHUB_REPO/vimrc ]]; then
                    ln -sf /home/"${username}"/.vim/vimrc /home/"${username}"/.vimrc
                  else
                    ln -sf /home/"${username}"/.vim/.vimrc /home/"${username}"/.vimrc
                  fi
                  rm -fr "$GITHUB_REPO"
                  ;;
                2)
                  echo "Nothing to do..."
                  ;;
                *)
                  invalid_option
                  ;;
              esac
              [[ -n $OPT ]] && break
            done
          fi
          if [[ $EDITOR == neovim  && ! -f /home/${username}/.config/nvim ]]; then
            mkdir ~/.config
            ln -s ~/.vim ~/.config/nvim
            ln -s ~/.vimrc ~/.config/nvim/init.vim
          fi
          #}}}
        elif [[ $EDITOR == emacs ]]; then
            package_install "emacs"
            #.emacs.d{{{
            if [[ ! -d /home/${username}/.emacs.d && ! -f /home/${username}/.emacs ]]; then
                emacsd_list=("Spacemacs" "Centaur Emacs" "Vanilla .emacs.d" "Get personal .emacs.d from github");
                PS3="$prompt1"
                echo -e "Choose your .emacs.d\n"
                select OPT in "${emacsd_list[@]}"; do
                    case "$REPLY" in
                        1)
                            package_install "git"
                            git clone https://github.com/syl20bnr/spacemacs /home/"${username}"/.emacs.d
                            ;;
                        2)
                            package_install "git"
                            git clone --depth 1 https://github.com/seagle0128/.emacs.d.git /home/"${username}"/.emacs.d
                            ;;
                        3)
                            package_install "git"
                            printf "%s" "Enter your github username [ex: helmuthdu]: "
                            read -r GITHUB_USER
                            printf "%s" "Enter your github repository [ex: vim]: "
                            read -r GITHUB_REPO
                            git clone https://github.com/"$GITHUB_USER"/"$GITHUB_REPO" /home/"${username}"/.emacs.d
                            ;;
                        4)
                            echo "Nothing to do..."
                            ;;
                        *)
                            invalid_option
                            ;;
                    esac
                    [[ -n $OPT ]] && break
                done
            fi
            #}}}
        else
            package_install "$EDITOR"
        fi
             break
      else
        invalid_option
      fi
    done
    #}}}
    chown -R "${username}":users /home/"${username}"
  }
  #}}}
  print_title "SELECT/CREATE USER - https://wiki.archlinux.org/index.php/Users_and_Groups"
  users_list=($(grep "/home" /etc/passwd | cut -d: -f1));
  PS3="$prompt1"
  echo "Avaliable Users:"
  if [[ $(( ${#users_list[@]} )) -gt 0 ]]; then
    print_warning "WARNING: THE SELECTED USER MUST HAVE SUDO PRIVILEGES"
  else
    echo ""
  fi
  select OPT in "${users_list[@]}" "Create new user"; do
    if [[ $OPT == "Create new user" ]]; then
      create_new_user
    elif contains_element "$OPT" "${users_list[@]}"; then
      username=$OPT
    else
      invalid_option
    fi
    [[ -n $OPT ]] && break
  done
  [[ ! -f /home/${username}/.bashrc ]] && configure_user_account;
  if [[ -n "$http_proxy" ]]; then
    echo "proxy = $http_proxy" > /home/"${username}"/.curlrc
    chown "${username}":users /home/"${username}"/.curlrc
  fi
}
#}}}
#CONFIGURE SUDO {{{
configure_sudo(){
  if ! is_package_installed "sudo" ; then
    print_title "SUDO - https://wiki.archlinux.org/index.php/Sudo"
    package_install "sudo"
  fi
  #CONFIGURE SUDOERS {{{
  if [[ ! -f  /etc/sudoers.aui ]]; then
    cp -v /etc/sudoers /etc/sudoers.aui
    ## Uncomment to allow members of group wheel to execute any command
    sed -i '/%wheel ALL=(ALL) ALL/s/^#//' /etc/sudoers
    ## Same thing without a password (not secure)
    #sed -i '/%wheel ALL=(ALL) NOPASSWD: ALL/s/^#//' /etc/sudoers

    #This config is especially helpful for those using terminal multiplexers like screen, tmux, or ratpoison, and those using sudo from scripts/cronjobs:
    {
        echo ""
        echo 'Defaults !requiretty, !tty_tickets, !umask'
        echo 'Defaults visiblepw, path_info, insults, lecture=always'
        echo 'Defaults loglinelen=0, logfile =/var/log/sudo.log, log_year, log_host, syslog=auth'
        echo 'Defaults passwd_tries=3, passwd_timeout=1'
        echo 'Defaults env_reset, always_set_home, set_home, set_logname'
        echo 'Defaults !env_editor, editor="/usr/bin/vim:/usr/bin/vi:/usr/bin/nano"'
        echo 'Defaults timestamp_timeout=15'
        echo 'Defaults passprompt="[sudo] password for %u: "'
        echo 'Defaults lecture=never'
    } >> /etc/sudoers
  fi
  #}}}
}
#}}}
#AUR HELPER {{{
choose_aurhelper(){
  print_title "AUR HELPER - https://wiki.archlinux.org/index.php/AUR_Helpers"
  print_info "AUR Helpers are written to make using the Arch User Repository more comfortable."
  print_warning "\tNone of these tools are officially supported by Arch devs."
  aurhelper=("trizen" "yay" "aurman" "aura" "pikaur")
  PS3="$prompt1"
  echo -e "Choose your default AUR helper to install\n"
  select OPT in "${aurhelper[@]}"; do
    case "$REPLY" in
      1)
        if ! is_package_installed "trizen" ; then
          package_install "base-devel git perl"
          aui_download_packages "trizen"
          if ! is_package_installed "trizen" ; then
            echo "trizen not installed. EXIT now"
            pause_function
            exit 0
          fi
        fi
        AUR_PKG_MANAGER="trizen"
        ;;
      2)
        if ! is_package_installed "yay" ; then
          package_install "base-devel git go"
          pacman -D --asdeps go
          aui_download_packages "yay"
          if ! is_package_installed "yay" ; then
            echo "yay not installed. EXIT now"
            pause_function
            exit 0
          fi
        fi
        AUR_PKG_MANAGER="yay"
        ;;
      3)
        if ! is_package_installed "aurman" ; then
          package_install "base-devel git expac python pyalpm python-requests python-feedparser python-regex python-dateutil"
	  git clone https://github.com/polygamma/aurman.git
	  python3 aurman/setup.py install
	  rm -rf aurman
          if ! is_package_installed "aurman" ; then
            echo "aurman not installed. EXIT now"
            pause_function
            exit 0
          fi
        fi
        AUR_PKG_MANAGER="aurman"
        ;;
      4)
        if ! is_package_installed "aura" ; then
          package_install "base-devel git stack"
          git clone https://github.com/fosskers/aura.git
          (
            cd aura || exit
            stack install -- aura
          )
          rm -rf aura
          if ! is_package_installed "aura" ; then
            echo "aura not installed. EXIT now"
            pause_function
            exit 0
          fi
        fi
        AUR_PKG_MANAGER="aura"
        ;;
      5)
        if ! is_package_installed "pikaur" ; then
          package_install "base-devel git"
          git clone https://aur.archlinux.org/pikaur.git
          (
            cd pikaur || exit
            makepkg -fsri
          )
          rm -rf pikaur
          if ! is_package_installed "pikaur" ; then
            echo "pikaur not installed. EXIT now"
            pause_function
            exit 0
          fi
        fi
        AUR_PKG_MANAGER="pikaur"
        ;;
      *)
        invalid_option
        ;;
    esac
    [[ -n $OPT ]] && break
  done
  pause_function
}
#}}}
#AUTOMODE {{{
automatic_mode(){
  print_title "AUTOMODE"
  print_info "Create a custom install with all options pre-selected.\nUse this option with care."
  print_danger "\tUse this mode only if you already know all the option.\n\tYou won't be able to select anything later."
  read_input_text "Enable Automatic Mode"
  if [[ $OPTION == y ]]; then
    $EDITOR "${AUI_DIR}"/lilo.automode
    # shellcheck source=/root/aui/lilo.automode
    source "${AUI_DIR}"/lilo.automode
    echo -e "The installation will start now."
    pause_function
    AUTOMATIC_MODE=1
  fi
}
#}}}
#CUSTOM REPOSITORIES {{{
add_custom_repositories(){
  print_title "CUSTOM REPOSITORIES - https://wiki.archlinux.org/index.php/Unofficial_User_Repositories"
  read_input_text "Add custom repositories" "$CUSTOMREPO"
  if [[ $OPTION == y ]]; then
    while true
    do
      print_title "CUSTOM REPOSITORIES - https://wiki.archlinux.org/index.php/Unofficial_User_Repositories"
      echo " 1) \"Add new repository\""
      echo ""
      echo " d) DONE"
      echo ""
      printf "%s" "$prompt1" OPTION
      case $OPTION in
        1)
          printf "%s" "Repository Name [ex: custom]: "
          read -r repository_name
          printf "%s" "Repository Address [ex: file:///media/backup/Archlinux]: " 
          read -r repository_addr
          add_repository "${repository_name}" "${repository_addr}" "Never"
          pause_function
          ;;
        "d")
          break
          ;;
        *)
          invalid_option
          ;;
      esac
    done
  fi
}
#}}}
#BASIC SETUP {{{
install_basic_setup(){
  print_title "BASH TOOLS - https://wiki.archlinux.org/index.php/Bash"
  package_install "bc rsync mlocate bash-completion pkgstats arch-wiki-lite"
  pause_function
  print_title "(UN)COMPRESS TOOLS - https://wiki.archlinux.org/index.php/P7zip"
  package_install "zip unzip unrar p7zip lzop cpio"
  pause_function
  print_title "AVAHI - https://wiki.archlinux.org/index.php/Avahi"
  print_info "Avahi is a free Zero Configuration Networking (Zeroconf) implementation, including a system for multicast DNS/DNS-SD discovery. It allows programs to publish and discovers services and hosts running on a local network with no specific configuration."
  package_install "avahi nss-mdns"
  is_package_installed "avahi" && system_ctl enable avahi-daemon.service
  pause_function
  print_title "ALSA - https://wiki.archlinux.org/index.php/Alsa"
  print_info "The Advanced Linux Sound Architecture (ALSA) is a Linux kernel component intended to replace the original Open Sound System (OSSv3) for providing device drivers for sound cards."
  package_install "alsa-utils alsa-plugins"
  pause_function
  print_title "PULSEAUDIO - https://wiki.archlinux.org/index.php/Pulseaudio"
  print_info "PulseAudio is the default sound server that serves as a proxy to sound applications using existing kernel sound components like ALSA or OSS"
  package_install "pulseaudio pulseaudio-alsa"
  pause_function
  print_title "NTFS/FAT/exFAT/F2FS - https://wiki.archlinux.org/index.php/File_Systems"
  print_info "A file system (or filesystem) is a means to organize data expected to be retained after a program terminates by providing procedures to store, retrieve and update data, as well as manage the available space on the device(s) which contain it. A file system organizes data in an efficient manner and is tuned to the specific characteristics of the device."
  package_install "ntfs-3g dosfstools exfat-utils f2fs-tools fuse fuse-exfat autofs mtpfs"
  pause_function
  print_title "SYSTEMD-TIMESYNCD - https://wiki.archlinux.org/index.php/Systemd-timesyncd"
  print_info "A file system (or filesystem) is a means to organize data expected to be retained after a program terminates by providing procedures to store, retrieve and update data, as well as manage the available space on the device(s) which contain it. A file system organizes data in an efficient manner and is tuned to the specific characteristics of the device."
  timedatectl set-ntp true
  pause_function
}
#}}}
#SSH {{{
install_ssh(){
  print_title "SSH - https://wiki.archlinux.org/index.php/Ssh"
  print_info "Secure Shell (SSH) is a network protocol that allows data to be exchanged over a secure channel between two computers."
  read_input_text "Install ssh" "$SSH"
  if [[ $OPTION == y ]]; then
    package_install "openssh"
    system_ctl enable sshd
    [[ ! -f /etc/ssh/sshd_config.aui ]] && cp -v /etc/ssh/sshd_config /etc/ssh/sshd_config.aui;
    #CONFIGURE SSHD_CONF #{{{
    sed -i '/Port 22/s/^#//' /etc/ssh/sshd_config
    sed -i '/Protocol 2/s/^#//' /etc/ssh/sshd_config
    sed -i '/HostKey \/etc\/ssh\/ssh_host_rsa_key/s/^#//' /etc/ssh/sshd_config
    sed -i '/HostKey \/etc\/ssh\/ssh_host_dsa_key/s/^#//' /etc/ssh/sshd_config
    sed -i '/HostKey \/etc\/ssh\/ssh_host_ecdsa_key/s/^#//' /etc/ssh/sshd_config
    sed -i '/KeyRegenerationInterval/s/^#//' /etc/ssh/sshd_config
    sed -i '/ServerKeyBits/s/^#//' /etc/ssh/sshd_config
    sed -i '/SyslogFacility/s/^#//' /etc/ssh/sshd_config
    sed -i '/LogLevel/s/^#//' /etc/ssh/sshd_config
    sed -i '/LoginGraceTime/s/^#//' /etc/ssh/sshd_config
    sed -i '/PermitRootLogin/s/^#//' /etc/ssh/sshd_config
    sed -i '/HostbasedAuthentication no/s/^#//' /etc/ssh/sshd_config
    sed -i '/StrictModes/s/^#//' /etc/ssh/sshd_config
    sed -i '/RSAAuthentication/s/^#//' /etc/ssh/sshd_config
    sed -i '/PubkeyAuthentication/s/^#//' /etc/ssh/sshd_config
    sed -i '/IgnoreRhosts/s/^#//' /etc/ssh/sshd_config
    sed -i '/PermitEmptyPasswords/s/^#//' /etc/ssh/sshd_config
    sed -i '/AllowTcpForwarding/s/^#//' /etc/ssh/sshd_config
    sed -i '/AllowTcpForwarding no/d' /etc/ssh/sshd_config
    sed -i '/X11Forwarding/s/^#//' /etc/ssh/sshd_config
    sed -i '/X11Forwarding/s/no/yes/' /etc/ssh/sshd_config
    sed -i -e '/\tX11Forwarding yes/d' /etc/ssh/sshd_config
    sed -i '/X11DisplayOffset/s/^#//' /etc/ssh/sshd_config
    sed -i '/X11UseLocalhost/s/^#//' /etc/ssh/sshd_config
    sed -i '/PrintMotd/s/^#//' /etc/ssh/sshd_config
    sed -i '/PrintMotd/s/yes/no/' /etc/ssh/sshd_config
    sed -i '/PrintLastLog/s/^#//' /etc/ssh/sshd_config
    sed -i '/TCPKeepAlive/s/^#//' /etc/ssh/sshd_config
    sed -i '/the setting of/s/^/#/' /etc/ssh/sshd_config
    sed -i '/RhostsRSAAuthentication and HostbasedAuthentication/s/^/#/' /etc/ssh/sshd_config
    #}}}
    pause_function
  fi
}
#}}}
#NFS {{{
install_nfs(){
  print_title "NFS - https://wiki.archlinux.org/index.php/Nfs"
  print_info "NFS allowing a user on a client computer to access files over a network in a manner similar to how local storage is accessed."
  read_input_text "Install nfs" "$NFS"
  if [[ $OPTION == y ]]; then
    package_install "nfs-utils"
    system_ctl enable rpcbind
    system_ctl enable nfs-client.target
    system_ctl enable remote-fs.target
    pause_function
  fi
}
#}}}
#ZSH {{{
install_zsh(){
  print_title "ZSH - https://wiki.archlinux.org/index.php/Zsh"
  print_info "Zsh is a powerful shell that operates as both an interactive shell and as a scripting language interpreter. "
  read_input_text "Install zsh" "$ZSH"
  if [[ $OPTION == y ]]; then
    package_install "zsh"
    read_input_text "Install oh-my-zsh" "$OH_MY_ZSH"
    if [[ $OPTION == y ]]; then
      if [[ -f /home/${username}/.zshrc ]]; then
        read_input_text "Replace current .zshrc file"
        if [[ $OPTION == y ]]; then
          run_as_user "mv /home/${username}/.zshrc /home/${username}/.zshrc.bkp"
          run_as_user "sh -c \"$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)\""
          run_as_user "$EDITOR /home/${username}/.zshrc"
        fi
      else
        run_as_user "sh -c \"$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)\""
        run_as_user "$EDITOR /home/${username}/.zshrc"
      fi
    fi
    pause_function
  fi
}
#}}}
#FISH {{{
install_fish(){
  print_title "fish - https://wiki.archlinux.org/index.php/fish"
  print_info "fish is a friendly interactive shell and a commandline shell intended to be interactive and user-friendly. "
  read_input_text "Install fish" "$FISH"
  if [[ $OPTION == y ]]; then
    package_install "fish"
    read_input_text "Install oh-my-fish" "$OH_MY_FISH"
    if [[ $OPTION == y ]]; then
      run_as_user "curl -L https://get.oh-my.fish | fish"
    fi
    pause_function
  fi
}
#}}}
#SAMBA {{{
install_samba(){
  print_title "SAMBA - https://wiki.archlinux.org/index.php/Samba"
  print_info "Samba is a re-implementation of the SMB/CIFS networking protocol, it facilitates file and printer sharing among Linux and Windows systems as an alternative to NFS."
  read_input_text "Install Samba" "$SAMBA"
  if [[ $OPTION == y ]]; then
    package_install "wget samba smbnetfs"
    [[ ! -f /etc/samba/smb.conf ]] && wget -q -O /etc/samba/smb.conf "https://git.samba.org/samba.git/?p=samba.git;a=blob_plain;f=examples/smb.conf.default;hb=HEAD"
    local CONFIG_SAMBA=$(grep usershare /etc/samba/smb.conf)
    if [[ -z $CONFIG_SAMBA ]]; then
      # configure usershare
      export USERSHARES_DIR="/var/lib/samba/usershare"
      export USERSHARES_GROUP="sambashare"
      mkdir -p ${USERSHARES_DIR}
      groupadd ${USERSHARES_GROUP}
      chown root:${USERSHARES_GROUP} ${USERSHARES_DIR}
      chmod 1770 ${USERSHARES_DIR}
      sed -i -e '/\[global\]/a\\n   usershare path = /var/lib/samba/usershare\n   usershare max shares = 100\n   usershare allow guests = yes\n   usershare owner only = False' /etc/samba/smb.conf
      sed -i -e '/\[global\]/a\\n   socket options = IPTOS_LOWDELAY TCP_NODELAY SO_KEEPALIVE\n   write cache size = 2097152\n   use sendfile = yes\n' /etc/samba/smb.conf
      usermod -a -G ${USERSHARES_GROUP} "${username}"
      sed -i '/user_allow_other/s/^#//' /etc/fuse.conf
      modprobe fuse
    fi
    echo "Enter your new samba account password:"
    pdbedit -a -u "${username}"
    while [[ $? -ne 0 ]]; do
      pdbedit -a -u "${username}"
    done
    # enable services
    system_ctl enable smb.service
    system_ctl enable nmb.service
    pause_function
  fi
}
#}}}
#READAHEAD {{{
enable_readahead(){
  print_title "Readahead - https://wiki.archlinux.org/index.php/Improve_Boot_Performance"
  print_info "Systemd comes with its own readahead implementation, this should in principle improve boot time. However, depending on your kernel version and the type of your hard drive, your mileage may vary (i.e. it might be slower)."
  read_input_text "Enable Readahead" "$READAHEAD"
  if [[ $OPTION == y ]]; then
    system_ctl enable systemd-readahead-collect
    system_ctl enable systemd-readahead-replay
    pause_function
  fi
}
#}}}
#ZRAM {{{
install_zram (){
  print_title "ZRAM - https://wiki.archlinux.org/index.php/Maximizing_Performance"
  print_info "Zram creates a device in RAM and compresses it. If you use for swap means that part of the RAM can hold much more information but uses more CPU. Still, it is much quicker than swapping to a hard drive. If a system often falls back to swap, this could improve responsiveness. Zram is in mainline staging (therefore its not stable yet, use with caution)."
  read_input_text "Install Zram" "$ZRAM"
  if [[ $OPTION == y ]]; then
    aur_package_install "zramswap"
    system_ctl enable zramswap
    pause_function
  fi
}
#}}}
#TLP {{{
install_tlp(){
  print_title "TLP - https://wiki.archlinux.org/index.php/Tlp"
  print_info "TLP is an advanced power management tool for Linux. It is a pure command line tool with automated background tasks and does not contain a GUI."
  read_input_text "Install TLP" "$TLP"
  if [[ $OPTION == y ]]; then
    package_install "tlp"
    system_ctl enable tlp.service
    system_ctl enable tlp-sleep.service
    system_ctl mask systemd-rfkill.service
    system_ctl mask systemd-rfkill.socket
    tlp start
    pause_function
  fi
}
#}}}
#XORG {{{
install_xorg(){
  print_title "XORG - https://wiki.archlinux.org/index.php/Xorg"
  print_info "Xorg is the public, open-source implementation of the X window system version 11."
  echo "Installing X-Server (req. for Desktopenvironment, GPU Drivers, Keyboardlayout,...)"
  package_install "xorg-server xorg-apps xorg-xinit xorg-xkill xorg-xinput xf86-input-libinput"
  package_install "mesa"
  modprobe uinput
  pause_function
}
#}}}
#WAYLAND {{{
install_wayland(){
  print_title "WAYLAND - https://wiki.archlinux.org/index.php/Wayland"
  print_info "Wayland is a protocol for a compositing window manager to talk to its clients, as well as a library implementing the protocol. "
  package_install "weston xorg-server-xwayland"
  pause_function
}
#}}}
#FONT CONFIGURATION {{{
font_config(){
  print_title "FONTS CONFIGURATION - https://wiki.archlinux.org/index.php/Font_Configuration"
  print_info "Fontconfig is a library designed to provide a list of available fonts to applications, and also for configuration for how fonts get rendered."
  pacman -S --asdeps --needed cairo fontconfig freetype2
  pause_function
}
#}}}
#VIDEO CARDS {{{
create_ramdisk_environment(){
  if [ "$(ls /boot | grep hardened -c)" -gt "0" ]; then
    mkinitcpio -p linux-hardened
  elif [ "$(ls /boot | grep lts -c)" -gt "0" ]; then
    mkinitcpio -p linux-lts
  elif [ "$(ls /boot | grep zen -c)" -gt "0" ]; then
    mkinitcpio -p linux-zen
  else
    mkinitcpio -p linux
  fi
}
install_video_cards(){
  package_install "dmidecode"
  print_title "VIDEO CARD"
  check_vga
  #Virtualbox {{{
  if [[ ${VIDEO_DRIVER} == virtualbox ]]; then
    if [ "$(lspci | grep 'VMware SVGA' -c)" -gt "0" ]; then
      package_install "xf86-video-vmware"
    fi
    if [ "$(ls /boot | grep hardened -c)" -gt "0" ] || [ "$(ls /boot | grep lts -c)" -gt "0" ]; then
      package_install "virtualbox-guest-dkms virtualbox-guest-utils mesa-libgl"
    else
      package_install "virtualbox-guest-modules-arch virtualbox-guest-utils mesa-libgl"
    fi
    add_module "vboxguest vboxsf vboxvideo" "virtualbox-guest"
    add_user_to_group "${username}" vboxsf
    system_ctl enable vboxservice
    create_ramdisk_environment
  #}}}
  #VMware {{{
  elif [[ ${VIDEO_DRIVER} == vmware ]]; then
    package_install "xf86-video-vmware xf86-input-vmmouse"
    if [ "$(ls /boot | grep hardened -c)" -gt "0" ] || [ "$(ls /boot | grep lts -c)" -gt "0" ]; then
      aur_package_install "open-vm-tools-dkms"
    else
      package_install "open-vm-tools"
    fi
    cat /proc/version > /etc/arch-release
    system_ctl enable vmtoolsd
    create_ramdisk_environment
  #}}}
  #Bumblebee {{{
  elif [[ ${VIDEO_DRIVER} == bumblebee ]]; then
    XF86_DRIVERS=$(pacman -Qe | grep xf86-video | awk '{print $1}')
    [[ -n $XF86_DRIVERS ]] && pacman -Rcsn "$XF86_DRIVERS"
    pacman -S --needed xf86-video-intel bumblebee nvidia
    [[ ${ARCHI} == x86_64 ]] && pacman -S --needed lib32-virtualgl lib32-nvidia-utils
    replace_line '*options nouveau modeset=1' '#options nouveau modeset=1' /etc/modprobe.d/modprobe.conf
    replace_line '*MODULES="nouveau"' '#MODULES="nouveau"' /etc/mkinitcpio.conf
    create_ramdisk_environment
    add_user_to_group "${username}" bumblebee
  #}}}
  #NVIDIA {{{
  elif [[ ${VIDEO_DRIVER} == nvidia ]]; then
    XF86_DRIVERS=$(pacman -Qe | grep xf86-video | awk '{print $1}')
    [[ -n $XF86_DRIVERS ]] && pacman -Rcsn "$XF86_DRIVERS"
    if [ "$(ls /boot | grep hardened -c)" -gt "0" ] || [ "$(ls /boot | grep lts -c)" -gt "0" ]; then
      package_install "nvidia-dkms nvidia-utils libglvnd"
      echo "Do not forget to make a mkinitcpio every time you updated the nvidia driver!"
    else
      package_install "nvidia nvidia-utils libglvnd"
    fi
    [[ ${ARCHI} == x86_64 ]] && pacman -S --needed lib32-nvidia-utils
    replace_line '*options nouveau modeset=1' '#options nouveau modeset=1' /etc/modprobe.d/modprobe.conf
    replace_line '*MODULES="nouveau"' '#MODULES="nouveau"' /etc/mkinitcpio.conf
    create_ramdisk_environment
    nvidia-xconfig --add-argb-glx-visuals --allow-glx-with-composite --composite --render-accel -o /etc/X11/xorg.conf.d/20-nvidia.conf;
  #}}}
  #Nouveau [NVIDIA] {{{
  elif [[ ${VIDEO_DRIVER} == nouveau ]]; then
    is_package_installed "nvidia" && pacman -Rdds --noconfirm nvidia{,-utils}
    [[ ${ARCHI} == x86_64 ]] && is_package_installed "lib32-nvidia-utils" && pacman -Rdds --noconfirm lib32-nvidia-utils
    [[ -f /etc/X11/xorg.conf.d/20-nvidia.conf ]] && rm /etc/X11/xorg.conf.d/20-nvidia.conf
    package_install "xf86-video-${VIDEO_DRIVER} mesa-libgl libvdpau-va-gl"
    replace_line '#*options nouveau modeset=1' 'options nouveau modeset=1' /etc/modprobe.d/modprobe.conf
    replace_line '#*MODULES="nouveau"' 'MODULES="nouveau"' /etc/mkinitcpio.conf
    create_ramdisk_environment
  #}}}
  #ATI {{{
  elif [[ ${VIDEO_DRIVER} == ati ]]; then
    [[ -f /etc/X11/xorg.conf.d/20-radeon.conf ]] && rm /etc/X11/xorg.conf.d/20-radeon.conf
    [[ -f /etc/X11/xorg.conf ]] && rm /etc/X11/xorg.conf
    package_install "xf86-video-${VIDEO_DRIVER} mesa-libgl mesa-vdpau libvdpau-va-gl"
    add_module "radeon" "ati"
    create_ramdisk_environment
  #}}}
  #AMDGPU {{{
  elif [[ ${VIDEO_DRIVER} == amdgpu ]]; then
    [[ -f /etc/X11/xorg.conf.d/20-radeon.conf ]] && rm /etc/X11/xorg.conf.d/20-radeon.conf
    [[ -f /etc/X11/xorg.conf ]] && rm /etc/X11/xorg.conf
    package_install "xf86-video-${VIDEO_DRIVER} vulkan-radeon mesa-libgl mesa-vdpau libvdpau-va-gl"
    add_module "amdgpu radeon" "ati"
    create_ramdisk_environment
  #}}}
  #Intel {{{
  elif [[ ${VIDEO_DRIVER} == intel ]]; then
    package_install "xf86-video-${VIDEO_DRIVER} mesa-libgl libvdpau-va-gl"
  #}}}
  #Vesa {{{
  else
    package_install "xf86-video-${VIDEO_DRIVER} mesa-libgl libvdpau-va-gl"
  fi
  #}}}
  if [[ ${ARCHI} == x86_64 ]]; then
    is_package_installed "mesa-libgl" && package_install "lib32-mesa-libgl"
    is_package_installed "mesa-vdpau" && package_install "lib32-mesa-vdpau"
  fi
  if is_package_installed "libvdpau-va-gl"; then
    add_line "export VDPAU_DRIVER=va_gl" "/etc/profile"
  fi
  pause_function
}
#}}}
