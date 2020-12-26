# Ansible role: dracut
Enable this role on a host in order to build an initramfs.
I use this to build a common initramfs for PXE boot.

## Requirements
Debian stable with an installed kernel

## Role Variables
+ `dracut_conf`: contents of `/etc/dracut.conf`
+ `dracut_extra`: dict of (`path`, `contents`) pairs to add to initramfs
+ `dracut_extra_dir` (default: `/etc/dracut.extra`) target dir for `dracut_extra`

## Playbooks
+ `main.yml`: apply role
+ `uninstall.yml`: remove. Run prior to removing host from inventory group.

## Dependencies
None.

## License
+ Ansible role licensed [MIT](LICENSE)

## Author Information
+ Ansible role by [Sean Ho](https://github.com/ho-ansible/)
