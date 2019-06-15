#!/bin/bash

for file in `find . -name "\.*" -type f`
do
	ln -s $HOME/dotfiles/$file $HOME/$file
done
