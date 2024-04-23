#!/bin/bash

# Note you can install earlyoom via apt install

git clone https://github.com/rfjakob/earlyoom.git
cd earlyoom
make -j8

sudo echo "\
# Default settings for earlyoom. This file is sourced by /bin/sh from
# /etc/init.d/earlyoom or by systemd from earlyoom.service.

# Options to pass to earlyoom
EARLYOOM_ARGS=\"-r 3600 --avoid '(^|/)(chromium|firefox|ssh)$' \
    --prefer '(^|/)(ninja|gcc|clangd|cmake|ctest|cvise|spack)$'\"" > /etc/default/earlyoom
