#!/bin/sh
choice=$(printf "Poweroff\nSuspend\nHibernate\nReboot" | tofi | tr '[:upper:]' '[:lower:]')
exec "$choice"
