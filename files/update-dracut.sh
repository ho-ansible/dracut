#! /bin/sh
# Usage: $0 5.10.0-0.bpo.3-amd64 (or similar kernel ver)

bootdir="boot:/var/www/linux"
tmpdir=/tmp/dracut

# Get kernel version
for ver in $(uname -r) $(ls /boot/vmlinuz-*) $1; do :; done

# Sanitise somewhat: basename
ver=${ver##*/}
ver=${ver##vmlinuz-}

# Remaining args are passed to dracut
[ $# -gt 0 ] && shift

echo "Copying kernel to $tmpdir/$ver"
mkdir -p $tmpdir || return $?
cd $tmpdir
mkdir -p "$ver"
rsync "/boot/vmlinuz-$ver" "$ver/vmlinuz" || return $?

echo "Running dracut"
/usr/bin/dracut -i /etc/dracut.extra / -f "$ver/initrd.img" "$ver" $@ || return $?

echo "Copying to boot location $bootdir"
rsync -a --chmod=F644 "$ver" "$bootdir/" || return $?

echo "Enabling as new testing kernel at $bootdir/testing"
rm -f testing
ln -s "$ver" testing
rsync -l testing "$bootdir/"
