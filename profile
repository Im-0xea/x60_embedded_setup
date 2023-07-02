#!/bin/sh
export PATH="/bin"
export MANPATH="/share/man"

#export TERM=fbterm
export PS1='$PWD: '

export EDITOR="vim"
export PAGER="less -R"
export BROWSER="elinks"

export TERMINFO=/etc/terminfo
export PKG_CONFIG_PATH=/pkgconfig

export CC=gcc
export CXX=g++
export LD=ld
export AS=as

#export CFLAGS="-Os -march=native -mtune=native -pipe"
#export CXXFLAGS="-Os -march=native -mtune=native -pipe -Wno-error -Wno-narrowing"
#export LDFLAGS="-static"

export PREFIX=/

export CONF="./configure --prefix=/ --libdir=/lib --includedir=/include --sysconfdir=/etc --bindir=/bin --sbindir=/bin --mandir=/share/man --enable-static"
if [[ $(tty) = /dev/tty1 ]]; then
exec fbterm
fi
