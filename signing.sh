#!/bin/bash
# Read this before using
# https://wiki.debian.org/SecureBoot#MOK_-_Machine_Owner_Key

# Edit this.
mok_dir=/var/lib/shim-signed/mok
ko_dir=/lib/modules/`uname -r`/updates/dkms/
module='v4l2loopback'

for driver in $module
do
    /usr/src/linux-headers-`uname -r`/scripts/sign-file \
        sha256 $mok_dir/MOK.priv $mok_dir/MOK.der \
        $(modinfo -n $driver)
    modprobe $driver
done
