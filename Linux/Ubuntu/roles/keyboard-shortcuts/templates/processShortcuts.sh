#!/bin/bash
#This is a process specific shell script for key short cuts

#Will set the command name of the active window
ACTIVEWINDOW=$(ps -o comm= $(xprop -id $(xprop -root -f _NET_ACTIVE_WINDOW 0x " \$0\\n" _NET_ACTIVE_WINDOW | awk "{print \$2}") -f _NET_WM_PID 0c " \$0\\n" _NET_WM_PID | awk "{print \$2}"))

#Will switch tabs with logic based on the current process
switchtab() {
	case "$1" in
		'gnome-terminal') 
			if [ "$2" == "next" ]; then
				xdotool keyup 'Right' key 'Next'
			elif [ "$2" == "prior" ]; then
				xdotool keyup 'Left' key 'Prior'
			fi
			;;
		'chrome')
			if [ "$2" == "next" ]; then
				xdotool keyup 'Right' key 'Next'
			elif [ "$2" == "prior" ]; then
				xdotool keyup 'Left' key 'Prior'
			fi
			;;
		'firefox')
			if [ "$2" == "next" ]; then
				xdotool keyup 'Right' key 'Next'
			elif [ "$2" == "prior" ]; then
				xdotool keyup 'Left' key 'Prior'
			fi
			;;
		'nautilus')
			if [ "$2" == "next" ]; then
				xdotool keyup 'Right' key 'Next'
			elif [ "$2" == "prior" ]; then
				xdotool keyup 'Left' key 'Prior'
			fi
			;;
		*) 
			logger "In the switchtab shell script, there is no rule for program: $ACTIVEWINDOW"	
			;;
	esac
}

#Will create tabs with logic based on the current process
createtab() {
	case "$1" in
		'gnome-terminal') 
			xdotool keyup 't' key 'Shift+t'
			;;
		*) #Default - stop xbindkeys, send the keyboard event, then restart it again
			killall -9 xbindkeys && xdotool keyup 't' key 't' && xbindkeys -f /etc/xbindkeysrc
			;;
	esac
}


closetab() {
	case "$1" in
		'gnome-terminal') 
			xdotool keyup 'w' key 'Shift+w'
			;;
		*) #Default - stop xbindkeys, send the keyboard event, then restart it again
			killall -9 xbindkeys && xdotool keyup 'w' key 'w' && xbindkeys -f /etc/xbindkeysrc
			;;
	esac
}

#Main case statement
case "$1" in
	'switch-tab')
		switchtab $ACTIVEWINDOW $2
		;;
	'create-tab')
		createtab $ACTIVEWINDOW
		;;
	'close-tab')
		closetab $ACTIVEWINDOW
		;;
esac
