#! /bin/sh
# Usage: $0 5.10.0-0.bpo.3-amd64 (or similar kernel ver)

boothost=boot
bootdir=/var/www/linux

# Get kernel version
if [ "$#" -gt 0 ]; then
  ver="$1"
  shift
else
  ver=$(uname -r)
fi

# Sanitise somewhat: basename
ver=${ver##*/}

# Create local dir for kernel + initramfs
mkdir -p /tmp/dracut || return $?
cd /tmp/dracut
mkdir -p "$ver"
rsync "/boot/vmlinuz-$ver" "$ver/vmlinuz" || return $?

# Create initramfs
/usr/bin/dracut -i /etc/dracut.extra / -f "$ver/initrd.img" "$ver" $@ || return $?

# Copy kernel + initramfs to boot server
rsync -a --chmod=F644 "$ver" "${boothost}:$bootdir/" || return $?

# Enable as new default
ln -sf "$ver" default
rsync -l default "${boothost}:$bootdir/"
