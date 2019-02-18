EXCLUDE_FILES  = .git .gitmodules .gitignore .travis.yml
INSTALL_TARGET = $(wildcard .??*)
DOTFILES       = $(filter-out $(EXCLUDE_FILES), $(INSTALL_TARGET))
XDG_CONFIGS	   = mpv

CONFIG_DIR     = $(HOME)/.config
FISH_PATH	   = $(CONFIG_DIR)/fish
NVIM_PATH      = $(CONFIG_DIR)/nvim
INIT_VIM_PATH  = $(NVIM_PATH)/init.vim

NVIM_BACKUP_PATH = $(NVIM_PATH)/backup
NVIM_COLOR_PATH  = $(NVIM_PATH)/colors

VIM_COLOR_SCHEME_ORIG = $(NVIM_PATH)/bundle/repos/github.com/apribase/ap_dark8/ap_dark8.vim
VIM_COLOR_SCHEME_TARG = $(NVIM_COLOR_PATH)/ap_dark8.vim

.PHONY: deploy init list

$(CONFIG_DIR):
	mkdir -p $@

$(NVIM_PATH):
	ln -sfnv $(PWD)/.vim $@

$(NVIM_BACKUP_PATH): | $(NVIM_PATH)
	mkdir -p $@

$(NVIM_COLOR_PATH): | $(NVIM_PATH)
	mkdir -p $@

$(INIT_VIM_PATH): | $(NVIM_PATH)
	ln -sfnv $(HOME)/.vimrc $@

$(FISH_PATH):
	ln -sfnv $(PWD)/fish $@

$(VIM_COLOR_SCHEME_TARG): | $(NVIM_COLOR_PATH)
	ln -sfnv $(VIM_COLOR_SCHEME_ORIG) $@

deploy: init
	@$(foreach val, $(DOTFILES), ln -sfnv $(abspath $(val)) $(HOME)/$(val);)
	@$(foreach val, $(XDG_CONFIGS), ln -sfnv $(abspath $(val)) $(CONFIG_DIR)/$(val);)

init: $(CONFIG_DIR) $(INIT_VIM_PATH) $(NVIM_BACKUP_PATH) $(VIM_COLOR_SCHEME_TARG) $(FISH_PATH)

uninstall:
	@unlink $(INIT_VIM_PATH)
	@unlink $(NVIM_PATH)
	@$(foreach val, $(DOTFILES), unlink $(HOME)/$(val);)
	@$(foreach val, $(XDG_CONFIGS), unlink $(CONFIG_DIR)/$(val);)

list:
	@$(foreach val, $(DOTFILES), /bin/ls -dF $(val);)
