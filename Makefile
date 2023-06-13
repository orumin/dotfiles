EXCLUDE_FILES  = .git .gitmodules .gitignore .travis.yml
INSTALL_TARGET = $(wildcard .??*)
DOTFILES       = $(filter-out $(EXCLUDE_FILES), $(INSTALL_TARGET))
XDG_CONFIGS	   = alacritty bat btop fish mpv nvim tmux

CONFIG_DIR     = $(XDG_CONFIG_HOME)

.PHONY: deploy init list

$(CONFIG_DIR):
	mkdir -p $@

deploy: init
	@$(foreach val, $(DOTFILES), ln -sfnv $(abspath $(val)) $(HOME)/$(val);)
	@$(foreach val, $(XDG_CONFIGS), ln -sfnv $(abspath $(val)) $(CONFIG_DIR)/$(val);)

init: $(CONFIG_DIR)

uninstall:
	@$(foreach val, $(DOTFILES), unlink $(HOME)/$(val);)
	@$(foreach val, $(XDG_CONFIGS), unlink $(CONFIG_DIR)/$(val);)

list:
	@$(foreach val, $(DOTFILES), /bin/ls -dF $(val);)
