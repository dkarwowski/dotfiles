#!/usr/bin/env bash

# TODO: vimrc and nvim/init.vim should be merged together to be a common file.
files=(
  Xresources
  fehbg
  tmux.conf
  vimrc
  zshrc
)

configs=(
  base16-shell
  i3
  i3lock
  nvim
  polybar
  qutebrowser
  ranger
)

SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
  DIR="$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )"
  SOURCE="$(readlink "$SOURCE")"
  [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE" # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
DIR="$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )"

pushd $DIR

git submodule init
git submodule update

popd

pushd $DIR/st

git reset --hard HEAD
rm config.h
git apply ../st-personalized.patch
make
sudo make install
make clean
rm config.h
git reset --hard HEAD

popd

curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > /tmp/dein-installer.sh
sh /tmp/dein-installer.sh $HOME/.cache/dein

for file in ${files[*]}; do
  rm $HOME/.$file
  ln -s $DIR/$file $HOME/.$file
done

for config in ${configs[*]}; do
  rm -rf $HOME/.config/$config
  ln -s $DIR/$config $HOME/.config/$config
done

sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
