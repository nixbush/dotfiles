# Core Programs
alias vi '$EDITOR'

alias mkdir '/usr/bin/mkdir -p'
alias ls '/usr/bin/ls -lhAv --group-directories-first --color=auto'
alias rm '/usr/bin/trash-put'
alias cp '/usr/bin/cp -r'

alias tree '/usr/bin/tree -aCL 3 --gitignore --dirsfirst'

# Custom
alias purge '/usr/bin/rm -r'
alias hibernate '/usr/bin/systemctl hibernate'
alias vg '/usr/bin/valgrind --leak-check=full --show-reachable=no --keep-debuginfo=yes --track-origins=yes'
alias dotfiles '/usr/bin/git --git-dir=$HOME/.repos/dotfiles --work-tree=$HOME'
