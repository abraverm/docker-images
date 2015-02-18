#!/bin/bash
user=$(stat -c "%u" $HOME)
adduser -M -d $HOME -u $user user
sudo -u user /usr/bin/eclipse
sudo -u user /usr/bin/eclipse
