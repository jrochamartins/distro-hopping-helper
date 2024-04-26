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
apt upgrade -y
apt dist-upgrade -y

echo -e "${C_YELLOW}\
----------------------------------------------- \n \
## Install applications \n \
----------------------------------------------- \n \
${C_RESET}"
apt install numlockx -y
apt install chromium -y
apt install steam:i386 -y
apt install dconf-editor -y
apt install git -y
apt install vlc -y

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
flatpak install flathub net.davidotek.pupgui2 -y
flatpak install flathub com.discordapp.Discord -y
flatpak install flathub md.obsidian.Obsidian -y
flatpak install flathub com.getpostman.Postman -y
flatpak install flathub com.bitwarden.desktop -y
flatpak update

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
gsettings set org.cinnamon.desktop.peripherals.touchpad send-events 'disabled'

echo -e "${C_YELLOW}\
----------------------------------------------- \n \
## Remove unused apps \n \
----------------------------------------------- \n \
${C_RESET}"
sudo apt autoremove --purge firefox -y
sudo apt autoremove --purge hexchat -y
sudo apt autoremove --purge thunderbird -y
sudo apt autoremove --purge celluloid -y
sudo apt autoremove --purge hypnotix -y
sudo apt autoremove --purge pix -y
sudo apt autoremove --purge rhythmbox -y
sudo apt autoremove --purge bulky -y
sudo apt autoremove --purge warpnator -y

echo -e "${C_YELLOW}\
----------------------------------------------- \n \
## Finishing \n \
----------------------------------------------- \n \
${C_RESET}"
apt autoclean
apt autoremove -y

echo -e "${C_GREEN}\
----------------------------------------------- \n \
## Finished! \n \
----------------------------------------------- \n \
${C_RESET}"
read -p "Do you want to restart your system now (Y/n)? " -n 1 -r
if [[ $REPLY =~ ^[Yy]$ ]]
then
    reboot
fi

# TODO
# Chromium preferences, copy Preferences to ~/.config/chromium/Default

# Install Nvidia Driver
# Set local Mint and Ubuntu repositories
# Configure timeshift
# install VSCode
# Increase vm.max_map_count

# Gerenciador de atualizações:
# Mudar para fonte refional repositorios do mint
# Mudar para fonte refional repositorios do ubuntu
# Remover repositorio de CD-ROM
# Configurar para apenas mostrar icone quando hover atualizações
# Ligar as automações de atualização

# Preferencias
# Ligar numlock na tela de login
# Centralizar caixa de login

# Chrome
# Fixar no painel
# substituir arquivo de preferencias

# Steam
# sudo dpkg --add-architecture i386
# sudo apt install steam-installer -y
# https://www.linuxcapable.com/how-to-install-steam-on-linux-mint/

# Remover espaços de trabalho
# Desativar VBlank no NVidia

#Remover



