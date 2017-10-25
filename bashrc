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
#   5.   Development environment

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


#   Set Default Editor
#   ------------------------------------------------------------
export EDITOR=/usr/bin/vim

#   Set Default character encoding
#   ------------------------------------------------------------
export NLS_LANG=".UTF8"

# #   -----------------------------
# #   2.  MAKE TERMINAL BETTER
# #   -----------------------------

# Load ssh-agent on login
if [ -d $HOME/.ssh ]; then
  eval $(ssh-agent -s)
fi

# Aliases
source "${HOME}/.bash/bash_aliases"

# Functions
source "${HOME}/.bash/bash_functions"

# Enhance search function
source "${HOME}/.bash/bash_find_utils"

# Process management
source "${HOME}/.bash/bash_proceses"

# Networking
source "${HOME}/.bash/bash_networking"

# Systems operations & information

#   ---------------------------
#   4.  If System is not Linux. MacOS
#   ---------------------------
if [ $OS != "Linux" ]; then
  source "${HOME}/.bash/bash_not_linux"
fi

#   ---------------------------------------
#   5.  DEVELOPMENT
#   ---------------------------------------
source "${HOME}/.bash/develop_tools"

#   5.1 ORACLE DB
source "${HOME}/.bash/develop_oracle"

#   5.2 WEB DEVELOPMENT
source "${HOME}/.bash/develop_web"

#   5.3 DEVELOPMENT PYTHON
source "${HOME}/.bash/develop_python"
