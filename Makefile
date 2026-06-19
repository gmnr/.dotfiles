-include hledger/.secret
-include sql/.secret

all: setup

setup:
	[ -d ~/.config ] || mkdir ~/.config
	[ -d ~/.config/zsh ] || mkdir -p ~/.config/zsh && ln -sf $(PWD)/zsh/.zshrc ~/.config/zsh
	[ -f ~/.tmux.conf ] || ln -sf $(PWD)/tmux/.tmux.conf ~
	ln -sf $(PWD)/zsh/.zshenv ~
	ln -sf $(PWD)/git/.gitconfig ~
	ln -sf $(PWD)/nvim ~/.config/
	ln -sf $(PWD)/kitty ~/.config/

ledger:
	ln -sf $(PWD)/hledger/.hledger.conf ~
	[ -d ~/.config/finance.git ] || mkdir ~/.config/finance.git
	git clone $(FIN_REPO) /tmp/.finance.git
	mv /tmp/.finance/.git ~/.config/finance.git
	rm -rf /tmp/.finance
	ln -sf ~/$(FIN_PATH) ~/.finance
	cat "gitdir: ~/.config/finance.git/.git" > ~/.finance/.git

sql:
	git clone $(DB_REPO) ~/$(DB_PATH)
	ln -s ~/$(DB_PATH) ~/.work_sql

.PHONY: all setup ledger sql
