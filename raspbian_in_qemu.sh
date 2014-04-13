#!/bin/bash
# raspbian_in_qemu.sh - Does what it says on the tin.  Requires that you have
#    qemu-system-arm installed and that it supports the arm1176 processor.
#    Takes two arguments, the kernel to boot and the disk image to mount.

# By: The Doctor [412/724/301/703][ZS] <drwho at virtadpt dot net>
# Written for Project Byzantium (http://project-byzantium.org/)
# License: GPLv3

# Notes:
# v1 RasPi's only have 256 MB of RAM.  v2 RasPi's have 512 MB.  Some in the
# community seem to have decided that defaulting to 256 MB is safest, but if
# you want to try larger amounts of memory feel free to do so.

# The evocation of QEMU came from this page, which I learned from:
#    http://xecdesign.com/qemu-emulating-raspberry-pi-the-easy-way/

# The serial port is redirected to the terminal you executed this script from,
# so you have direct access to the virtual unit if the X window goes wonky for
# whatever reason.

# Count the number of command line arguments passed to the script.  ABEND if
# we're missing a few.
#
# Download raspian images at the following addresses.
#
# http://downloads.raspberrypi.org/images/raspbian/2013-02-09-wheezy-raspbian/2013-02-09-wheezy-raspbian.zip.torrent
#
# http://downloads.raspberrypi.org/images/raspbian/2013-02-09-wheezy-raspbian/2013-02-09-wheezy-raspbian.zip 
# 
# SHA-1 	b4375dc9d140e6e48e0406f96dead3601fac6c81
# Default login 	Username: pi Password: raspberry
#
# For instructions on raspberry pi
# http://xecdesign.com/qemu-emulating-raspberry-pi-the-easy-way/
#
# Raspberry pi kernel
# http://xecdesign.com/downloads/linux-qemu/kernel-qemu
#

if [ "$#" -lt 2 ]; then
    echo "Error - insufficient command line arguments."
    echo "Usage: $0 -k <kernel> -i <disk image>"
    exit 1
    fi

# See if the files passed on the command line exist, and if they don't ABEND.
if [ ! -f $2 ]; then
    echo "Error - Kernel image not found."
    exit 1
    fi
if [ ! -f $4 ]; then
    echo "Error - Disk image not found."
    exit 1
    fi

# Test to see if QEMU is installed.
which qemu-system-arm 1>/dev/null 2>/dev/null
if [ $? -gt 0 ]; then
    echo "Error - qemu-system-arm executable not found."
    exit 1
    fi

# Test to see if qemu-system-arm can emulate the 1176 processor core, and
# ABEND if not.
CPU_FOUND=`qemu-system-arm -cpu ? | grep 1176`
if [ ! "$CPU_FOUND" ]; then
    echo "Error - qemu-system-arm does not emulate the arm1176 CPU."
    exit 1
    fi

# Start QEMU in RaspberryPi mode.
qemu-system-arm -kernel $2 -cpu arm1176 -m 256 -M versatilepb -no-reboot \
    -serial stdio -append "root=/dev/sda2 panic=1" -hda $4

# Fin.
exit 0
