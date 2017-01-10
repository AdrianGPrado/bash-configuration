#  ---------------------------------------------------------------------------
#
#  Description:  This file is bash_profile
#  Location:    ~/.bash_profile
#  Loads:   with an interactive shell.
#           (more or less: when you type user ans passd)
#
#  Sections:
#   1.   Include bashrc

#
#   1.  Include bashrc
#   -------------------------------

if [ -f ~/.bashrc ]; then
   source ~/.bashrc
fi


# Setting PATH for Python 3.5
# The original version is saved in .bash_profile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/3.5/bin:${PATH}"
export PATH
