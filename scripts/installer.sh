#!/usr/bin/env bash

set -e

if [ -z "$UNIX_CONFIG_PATH" ]; then
  UNIX_CONFIG_PATH="${HOME}/.unix_configuration_files"
fi
echo "Define Unix Configuration Files folder in: ${UNIX_CONFIG_PATH}"

if [ ! -d "$UNIX_CONFIG_PATH" ]; then
  mkdir ${UNIX_CONFIG_PATH}
  echo "Create Unix Configuration Files folder: ${UNIX_CONFIG_PATH}"
fi

checkout() {
  echo "Clone git repository ${1}"
  [ -d "$2" ] || git clone --recursive "$1" "$2"
}

configure() {
  sh $1/scripts/configure.sh $1
}

if ! command -v git 1>/dev/null 2>&1; then
  echo "git: Git is not installed, can't continue." >&2
  exit 1
fi

if [ -n "${USE_GIT_URI}" ]; then
  GITHUB="git://github.com"
else
  GITHUB="https://github.com"
fi

repository="${GITHUB}/AdrianGPrado/bash-configuration.git"
destination="${UNIX_CONFIG_PATH}/bash-configuration"

checkout $repository $destination
configure $destination
