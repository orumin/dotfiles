EXCLUDE_FILES  = .git .gitmodules .gitignore .travis.yml
INSTALL_TARGET = $(wildcard .??*)
DOTFILES       = $(filter-out $(EXCLUDE_FILES), $(INSTALL_TARGET))
XDG_CONFIGS	   = alacritty bat btop firenvim fish glamour mpv nvim skk tmux

ifeq ($(OS),Windows_NT)
	HOME := $(USERPROFILE)
	ifeq ($(MSYSTEM),)
		SHELL := pwsh.exe
	endif
endif

ifeq ($(strip $(XDG_CONFIG_HOME)),)
	ifeq ($(OS),Windows_NT)
		CONFIG_DIR := $(abspath $(HOME)\.config)
	else
		CONFIG_DIR := $(abspath $(HOME)/.config)
	endif
else
	CONFIG_DIR := $(abspath $(XDG_CONFIG_HOME))
endif

.PHONY: deploy init list

$(CONFIG_DIR):
	mkdir -p $@

deploy: init
	@$(foreach val, $(DOTFILES), make link SOURCE:="$(abspath $(val))" TARGET:="$(HOME)/$(val)";)
	@$(foreach val, $(XDG_CONFIGS), make link SOURCE:="$(abspath $(val))" TARGET:="$(CONFIG_DIR)/$(val)";)

deploy_win: init
	make link SOURCE:="$(abspath Microsoft.PowerShell_profile.ps1)" TARGET:="$(HOME)\Documents\PowerShell\Microsoft.PowerShell_profile.ps1"
	make link SOURCE:="$(abspath alacritty)" TARGET:="$(APPDATA)\alacritty"
	make link SOURCE:="$(abspath nvim)" TARGET:="$(LOCALAPPDATA)\nvim"
	make link SOURCE:="$(abspath firenvim)" TARGET:="$(LOCALAPPDATA)\firenvim"

init: $(CONFIG_DIR)

uninstall:
	@$(foreach val, $(DOTFILES), make unlink Value:="$(HOME)/$(val)";)
	@$(foreach val, $(XDG_CONFIGS), make unlink_dir Value:="$(CONFIG_DIR)/$(val)";)

uninstall_win:
	make unlink Value:="$(HOME)\Documents\PowerShell\Microsoft.PowerShell_profile.ps1"
	make unlink_dir Value:="$(APPDATA)\alacritty"
	make unlink_dir Value:="$(LOCALAPPDATA)\nvim"
	make unlink_dir Value:="$(LOCALAPPDATA)\firenvim"

list:
ifeq ($(OS),Windows_NT)
	@$(foreach val, $(DOTFILES), /bin/ls -dF $(val);)
else
	@$(foreach val, $(DOTFILES), cmd.exe /C dir $(val);)
endif

link:
ifeq ($(OS),Windows_NT)
	pwsh.exe -Command New-Item -Value $(subst /,\,$(SOURCE)) -Path $(subst /,\,$(TARGET)) -ItemType SymbolicLink -Force
else
	ln -sfnv $(SOURCE) $(TARGET)
endif

unlink:
ifeq ($(OS),Windows_NT)
	[System.IO.File]::Delete("$(subst /,\,$(Value))")
else
	unlink $(Value)
endif

unlink_dir:
ifeq ($(OS),Windows_NT)
	[System.IO.Directory]::Delete("$(subst /,\,$(Value))")
else
	unlink $(Value)
endif

gnome_term_catppuccin:
	curl -L https://raw.githubusercontent.com/catppuccin/gnome-terminal/v0.2.0/install.py | python3

