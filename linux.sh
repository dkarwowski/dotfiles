#!/bin/bash

# Grab all of the various config files I've built up so far and throw them into this folder
if [[ $1 == "pull" ]]; then
    cp -R $HOME/.config/i3 .
    cp -R $HOME/.config/base16-* .
    cp -R $HOME/.config/mpd .
    cp -R $HOME/.config/ncmpcpp .
    cat $HOME/.zshrc > ./zshrc
    cat $HOME/.Xresources > ./Xresources
    cat $HOME/.vimrc > ./vimrc
    cat $HOME/.xbindkeysrc > ./xbindkeysrc
    cat $HOME/.xinitrc > ./xinitrc
    cat $HOME/.fehbg > ./fehbg
elif [[ $1 == "push" ]]; then
    cp -R ./i3 $HOME/.config/i3
    cp -R ./base16-* $HOME/.config/
    cp -R ./mpd $HOME/.config/mpd
    cp -R ./ncmpcpp $HOME/.config/ncmpcpp
    cat ./zshrc > $HOME/.zshrc
    cat ./Xresources > $HOME/.Xresources
    cat ./vimrc > $HOME/.vimrc
    cat ./xbindkeysrc > $HOME/.xbindkeysrc
    cat ./xinitrc > $HOME/.xinitrc
    cat ./fehbg > $HOME/fehbg
elif [[ $1 == "clean" ]]; then
    rm -rf i3 base16-* mpd ncmpcpp
    rm zshrc Xresources vimrc xbindkeysrc xinitrc fehbg
else
    echo "Usage: linux.sh [push|pull]"
fi
