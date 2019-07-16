#!/bin/bash
# simple script to install the preferred configurations in the new system


# initialize the variable that holds the dirctory
dir=~/.dotfiles

# change in the working directory of the files to be symlinked in the home 
echo "Changing to the $dir directory"
cd $dir
files=`find . -maxdepth 1 -type f -printf "%f\n" | grep -v .gitmodules`    # all except .gitmodules
echo "Fetched list of files to be symlinked"


# move any existing dotfiles in homedir to dotfiles_old directory, then create symlinks 
for file in $files; do
        echo "Creating symlink to $file in home directory."
        ln -s $dir/$file ~/$file 2> /dev/null
done
