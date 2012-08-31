# $FreeBSD: src/etc/root/dot.cshrc,v 1.30.16.2 2012/05/03 19:55:36 eadler Exp $
#
# .cshrc - csh resource script, read at beginning of execution by each shell
#
# see also csh(1), environ(7).
# more examples available at /usr/share/examples/csh/
#

alias h		history 25
alias j		jobs -l
alias ls	ls -G
alias la	ls -aF
alias lf	ls -FA
alias ll	ls -lAF

alias vi	vim
alias less	lv

# A righteous umask
umask 22

set path = (/sbin /bin /usr/sbin /usr/bin /usr/games /usr/local/sbin /usr/local/bin $HOME/bin)

setenv	EDITOR	vim
setenv	PAGER	lv
setenv	BLOCKSIZE	K

if ($?prompt) then
	# An interactive shell -- set some stuff up
	if ($uid == 0) then
		set user = root
	endif
	set prompt = "%n@%m:%/ %# "
	set promptchars = "%#"

	set filec
	set history = 1000
	set savehist = (1000 merge)
	set autolist = ambiguous
	# Use history to aid expansion
	set autoexpand
	set autorehash
	set mail = (/var/mail/$USER)
	if ( $?tcsh ) then
		bindkey "^W" backward-delete-word
		bindkey -k up history-search-backward
		bindkey -k down history-search-forward
	endif

endif

setenv VTK_DATA_ROOT /usr/local/share/exmaples/vtk/VTKData
setenv PACKAGEROOT ftp://ftp.jp.freebsd.org/
setenv PACKAGESITE ftp://ftp.jp.freebsd.org/pub/FreeBSD/ports/amd64/package-9.0-release/Latest/
setenv FTP_PASSIVE_MODE yes
