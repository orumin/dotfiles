EXCLUDE_FILES  = .git .gitmodules .gitignore .travis.yml
INSTALL_TARGET = $(wildcard .??*)
DOTFILES       = $(filter-out $(EXCLUDE_FILES), $(INSTALL_TARGET))
XDG_CONFIGS	   = alacritty bat btop fish mpv nvim tmux

ifeq ($(OS),Windows_NT)
HOME = $(USERPROFILE)
endif

ifeq ($(strip $(XDG_CONFIG_HOME)),)
CONFIG_DIR = $(HOME)\.config
else
CONFIG_DIR = $(XDG_CONFIG_HOME)
endif

.PHONY: deploy init list

$(CONFIG_DIR):
	mkdir -p $@

deploy: init
	@$(foreach val, $(DOTFILES), make link SOURCE:="$(abspath $(val))" TARGET:="$(HOME)/$(val)";)
	@$(foreach val, $(XDG_CONFIGS), make dirlink SOURCE:="$(abspath $(val))" TARGET:="$(CONFIG_DIR)/$(val)";)

init: $(CONFIG_DIR)

uninstall:
	@$(foreach val, $(DOTFILES), unlink $(HOME)$(PATH_SEP)$(val))
	@$(foreach val, $(XDG_CONFIGS), unlink $(CONFIG_DIR)$(PATH_SEP)$(val))

list:
ifeq ($(OS),Windows_NT)
	@$(foreach val, $(DOTFILES), /bin/ls -dF $(val);)
else
	@$(foreach val, $(DOTFILES), cmd.exe /C dir $(val);)
endif

link:
ifeq ($(OS),Windows_NT)
	cmd.exe /C if not exist $(subst /,\,$(TARGET)) \
		cmd.exe /C mklink $(subst /,\,$(TARGET)) $(subst /,\,$(SOURCE))
else
	ln -sfnv $(SOURCE) $(TARGET)
endif

dirlink:
ifeq ($(OS),Windows_NT)
	cmd.exe /C if not exist $(subst /,\,$(TARGET)) \
		cmd.exe /C mklink /D $(subst /,\,$(TARGET)) $(subst /,\,$(SOURCE))
else
	ln -sfnv $(SOURCE) $(TARGET)
endif
