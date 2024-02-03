#!/bin/bash
cmds=$( printf "Poweroff\nReboot\nLogout\nSuspend\nHibernate\n" | tofi )

case $cmds in
   Poweroff)  exec systemctl poweroff;;
   Reboot)    exec systemctl reboot;;
   Logout)    kill -HUP $XDG_SESSION_PID;;
   Suspend)   exec systemctl suspend;;
   Hibernate) exec systemctl hibernate;;
   *)         exit 1;;
esac
