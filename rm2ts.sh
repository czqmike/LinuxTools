#!/bin/bash

set -Eeu
set -o pipefail
# set -x

config_file="$HOME/.bashrc"  # or .zshrc

sudo apt-get install -y trash-cli
## !! Don't alias rm to trash, it may break some scripts. 
if [ $(grep -c 'alias rm=' ${config_file}) -eq '0' ]; then
    echo 'alias rm="rm -I"' >> $config_file
fi
if [ $(grep -c "alias ts=" ${config_file}) -eq '0' ]; then
    echo 'alias ts=trash-put' >> $config_file
fi
if [ $(grep -c "alias lt=" ${config_file}) -eq '0' ]; then
    echo 'alias lt=trash-list' >> $config_file
fi
## The moved files are in `~/.local/share/Trash/files`
## Use `while ( echo 0 | rt ); do true; done;` or cp to restore files more efficiently.
if [ $(grep -c "alias rt=" ${config_file}) -eq '0' ]; then
    echo 'alias rt=restore-trash' >> $config_file # or trash-restore, the former works in my own env :)
fi
## Disable clearing trash manually.
# echo 'alias ct=trash-empty' >> $config_file

source $config_file

## Clear trash each monday 12 A.M. automatically.
conf=".tempconf"_$(date "+%Y%m%d-%H%M%S")
crontab -l > $conf
if [ $(grep -c "trash-empty" ${conf}) -eq '0' ]; then
    echo "0 12 * * 1 trash-empty" >> $conf && crontab $conf
fi
rm -f $conf

echo 
echo '[info] cmd `rm` has been replaced with `ts`, `lt`, `rt` and auto trash clearing has been set.'
