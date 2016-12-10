EXCLUDE_FILES  = .git .gitmodules .gitignore .travis.yml
INSTALL_TARGET = $(wildcard .??*)
DOTFILES       = $(filter-out $(EXCLUDE_FILES), $(INSTALL_TARGET))

CONFIG_DIR     = $(HOME)/.config
NVIM_PATH      = $(CONFIG_DIR)/nvim
INIT_VIM_PATH  = $(NVIM_PATH)/init.vim

list:
	@$(foreach val, $(DOTFILES), /bin/ls -dF $(val);)

init:
	@test -d $(CONFIG_DIR) || mkdir $(CONFIG_DIR)
	@test -L $(NVIM_PATH) || ln -sfnv $(HOME)/.vim $(NVIM_PATH)
	@test -L $(INIT_VIM_PATH) || ln -sfnv $(HOME)/.vimrc $(INIT_VIM_PATH)

deploy:
	@$(foreach val, $(DOTFILES), ln -sfnv $(abspath $(val)) $(HOME)/$(val);)

