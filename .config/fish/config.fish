if status is-login
   # -------------------------
   # Environment Variables
   # -------------------------
   # Core Variables
   fish_add_path     ~/.local/bin
   set -gx LESS      \x2dFiJMRWXx3\x20\x2dz4
   set -gx EDITOR    nvim
   set -gx TERMINAL  footclient

   # XDG Variables
   set -gx XDG_CACHE_HOME  ~/.cache
   set -gx XDG_CONFIG_HOME ~/.config
   set -gx XDG_DATA_HOME   ~/.local/share
   set -gx XDG_STATE_HOME  ~/.local/share

   # Applications
   set -gx QT_QPA_PLATFORM wayland
   set -gx QT_QPA_PLATFORMTHEME qt5ct

   # -------------------------
   # Autostart Applications
   # -------------------------
   # Run Hyprland
   if test -z $DISPLAY; and test (tty) = "/dev/tty1"
      Hyprland &> $XDG_CACHE_HOME/hyprland/hyprland.log
   end
end

if status is-interactive
   # -------------------------
   # Autostart Applications
   # -------------------------
   if not set -q TMUX
      if tmux has-session -t $USER
         exec tmux attach-session -t $USER
      else
         tmux new-session -s $USER
      end
   end

   # -------------------------
   # Fish Configuration
   # -------------------------
   fish_vi_key_bindings

   # -------------------------
   # Aliases
   # -------------------------
   # Core Programs
   alias vi "$EDITOR"
   alias mkdir "/usr/bin/mkdir -p"
   alias ls "/usr/bin/ls -lhAv --group-directories-first --color=auto"
   alias rm "/usr/bin/trash-put"
   alias cp "/usr/bin/cp -r"
   alias tree "/usr/bin/tree -aCL 3 --gitignore --dirsfirst"

   # Custom
   alias purge "/usr/bin/rm -ri"
   alias hibernate "/usr/bin/systemctl hibernate"
   alias vg "/usr/bin/valgrind --leak-check=full --show-reachable=no --keep-debuginfo=yes --track-origins=yes"
   alias dotfiles "/usr/bin/git --git-dir=$HOME/.repos/dotfiles --work-tree=$HOME"
end
