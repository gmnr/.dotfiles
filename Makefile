# Dotfiles installer
-include hledger/.secret
-include sql/.secret

DOTFILES := $(HOME)/.dotfiles
CONFIG   := $(HOME)/.config
FIN_GIT  := $(CONFIG)/finance.git

# homebrew may not be on PATH yet on a fresh machine
export PATH := /opt/homebrew/bin:$(PATH)

# $(call link,SRC,DEST): move a real file/dir at DEST to DEST.bak, then symlink
define link
@if [ -e "$(2)" ] && [ ! -L "$(2)" ]; then mv "$(2)" "$(2).bak" && echo "backed up $(2) -> $(2).bak"; fi
@ln -sfn "$(1)" "$(2)" && echo "linked $(2)"
endef

all: install

install: brew link macos bat python nvim  ## everything that needs no secrets or sudo
	@echo "done: open a new kitty window to start tmux + zsh with the new config"

setup: install

help:  ## list the targets
	@awk -F ':.*## ' '/^[a-z-]+:.*## /{ printf "  %-10s %s\n", $$1, $$2 }' Makefile

brew:  ## install the packages in Brewfile
	@command -v brew >/dev/null || { echo "Homebrew is missing: install it from https://brew.sh, then run make again"; exit 1; }
	brew bundle --file=Brewfile

link:  ## symlink every config into place (real files are backed up to .bak)
	@if [ ! -e "$(DOTFILES)" ]; then ln -s "$(CURDIR)" "$(DOTFILES)" && echo "linked $(DOTFILES) -> $(CURDIR)"; \
	elif [ "$$(cd "$(DOTFILES)" && pwd -P)" != "$$(pwd -P)" ]; then echo "$(DOTFILES) exists and is a different folder"; exit 1; fi
	@mkdir -p "$(CONFIG)/zsh"
	$(call link,$(DOTFILES)/zsh/.zshenv,$(HOME)/.zshenv)
	$(call link,$(DOTFILES)/zsh/.zshrc,$(CONFIG)/zsh/.zshrc)
	$(call link,$(DOTFILES)/tmux/.tmux.conf,$(HOME)/.tmux.conf)
	$(call link,$(DOTFILES)/git/.gitconfig,$(HOME)/.gitconfig)
	$(call link,$(DOTFILES)/nvim,$(CONFIG)/nvim)
	$(call link,$(DOTFILES)/kitty,$(CONFIG)/kitty)

macos:  ## macOS preferences
	defaults write .GlobalPreferences AppleLocale en_IT

bat:  ## build bat's cache (tokyonight theme, ledger syntax)
	BAT_CONFIG_DIR="$(DOTFILES)/bat" bat cache --build

python:  ## uv-managed python as default python3, markitdown, hledger script env
	uv python install 3.15 --default
	uv tool install --managed-python --python 3.15 'markitdown==0.0.2'
	uv sync --project hledger

nvim:  ## install/update nvim plugins (lazy.nvim bootstraps itself)
	nvim --headless "+Lazy! sync" +qa

ledger: link  ## finance journal, hledger config, completion lists, crontab
	@[ -n "$(FIN_REPO)" ] && [ -n "$(FIN_PATH)" ] || { echo "hledger/.secret must define FIN_REPO and FIN_PATH"; exit 1; }
	$(call link,$(DOTFILES)/hledger/.hledger.conf,$(HOME)/.hledger.conf)
	@if [ -d "$(FIN_GIT)/.git" ]; then echo "finance repo already set up"; else \
	  git clone --no-checkout --separate-git-dir="$(FIN_GIT)/.git" "$(FIN_REPO)" "$(FIN_GIT)/clone" && \
	  rm "$(FIN_GIT)/clone/.git" && rmdir "$(FIN_GIT)/clone" && \
	  ln -sfn "$(HOME)/$(FIN_PATH)" "$(HOME)/.finance" && \
	  echo "gitdir: $(FIN_GIT)/.git" > "$(HOME)/.finance/.git" && \
	  git -C "$(HOME)/.finance" reset -q; fi
	@mkdir -p hledger/completion-source "$(HOME)/.finance/.logs"
	hledger -f "$(HOME)/.finance/all.journal" payees > hledger/completion-source/payees
	hledger -f "$(HOME)/.finance/all.journal" accounts | python3 hledger/scripts/filter-account.py > hledger/completion-source/accounts
	@crontab -l > "$(HOME)/.crontab.bak" 2>/dev/null || true
	sed 's|/Users/gmnr|$(HOME)|g' zsh/.installed-cron | crontab -

sql:  ## work SQL repo at ~/.work_sql
	@[ -n "$(DB_REPO)" ] && [ -n "$(DB_PATH)" ] || { echo "sql/.secret must define DB_REPO and DB_PATH"; exit 1; }
	@[ -d "$(HOME)/$(DB_PATH)" ] || git clone "$(DB_REPO)" "$(HOME)/$(DB_PATH)"
	$(call link,$(HOME)/$(DB_PATH),$(HOME)/.work_sql)

.PHONY: all install setup help brew link macos bat python nvim ledger sql

