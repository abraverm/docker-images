#!/bin/bash
set -e

if [ "$1" = 'pianobar' ]; then
  USER_UID=${USER_UID:-1000}
  USER_GID=${USER_GID:-1000}

  # create user group
  if ! getent group pianobar >/dev/null; then
    groupadd -f -g ${USER_GID} pianobar
  fi

  # create user with uid and gid matching that of the host user
  if ! getent passwd pianobar >/dev/null; then
    adduser --uid ${USER_UID} --gid ${USER_GID} -c 'PianoBar' pianobar
  fi

  exec su pianobar -c "$@"
fi

exec "$@"
