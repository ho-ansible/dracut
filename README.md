# Ansible role: dracut
Enable this role on a host in order to build an initramfs.
I use this to build a common initramfs for PXE boot.

## Requirements
Debian stable with an installed kernel

## Role Variables
+ `dracut_opts`: options to place under `/etc/dracut.conf.d/`
+ `dracut_cmdline`: extra command-line options

## Playbooks
+ `main.yml`: apply role
+ `uninstall.yml`: remove. Run prior to removing host from inventory group.

## Dependencies
None.

## License
+ Ansible role licensed [MIT](LICENSE)

## Author Information
+ Ansible role by [Sean Ho](https://github.com/ho-ansible/)
