#!/bin/sh
mount -t proc proc /proc &
mount -t sysfs none /sys &
wait

mount -t devtmpfs devtmpfs /dev
mkdir /dev/mqueue /dev/pts /dev/shm
mount -t tmpfs shm /dev/shm &
mount -t devpts devpts /dev/pts &
mount -t tmpfs tmpfs /run &
mount -t tmpfs /dev/shm /tmp &
ln -s /proc/self/fd /dev/fd
mount -t debugfs debugfs /sys/kernel/debug &
wait

e2fsck /dev/sda1 
mount -t ext2 -o remount,rw /

hwclock -s &
mdev -s
ifconfig lo 127.0.0.1 
ip addr add 192.168.178.115/24 dev wlan0
ip link set wlan0 up
ip route add default via 192.168.178.1
wpa_supplicant -Dnl80211 -iwlan0 -c/etc/wpa_supplicant.conf >wpa.logg 2>&1 &
sdhcp -d wlan0 > /dev/null &

powertop --auto-tune > /dev/null 2>&1 &
#thinkfan -q &
syslogd -S -l1 &
crond

sysctl kernel.printk="3 3 3 3" 
loadkmap < /etc/dvorak.bmap
gpm -m /dev/psaux -t ps2
