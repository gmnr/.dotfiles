#!/bin/bash
# simple script to install the preferred configurations in the new system
# change in the working directory of the files to be symlinked in the home 
cd $DOTFILES
echo "Fetching the list of files to be symlinked in the home directory"
files=`find ./.config -maxdepth 1 -type f -exec basename {} \; | grep -v .gitmodules` | grep -v .macos # all except .gitmodules
echo

# handle alacritty installation with special config
echo "Creating symlink for alacritty"
ln -s $DOTFILES/.config/alacritty/alacritty.yml ~/.config/alacritty/alacritty.yml 2> /dev/null

# handle vim special location
echo "Creating symlink for vim configuration"
ln -s $DOTFILES/nvim/ ~/.config/ 2> /dev/null

# create the symlinks for the files in the .dotfiles folder
for file in $files; do
    echo "Creating symlink for $file"
    ln -s $DOTFILES/.config/$file ~/$file 2> /dev/null
done

# if on mac prompt for loading preferred config
if [[ "$OSTYPE" == "darwin"* ]]; then
    echo
    echo "Do you want also to load the preferred config for mac?"
    read ans
    if [[ $ans == "yes" ]]; then
        ./$DOTFILES/.config/.macos
    else
        echo "Ok... exiting"
    fi
fi
