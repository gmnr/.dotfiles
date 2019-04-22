#!/bin/bash
# simple script to install the preferred configurations in the new system


# initialize the variable that holds the dirctory
dir=~/.dotfiles

# the files to be symlinked in the home directory
files="profile tmux.conf inputrc vimrc alias gitconfig gitexcludes"

# move into the directory (if you are working somewhere else)
echo "Changing to the $dir directory"
cd $dir
echo "...done"

# move any existing dotfiles in homedir to dotfiles_old directory, then create symlinks 
for file in $files; do
        echo "Creating symlink to $file in home directory."
        ln -s $dir/.$file ~/.$file 2> /dev/null
done
