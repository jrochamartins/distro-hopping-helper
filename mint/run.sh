#!/bin/bash

if [ $EUID -ne 0 ]; then
  echo "Este script deve ser executado com permissões de administrador, tente : sudo $0" 1>&2
  exit 1
fi

C_RESET=`tput init`
C_GREEN=`tput setaf 42`
C_YELLOW=`tput setaf 220`

echo -e "${C_YELLOW}\
----------------------------------------------- \n \
## Update caches and packages \n \
----------------------------------------------- \n \
${C_RESET}"
apt update
apt upgrade -y && apt dist-upgrade -y
flatpak update

echo -e "${C_YELLOW}\
----------------------------------------------- \n \
## Install Deb applications \n \
----------------------------------------------- \n \
${C_RESET}"
apt-get install -y \
          numlockx \
          chromium \
          steam:i386 \
          dconf-editor \          

# echo -e "${C_YELLOW}\
# ----------------------------------------------- \n \
# ## Install Dotnet \n \
# ----------------------------------------------- \n \
# ${C_RESET}"
# # Impedir que o dotnet seja obtido de archive.ubuntu.com \n \
# touch /etc/apt/preferences.d/dotnet.pref
# echo "Package: dotnet* aspnet* netstandard*" | tee -a /etc/apt/preferences.d/dotnet.pref > /dev/null
# echo "Pin: origin \"archive.ubuntu.com\"" | tee -a /etc/apt/preferences.d/dotnet.pref > /dev/null
# echo "Pin-Priority: -10" | tee -a /etc/apt/preferences.d/dotnet.pref > /dev/null
# # Instalar .net
# apt-get install -y dotnet-sdk-8.0

echo -e "${C_YELLOW}\
----------------------------------------------- \n \
## Install Flatpak applications \n \
----------------------------------------------- \n \
${C_RESET}"
flatpak install -y flathub \
          com.getpostman.Postman \
          com.discordapp.Discord \
          md.obsidian.Obsidian \
          org.videolan.VLC \
          net.davidotek.pupgui2

echo -e "${C_YELLOW}\
----------------------------------------------- \n \
## Create Home directories \n \
----------------------------------------------- \n \
${C_RESET}"
mkdir ~/bin
mkdir ~/Repos
mkdir ~/.themes

echo -e "${C_YELLOW}\
----------------------------------------------- \n \
## Setup aliases and symlinks \n \
----------------------------------------------- \n \
${C_RESET}"
# touch ~/.bash_aliases
# echo "alias gfp='git fetch && git pull'" >> ~/.bash_aliases
ln -s /usr/bin/gnome-calculator ~/bin/calc

echo -e "${C_YELLOW}\
----------------------------------------------- \n \
## Setup user envvar PATH \n \
----------------------------------------------- \n \
${C_RESET}"
echo "export PATH=\$PATH:$HOME/bin" >> ~/.bashrc

echo -e "${C_YELLOW}\
----------------------------------------------- \n \
## Apply initial desktop customizations \n \
----------------------------------------------- \n \
${C_RESET}"
gsettings set org.cinnamon.desktop.keybindings looking-glass-keybinding "[]"
gsettings set org.cinnamon.desktop.keybindings.wm panel-run-dialog "['<Super>r']"
gsettings set org.cinnamon.desktop.keybindings.media-keys screensaver "['<Super>l', 'XF86ScreenSaver']"
gsettings set org.cinnamon window-effect-speed "2"
gsettings set org.cinnamon.muffin unredirect-fullscreen-windows true
gsettings set org.cinnamon.desktop.peripherals.mouse accel-profile 'flat'

echo -e "${C_YELLOW}\
----------------------------------------------- \n \
## 18. Finishing \n \
----------------------------------------------- \n \
${C_RESET}"
apt update
apt upgrade -y
apt dist-upgrade -y
flatpak update
apt autoclean
apt autoremove -y

echo -e "${C_GREEN}\
----------------------------------------------- \n \
## Finished! \n \
----------------------------------------------- \n \
${C_RESET}"