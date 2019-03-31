#!/bin/bash
# simple script to install the preferred configurations in the new system

#!/bin/bash
############################
# This script creates symlinks from the home directory to any desired dotfiles in ~/.dotfiles
############################


dir=~/.dotfiles                    # dotfiles directory
files="profile tmux.conf inputrc vimrc alias gitconfig gitexcludes"    # list of files/folders to symlink in homedir

##########
# change to the dotfiles directory
echo "Changing to the $dir directory"
cd $dir
echo "...done"

# move any existing dotfiles in homedir to dotfiles_old directory, then create symlinks 
for file in $files; do
        echo "Creating symlink to $file in home directory."
        ln -s $dir/.$file ~/.$file 2> /dev/null
done
