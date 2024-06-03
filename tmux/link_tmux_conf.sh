#!/bin/bash

if [ -f ~/.tmux.conf ]; then
    mv ~/.tmux.conf ~/.tmux.conf.bkp
fi
pushd ~ > /dev/null
ln -s ./config/base_tools/tmux/.tmux.conf ~/.tmux.conf
popd ~ > /dev/null
