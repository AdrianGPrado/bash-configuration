#  ---------------------------------------------------------------------------
#
#  Description:  This file is bashrc.
#  Location:    ~/.bashrc
#  Loads:   with a non interactive shell.
#           (more or less: when you don't type user ans passd)
#
#  Sections:
#   1.   Environment Configuration
#   2.   Make Terminal Better (remapping defaults and adding functionality)
#   3.   File and Folder Management
#   4.   Brew configuration
#   5.   Searching
#   6.   Process Management
#   7.   Networking
#   8.   System Operations & Information
#   9.   Web Development
#  10.   Reminders & Notes
#  11.   Oracle Client Env. Variables


#   -------------------------------
#   1.  ENVIRONMENT CONFIGURATION
#   -------------------------------

#   Git branch in PS1
#   - Instalation instructions
#
#     - Create 'bash' diretory
#       $ mkdir -p $UNIX_CONFIG_FILES_PWD/bash_config/bash
#       $ ln -s $UNIX_CONFIG_FILES_PWD/bash_config/bash $HOME/.bash
#
#     - Clone repository:
#       $ git clone https://github.com/jimeh/git-aware-prompt.git ~/.bash
#
#     - Enjoy
#
#   ------------------------------------------------------------
export GITAWAREPROMPT=~/.bash/git-aware-prompt
source "${GITAWAREPROMPT}/main.sh"

#   Create variable with OS: Linux or Darwin(MacOS)
#   ------------------------------------------------------------
export OS="$(uname)"

#   Change Prompt
#   ------------------------------------------------------------
#export PS1="\[\033[36m\]\u\[\033[m\]@\[\033[32m\]\h: \[\033[33;1m\]\w\[\033[m\] :\n\$ "
#export PS1="\[\033[36m\]\u\[\033[m\]@\[\033[32m\]\h\[\033[m\]: \[\033[33;1m\]\w\[\033[m\]: \$git_branch:\n\$ "
export PS1="\[\033[38;5;6m\]\u\[$(tput sgr0)\]\[\033[38;5;15m\] @ \[$(tput sgr0)\]\[\033[38;5;34m\]\h\[$(tput sgr0)\]\[\033[38;5;15m\]: \[$(tput sgr0)\]\[\033[38;5;3m\]\w\[$(tput sgr0)\]\[\033[38;5;15m\]: \[$(tput sgr0)\]\[\033[38;5;117m\]\$git_branch\[$(tput sgr0)\]:\n\$ "

#   Add color to terminal
#   (this is all commented out as I use Mac Terminal Profiles)
#   from http://osxdaily.com/2012/02/21/add-color-to-the-terminal-in-mac-os-x/
#   ------------------------------------------------------------
export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad

