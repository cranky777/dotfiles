#!/bin/bash

DOT_FILES=( .bash_profile .bashrc .gitconfig .gitignore .screenrc .vimrc .zshrc .zshrc.alias)

for file in ${DOT_FILES[@]}
do
	ln -s $HOME/dotfiles/$file $HOME/$file
done
