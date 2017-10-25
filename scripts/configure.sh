#!/usr/bin/env bash

set -e

CONFIG_DIR=$1

link (){
  source=$1
  destination=$2
  echo "# link ${source} to ${destination}"
  ln -sf $source $destination
}

echo "# Define files that need to be backed-up and linked:"
echo "#   - bashrc "
echo "#   - bash_profile "
echo "#   - bash/ "
{
  case "$SHELL" in
  /bin/bash )
    profile="${HOME}/.bash_profile"
    bashrc="${HOME}/.bashrc"
    bash="${HOME}/.bash"
    ;;
  * )
    profile="your profile"
    bashrc="your bashrc"
    bash="your bash"
    ;;
  esac
} >&2


echo "# Move the original files to *_orig name."
if [ -f "${profile}" ] && [ ! -f "${profile}_orig" ]; then
  echo "# Move old ${profile} to ${profile}_orig backup"
  mv $profile "${profile}_orig"
fi

if [ -f "${bashrc}" ] && [ ! -f "${bashrc}_orig" ]; then
  echo "# Move old ${bashrc} to ${bashrc}_orig backup"
  mv $bashrc "${bashrc}_orig"
fi

if [ -d "${bash}" ] && [ ! -d "${bash}_orig" ]; then
  echo "# Move old ${bash} to ${bash}_orig backup"
  mv $bash_folder "${bash_folder}_orig"
fi

link $CONFIG_DIR/bashrc        $bashrc
link $CONFIG_DIR/bash_profile  $profile
link $CONFIG_DIR/bash          $bash
