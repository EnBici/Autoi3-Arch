#!/bin/bash
if [ "$(whoami)" == "root" ]; then
    exit 1
fi

archivos=$(pwd)
FDIR="$HOME/.local/share/fonts"

#actualizamos los paquetes

sudo pacman -Syu

#instalamos todos los paquetes necesarios  

sudo pacman -S i3-wm polybar zsh awesome-terminal-fonts neofetch picom bat lsd locate imagemagick kitty  rofi git nano feh networkmanager flameshot thunar lightdm lightdm-gtk-greeter

#instalamos las fuentes para la polybar 

cp -f $archivos/fuentes/* "$FDIR"

#instalamos la polybar

mkdir $HOME/.local/
mkdir $HOME/.local/share/
mkdir $HOME/.local/share/fonts
cp -r $archivos/polybar $HOME/.config
chmod +x $HOME/.config/polybar/scripts/checkupdates
chmod +x $HOME/.config/polybar/scripts/updates.sh

#instalamos el archivo de configuracion de i3

sudo cp -r $archivos/i3 $HOME/.config

#instalamos el archivo de configuracion de picom

sudo cp $archivos/picom.conf /etc/xdg


#instalamos el tema de rofi y el archivo de colores de rofi (si queres lo podes cambiar mas tarde)

sudo cp  $archivos/rofi/launcher.rasi /usr/share/rofi/themes
sudo cp -r $archivos/shared /usr/share/rofi/themes
mkdir $HOME/.config/rofi
cp $archivos/rofi/config.rasi $HOME/.config/rofi

#copiamos el archivo de configuracion de la kitty para que no suene la puta campanita 
cp -r $archivos/kitty $HOME/.config

#instalamos zsh
cp $archivos/.zshrc $HOME/

sudo usermod --shell /usr/bin/zsh $USER

#instala zsh sudo-plugin

sudo mkdir /usr/share/zsh-sudo
sudo chown $USER:$USER /bin/share/zsh-sudo/
sudo cp $archivos/sudo.plugin.zsh /usr/share/zsh-sudo/

#instalamos lightdm para poder iniciar sesion de forma grafiaa

systemctl enable lightdm.service

#ponemos el wp del s4vi


cp $archivos/wp.jpg $HOME

#instalmos powerlevel10k
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $HOME/powerlevel10k
echo 'source ~/powerlevel10k/powerlevel10k.zsh-theme' >>~/.zshrc
zsh