#   Set Paths
#   ------------------------------------------------------------
export PATH=/Applications/*/Contents/MacOS/:$PATH
export PATH=/usr/local/bin:$PATH
export PATH=/usr/local/sbin:$PATH
export PATH=/usr/local/texbin:$PATH

#   Set Default Editor
#   ------------------------------------------------------------
export EDITOR=/usr/bin/vim


# #   -----------------------------
# #   2.  MAKE TERMINAL BETTER
# #   -----------------------------
if [ $OS = "Linux" ]; then
    #   If System is Linux
    #   ------------------------------------------------------------
    alias ls='ls --color -F'
    ## Get server cpu info ##
    alias cpuinfo='lscpu'
    alias md5='md5sum'
    alias free='free -m'
    alias ports='netstat -tulanp'
else
    #   If System is Linux
    #   ------------------------------------------------------------
    alias ls='ls -GF'
    alias ports='sudo lsof -i -n -P | grep TCP'
fi
#   Common Aliases
#   ------------------------------------------------------------
alias vi="vim"
alias edit="vim"
alias grep="grep -nE --color"
alias egrep="egrep --color=auto"
alias fgrep="fgrep --color=auto"
alias mkdir="mkdir -pv"
alias cp='cp -iv'                           # Preferred 'cp' implementation
alias cpr='cp -r'
alias mv='mv -iv'                           # Preferred 'mv' implementation
alias mkdir='mkdir -pv'                     # Preferred 'mkdir' implementation
alias ll='ls -FGlAhp'                       # Preferred 'ls' implementation
alias lx='ls -lhBX'        #sort by extension
alias lz='ls -lhrS'        #sort by size
alias lt='ls -lhrt'        #sort by date
alias less='less -FSRXc'                    # Preferred 'less' implementation
alias ll='ls -l'
alias la='ll -a'
alias cd..='cd ../'                         # Go back 1 directory level (for fast typers)
alias ..='cd ../'                           # Go back 1 directory level
alias ...='cd ../../'                       # Go back 2 directory levels
alias .3='cd ../../../'                     # Go back 3 directory levels
alias .4='cd ../../../../'                  # Go back 4 directory levels
alias .5='cd ../../../../../'               # Go back 5 directory levels
alias .6='cd ../../../../../../'            # Go back 6 directory levels
alias edit='atom'                           # edit:         Opens any file in atom editor
alias f='open -a Finder ./'                 # f:            Opens current directory in MacOS Finder
alias c='clear'                             # c:            Clear terminal display
alias df="df -h"
alias du="du -h"
alias which='type -all'                     # which:        Find executables
alias path='echo -e ${PATH//:/\\n}'         # path:         Echo all executable Paths
alias show_options='shopt'                  # Show_options: display bash options settings
alias fix_stty='stty sane'                  # fix_stty:     Restore terminal settings when screwed up
alias DT='tee ~/Desktop/terminalOut.txt'    # DT:           Pipe content to file on MacOS Desktop
alias now='date +"%Y-%m-%d %T"'

mcd () { mkdir -p "$1" && cd "$1"; }        # mcd:          Makes new Dir and jumps inside
trash () { command mv "$@" ~/.Trash ; }     # trash:        Moves a file to the MacOS trash
ql () { qlmanage -p "$*" >& /dev/null; }    # ql:           Opens any file in MacOS Quicklook Preview


#   -------------------------------
#   3.  FILE AND FOLDER MANAGEMENT
#   -------------------------------

zipf () { zip -r "$1".zip "$1" ; }          # zipf:         To create a ZIP archive of a folder
alias numFiles='echo $(ls -1 | wc -l)'      # numFiles:     Count of non-hidden files in current dir

#   cdf:  'Cd's to frontmost window of MacOS Finder
#   ------------------------------------------------------
cdf () {
    currFolderPath=$( /usr/bin/osascript <<EOT
        tell application "Finder"
            try
        set currFolder to (folder of the front window as alias)
            on error
        set currFolder to (path to desktop folder as alias)
            end try
            POSIX path of currFolder
        end tell
EOT
    )
    echo "cd to \"$currFolderPath\""
    cd "$currFolderPath"
}

#   extract:  Extract most know archives with one command
#   ---------------------------------------------------------
extract () {
    if [ -f $1 ] ; then
      case $1 in
        *.tar.bz2)   tar xjf $1     ;;
        *.tar.gz)    tar xzf $1     ;;
        *.bz2)       bunzip2 $1     ;;
        *.rar)       unrar e $1     ;;
        *.gz)        gunzip $1      ;;
        *.tar)       tar xf $1      ;;
        *.tbz2)      tar xjf $1     ;;
        *.tgz)       tar xzf $1     ;;
        *.zip)       unzip $1       ;;
        *.Z)         uncompress $1  ;;
        *.7z)        7z x $1        ;;
        *)     echo "'$1' cannot be extracted via extract()" ;;
         esac
     else
         echo "'$1' is not a valid file"
     fi
}

#   tar:  tar managment made easy
#   ---------------------------------------------------------
mktar(){ tar cvf  "${1%%/}.tar"     "${1%%/}/"; }
mktgz(){ tar cvzf "${1%%/}.tar.gz"  "${1%%/}/"; }
mktbz(){ tar cvjf "${1%%/}.tar.bz2" "${1%%/}/"; }

#   file premissions: recursively fix dir/file permissions on a given directory
#   ---------------------------------------------------------
fix() {
  if [ -d $1 ]; then
    find $1 -type d -exec chmod 755 {} \;
    find $1 -type f -exec chmod 644 {} \;
  else
    echo "$1 is not a directory."
  fi
}


#   ---------------------------
#   4.  BREW CONIGURATION
#   ---------------------------

if [ -f $(brew --prefix)/etc/bash_completion ]; then
    source $(brew --prefix)/etc/bash_completion
    export HOMEBREW_GITHUB_API_TOKEN=$(cat /Users/agprado/ConfFiles/Brew/token)
fi


#   ---------------------------
#   5.  SEARCHING
#   ---------------------------

alias qfind="find . -name "                 # qfind:    Quickly search for file
ff () { /usr/bin/find . -name "$@" ; }      # ff:       Find file under the current directory
ffs () { /usr/bin/find . -name "$@"'*' ; }  # ffs:      Find file whose name starts with a given string
ffe () { /usr/bin/find . -name '*'"$@" ; }  # ffe:      Find file whose name ends with a given string

#   spotlight: Search for a file using MacOS Spotlight's metadata
#   -----------------------------------------------------------
spotlight () { mdfind "kMDItemDisplayName == '$@'wc"; }


#   ---------------------------
#   6.  PROCESS MANAGEMENT
#   ---------------------------

#   findPid: find out the pid of a specified process
#   -----------------------------------------------------
#       Note that the command name can be specified via a regex
#       E.g. findPid '/d$/' finds pids of all processes with names ending in 'd'
#       Without the 'sudo' it will only find processes of the current user
#   -----------------------------------------------------
findPid () { lsof -t -c "$@" ; }

#   memHogsTop, memHogsPs:  Find memory hogs
#   -----------------------------------------------------
alias memHogsTop='top -l 1 -o rsize | head -20'
alias memHogsPs='ps wwaxm -o pid,stat,vsize,rss,time,command | head -10'

#   cpuHogs:  Find CPU hogs
#   -----------------------------------------------------
alias cpu_hogs='ps wwaxr -o pid,stat,%cpu,time,command | head -10'

#   topForever:  Continual 'top' listing (every 10 seconds)
#   -----------------------------------------------------
alias topForever='top -l 9999999 -s 10 -o cpu'

#   ttop:  Recommended 'top' invocation to minimize resources
#   ------------------------------------------------------------
#       Taken from this macosxhints article
#       http://www.macosxhints.com/article.php?story=20060816123853639
#   ------------------------------------------------------------
alias ttop="top -R -F -s 10 -o rsize"

#   my_ps: List processes owned by my user:
#   ------------------------------------------------------------
my_ps() { ps $@ -u $USER -o pid,%cpu,%mem,start,time,bsdtime,command ; }


#   ---------------------------
#   7.  NETWORKING
#   ---------------------------
# tunnelBuyati() {ssh -D 8080 -C -N Buyati;}

alias myip='curl report-ip.appspot.com'             # myip:         Public facing IP Address
alias netCons='lsof -i'                             # netCons:      Show all open TCP/IP sockets
alias flushDNS='dscacheutil -flushcache'            # flushDNS:     Flush out the DNS Cache
alias lsock='sudo /usr/sbin/lsof -i -P'             # lsock:        Display open sockets
alias lsockU='sudo /usr/sbin/lsof -nP | grep UDP'   # lsockU:       Display only open UDP sockets
alias lsockT='sudo /usr/sbin/lsof -nP | grep TCP'   # lsockT:       Display only open TCP sockets
alias ipInfo0='ipconfig getpacket en0'              # ipInfo0:      Get info on connections for en0
alias ipInfo1='ipconfig getpacket en1'              # ipInfo1:      Get info on connections for en1
alias openPorts='sudo lsof -i | grep LISTEN'        # openPorts:    All listening connections
alias showBlocked='sudo ipfw list'                  # showBlocked:  All ipfw rules inc/ blocked IPs

#   ii:  display useful host related informaton
#   -------------------------------------------------------------------
ii() {
    echo -e "\nYou are logged on ${RED}$HOST"
    echo -e "\nAdditionnal information:$NC " ; uname -a
    echo -e "\n${RED}Users logged on:$NC " ; w -h
    echo -e "\n${RED}Current date :$NC " ; date
    echo -e "\n${RED}Machine stats :$NC " ; uptime
    echo -e "\n${RED}Current network location :$NC " ; scselect
    echo -e "\n${RED}Public facing IP Address :$NC " ;myip
    #echo -e "\n${RED}DNS Configuration:$NC " ; scutil --dns
    echo
}


#   ---------------------------------------
#   8.  SYSTEMS OPERATIONS & INFORMATION
#   ---------------------------------------

alias mountReadWrite='/sbin/mount -uw /'    # mountReadWrite:   For use when booted into single-user

#   cleanupDS:  Recursively delete .DS_Store files
#   -------------------------------------------------------------------
alias cleanupDS="find . -type f -name '*.DS_Store' -ls -delete"

#   finderShowHidden:   Show hidden files in Finder
#   finderHideHidden:   Hide hidden files in Finder
#   -------------------------------------------------------------------
alias finderShowHidden='defaults write com.apple.finder ShowAllFiles TRUE'
alias finderHideHidden='defaults write com.apple.finder ShowAllFiles FALSE'

#   cleanupLS:  Clean up LaunchServices to remove duplicates in the "Open With" menu
#   -----------------------------------------------------------------------------------
alias cleanupLS="/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user && killall Finder"


#   ---------------------------------------
#   9.  WEB DEVELOPMENT
#   ---------------------------------------

alias apacheEdit='sudo edit /etc/httpd/httpd.conf'      # apacheEdit:       Edit httpd.conf
alias apacheRestart='sudo apachectl graceful'           # apacheRestart:    Restart Apache
alias editHosts='sudo edit /etc/hosts'                  # editHosts:        Edit /etc/hosts file
alias herr='tail /var/log/httpd/error_log'              # herr:             Tails HTTP error logs
alias apacheLogs="less +F /var/log/apache2/error_log"   # Apachelogs:   Shows apache error logs
httpHeaders () { /usr/bin/curl -I -L $@ ; }             # httpHeaders:      Grabs headers from web page

#   httpDebug:  Download a web page and show info on what took time
#   -------------------------------------------------------------------
httpDebug () { /usr/bin/curl $@ -o /dev/null -w "dns: %{time_namelookup} connect: %{time_connect} pretransfer: %{time_pretransfer} starttransfer: %{time_starttransfer} total: %{time_total}\n" ; }


#   ---------------------------------------
#   10.  PYTHON DEVELOPMENT
#   ---------------------------------------

## pip should only run if there is a virtualenv currently activated
export PIP_REQUIRE_VIRTUALENV=true
## cache pip-installed packages to avoid re-downloading
export PIP_DOWNLOAD_CACHE=$HOME/.pip/cache

export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=$HOME/Devel
#source /usr/local/bin/virtualenvwrapper.sh

eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"


#   ---------------------------------------
#   10.  REMINDERS & NOTES
#   ---------------------------------------

#   remove_disk: spin down unneeded disk
#   ---------------------------------------
#   diskutil eject /dev/disk1s3

#   to change the password on an encrypted disk image:
#   ---------------------------------------
#   hdiutil chpass /path/to/the/diskimage

#   to mount a read-only disk image as read-write:
#   ---------------------------------------
#   hdiutil attach example.dmg -shadow /tmp/example.shadow -noverify

#   mounting a removable drive (of type msdos or hfs)
#   ---------------------------------------
#   mkdir /Volumes/Foo
#   ls /dev/disk*   to find out the device to use in the mount command)
#   mount -t msdos /dev/disk1s1 /Volumes/Foo
#   mount -t hfs /dev/disk1s1 /Volumes/Foo

#   to create a file of a given size: /usr/sbin/mkfile or /usr/bin/hdiutil
#   ---------------------------------------
#   e.g.: mkfile 10m 10MB.dat
#   e.g.: hdiutil create -size 10m 10MB.dmg
#   the above create files that are almost all zeros - if random bytes are desired
#   then use: ~/Dev/Perl/randBytes 1048576 > 10MB.dat

# MacPorts Installer addition on 2016-03-04_at_21:35:13: adding an appropriate PATH variable for use with MacPorts.
export PATH="/opt/local/bin:/opt/local/sbin:$PATH"
# Finished adapting your PATH environment variable for use with MacPorts.


#   ---------------------------------------
#   10.  REMINDERS & NOTES
#   ---------------------------------------

# ORACLE client `instantclient_11_2` path:
# /Users/agprado/OracleDriver/instantclient_12_1

export ORACLE_HOME=/Users/agprado/.oracle/12.1/client64/instantclient_12_1

export LD_LIBRARY_PATH=$ORACLE_HOME:$LD_LIBRARY_PATH
export PATH=~/instantclient_12_1:$PATH

export DYLD_LIBRARY_PATH=$DYLD_LIBRARY_PATH:$ORACLE_HOME
export NLS_LANG=".UTF8"
