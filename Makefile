all: setup

setup:
	[ -d ~/.config ] || mkdir ~/.config
	[ -d ~/.config/zsh ] || mkdir -p ~/.config/zsh && ln -s $(PWD)/zsh/.zshrc ~/.config/zsh
	[ -f ~/.tmux.conf ] || ln -s $(PWD)/tmux/.tmux.conf ~
	ln -s $(PWD)/zsh/.zshenv ~
	ln -s $(PWD)/git/.gitconfig ~
	ln -s $(PWD)/nvim ~/.config/
	ln -s $(PWD)/kitty ~/.config/


.PHONY: all setup 
