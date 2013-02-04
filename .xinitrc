#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps

if [ -f $sysresources ]; then







    xrdb -merge $sysresources

fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then







    xrdb -merge "$userresources"

fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi


# start some nice programs


if [ -d /etc/X11/xinit/xinitrc.d ] ; then
	for f in /etc/X11/xinit/xinitrc.d/* ; do
		[ -x "$f" ] && . "$f"
	done
	unset f
fi


gnome-keyring-daemon > /tmp/myenv
while read $i
do
    export $i
done < /tmp/myenv
rm -f /tmp/myenv
export GNOME_DESKTOP_SESSION_ID=default

export GTK_IM_MODULE="uim"
export QT_IM_MODULE="xim"
export XMODIFIERS=@im='uim'
uim-xim &
udiskie &
sleep 3

export DE=xfce

#/usr/bin/dispwin -d0 /usr/share/color/thinkpad/TPLCD.ICM
/usr/bin/dispwin -d0 /usr/share/color/icc/Argyll/sRGB.icm

exec startxfce4
