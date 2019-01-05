# better ls
alias ls='ls --color=always --time-style="+%d-%m-%Y" --group-directories-first'
alias l="ls -gholXN"
alias ll="ls -agholXN"

# preferred defaults
alias cp="cp -i" # ask when overwriting files
alias free="free -h" # show sizes in a human readable format
alias grep='grep --color=always' # use colors in grep
alias diff="diff --color=auto" # and diff
alias mkdir='mkdir -p -v' # make parent directories and tell us
alias df="df -h" # human-readable by default
function mcd() { mkdir $1; cd $1; }

# some common shortcuts
alias _='sudo'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

alias ff="fd --type f"
alias fd="fd --type d"

function del() {
    mv $@ ~/.local/share/Trash/files/
}

# easily create tar.gz archives, with progress bar
function tarczf () {
    tar cf - ${@:2} -P | pv -s $(du -sb ${@:2} | awk '{print $1}' | paste -sd+ - | bc) | gzip > $1
}

# easy pacman
alias pac='yay'
alias pacu='pac -Syu --combinedupgrade'
alias pacrm='pac -Rns'
alias pacss='pac -Ss'
alias pacs='pac -S'

# misc
alias octave='octave-cli' # who uses the gui anyway?

alias pdf='zathura'

# place space first so we ignore history (make sure HIST_IGNORE_SPACE is set)
alias rtorrent=" rtorrent"
alias rtor=" rtorrent"

alias git="hub"

alias rcp="rsync --verbose --human-readable --new-compress --archive --partial --progress"
alias rmv="rsync --verbose --human-readable --new-compress --archive --partial --progress --remove-source-files"

alias pf="peerflix --start --mpv"
alias dl='snatch --threads 4'
alias ytdl='youtube-dl -o"%(uploader)s -- %(title)s.%(ext)s"'
alias ytdlnr='youtube-dl -o"%(autonumber)s -- %(uploader)s -- %(title)s.%(ext)s"'

alias ytmp3='youtube-dl -x --audio-format mp3 -o"%(uploader)s -- %(title)s.%(ext)s"'

alias fm="ranger"
alias sl="streamlink --player=mpv"
alias myt="mpv --ytdl"
alias py="python"
alias qr="qrcode-terminal"

function myip() {
    local arg=$1

    local show_local=0
    local show_external=0

    if [[ $arg == "local" ]]; then
        show_local=1
    elif [[ $arg == "external" ]]; then
        show_external=1
    else
        show_local=1
        show_external=1
    fi

    if [[ $show_local -gt 0 ]]; then
        local local_ip=$(ifconfig wlp3s0 | grep inet | sed -n 1p | awk '{print $2}');
        echo "local: $local_ip";
    fi

    if [[ $show_external -gt 0 ]]; then
        # local external_ip=$(curl ipinfo.io &> /dev/null | sed -n 2p | sed 's/\"//g' | sed 's/\,//g' | awk '{print $2}');
        local external_ip=$(dig +short myip.opendns.com @resolver1.opendns.com)
        echo "external: $external_ip";
    fi
}

alias start_dnscrypt="_ dnscrypt-proxy -config /etc/dnscrypt-proxy/dnscrypt-proxy.toml"
alias start_xidlehook="xidlehook \
                       --time 10 \
                       --timer 'redshift -O 3500; slock' \
                       --notify 10 \
                       --notifier 'redshift -O 2800' \
                       --canceller 'redshift -O 3500' \
                       --not-when-fullscreen"

alias rtags='rc -J'
alias rtagsd='rdm'

alias cl++="clang++ -std=c++17 -stdlib=libstdc++"
alias cl++mj="cl++ -MJ compile_commands.json"
function fixmj () {
    if [ -z $1 ]
    then
        echo "usage: fixmj <compilation database file>";
        return;
    else
        sed -i -e '1s/^/[\n/' -e '$s/,$/\n]/' $1
    fi
}

alias dis="objdump -M intel -C -g -w -d"

alias cloc="tokei"
alias cook="cookiecutter"

# quick compile/run with test data for hackathons
function ccc {
    clear && clang++ -std=c++17 $1 -o $1.out && time cat test.in | ./$1.out
}

# figure out which terminal emulator we're inside of
# echo $TERM does not always work, because sometimes term lies
function whichterm() {
    ps -p $PPID | awk '{print $4}' | sed -n '2p'
}
# same goes for a shell
function whichshell() {
    ps -p "$$" | awk '{print $4}' | sed -n '2p'
}

# find the first thing for some search term on youtube and play/listen to it
function yt-listen() {
    mpv --no-video --ytdl-format=bestaudio ytdl://ytsearch:"$@"
}
function yt-view() {
    mpv ytdl://ytsearch:"$@"
}

alias latest="cat /home/jens/Dropbox/comm.txt | tail"

# create a note file for another file
function note() {
    if [ -z $1 ]
    then
        echo "usage: note <file>"
    else
        $EDITOR $1.note
    fi
}

alias mount_ramdisk="_ mount -t tmpfs -o size=1024m tmpfs /mnt/ramdisk"
alias umount_ramdisk="_ umount /mnt/ramdisk"