# exports, common paths, etc.
export DOTFILESHOME=$HOME/.dotfiles
export ZSHHOME=$HOME/.zsh
export EDITOR="em" # emacsclient, this scripts starts the daemon if needed
# make gpg happy
export GPG_TTY=$(tty)
# ggtags config
export GTAGSLABEL="ctags"
export GTAGSCONF="$HOME/.globalrc"

export TIMEFMT=''$'\n%J'$'\n%U user | %S system | %P cpu | %*Es total'$'\n'\
'avg. shared (code):         %X KB'$'\n'\
'avg. unshared (data/stack): %D KB'$'\n'\
'total space usage:          %K KB'$'\n'\
'max memory usage:           %M KB'$'\n'\
'swaps:                      %W'$'\n'\
'major page faults (disk):   %F'$'\n'\
'minor page faults:          %R'

# add things to PATH
paths=("$DOTFILESHOME/bin"
       "$HOME/.cargo/bin"
       "$HOME/.roswell/bin")

for p in $paths; do
    export PATH=${PATH}:${p}
done