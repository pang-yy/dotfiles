All instruction is based on Debian.

> Reference: https://forums.debian.net/viewtopic.php?t=158967

## Installation

```
sudo apt install qemu-system qemu-utils libvirt-daemon-system virt-manager bridge-utils
```

Packages breakdown:

1. `qemu-system`
    - main qemu package
2. `qemu-utils`
3. `libvirt-daemon-system`
    - run virtualisation in the background
4. `virt-manager`
    - GUI program to manage all the VMs via libvirt
5. `bridge-utils`
    - network dependancy

Other similar packages:

1. `qemu-system-x86`
    - this package includes both 32-bit and 64-bit emulators
    - same as `qemu-system`, but `qemu-system` includes various other architectures
2. `libvirt-daemon`
    - `libvirt-daemon-system` depends on this package, but `libvirt-daemon-system` also includes additional scripts or config files
3. `libvirt-clients` / `libvirt-client`
    - depended on `virsh`
    - depended by `virt-manager`
4. `virsh`
    - CLI program to manage and interact with the VMs
    - depended by `virt-manager`
5. `virtinst`
    - set of command-line tools such as `virt-install` and `virt-clone`
    - optional, often used in scripting or automation

## Add users to group

```
sudo usermod -aG libvirt <username>
sudo usermod -aG kvm <username>
```

## Autostart network

> Virt-Manager uses a virtual network adapter to give VMs internet access (piggy-backing on the host's access). By default, the virtual adapter is disabled (kinda silly). Enable with Edit > Connection Details > Virtual Networks > tick box to Autostart On Boot; click Apply. Won't take effect, though, until reboot host. Enable for this boot with `sudo virsh net-start default`.
