#!/bin/bash

rm -rf /tmp/FAKE_HOME/
pushd .
mkdir -p /tmp/FAKE_HOME/.vim
export HOME=/tmp/FAKE_HOME
#cp vimrc $HOME/.vimrc
# Strip colorscheme (which doesn't exist yet)
cat vimrc | grep -v colorscheme > $HOME/.vimrc

cd /tmp/FAKE_HOME

# Get vim-plug
curl -fLo $HOME/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
vim +PlugInstall +qa

tar zcf dotvim.tgz .vim
popd
cp /tmp/FAKE_HOME/dotvim.tgz .
