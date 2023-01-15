EXCLUDE_FILES  = .git .gitmodules .gitignore .travis.yml
INSTALL_TARGET = $(wildcard .??*)
DOTFILES       = $(filter-out $(EXCLUDE_FILES), $(INSTALL_TARGET))
XDG_CONFIGS	   = mpv

CONFIG_DIR     = $(HOME)/.config
FISH_PATH	   = $(CONFIG_DIR)/fish
NVIM_PATH      = $(CONFIG_DIR)/nvim

.PHONY: deploy init list

$(CONFIG_DIR):
	mkdir -p $@

$(NVIM_PATH):
	ln -sfnv $(HOME)/nvim $@

$(FISH_PATH):
	ln -sfnv $(PWD)/fish $@

deploy: init
	@$(foreach val, $(DOTFILES), ln -sfnv $(abspath $(val)) $(HOME)/$(val);)
	@$(foreach val, $(XDG_CONFIGS), ln -sfnv $(abspath $(val)) $(CONFIG_DIR)/$(val);)

init: $(CONFIG_DIR) $(NVIM_PATH) $(FISH_PATH)

uninstall:
	@$(foreach val, $(DOTFILES), unlink $(HOME)/$(val);)
	@$(foreach val, $(XDG_CONFIGS), unlink $(CONFIG_DIR)/$(val);)

list:
	@$(foreach val, $(DOTFILES), /bin/ls -dF $(val);)
