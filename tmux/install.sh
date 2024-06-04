#!/bin/bash

## Install tmux
#rpm2cpio tmux-3.1c-150300.3.3.1.aarch64.rpm | cpio -idmv
#
## Modify bashrc to use the new installation
#grep --quiet tmux ~/.bashrc
#result=$?
#if [ $result -eq 1 ]; then
#    echo "export PATH=$PWD/usr/bin:\$PATH" >> ~/.bashrc
#    echo "export LD_LIBRARY_PATH=$PWD/usr/lib:$PWD/usr/lib64:\$LD_LIBRARY_PATH" >> ~/.bashrc
#    echo "export TMUX_TMPDIR=~/.tmux/tmp" >> ~/.bashrc
#    mkdir -p ~/.tmux/tmp
#fi

# Link the configuration
if [ -f ~/.tmux.conf ]; then
    mv ~/.tmux.conf ~/.tmux.conf.bkp
fi
pushd ~ > /dev/null
ln -s ./config/base_tools/tmux/.tmux.conf ~/.tmux.conf
popd > /dev/null
