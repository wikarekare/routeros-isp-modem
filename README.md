# Mikrotik Router as Fibre NAT gateway
Using Ansible to configure an RB960PGS routeros router as a fibre NAT gateway

Mikrotik configuration is not idempotent. The configuration is a script that has to be run from a known state, and is not repeatable without conditional checks in the script. It is also not always repeatable between routers (even of the same model). This makes remote management difficult.

The Ansible community.routeros.api module attempts to make the Mikrotik configuration idempotent. Most Ansible configuration items just work. `api_find_and_modify` is required for configuration items that can have multiple `add` lines, or a second Ansible run can either crash with an error, or the configuration can end up with duplicate configuration lines. The Ansible module documentation isn't the best, with google/AI results returning configurations segments that don't work.

We are using RouterOS 7.19.4, which when reset, starts with all ports connected to bridgeLocal, which is a welcome change from earlier versions. We therefore don't need to use `winbox` or `run-after-reset` scripts to bootstrap the router. We do need to be careful not to break the connection to the router though (as we have done many times. For now we have left ether5 without a VLAN on bridgeLocal on the switch, to be used for the initial Ansible configuration.

Nb. Playbook variables have had '-' changed to '_', so Ansible is happy.

## Running the playbook

After a new router has been reset to its default settings, we do need to login manually to set the initial password. Then we can run the playbook to get a working configuration. We can also make changes to the router.yml definitions, and another Ansible run will (should) update the running configuration (without a router reset). We maintain these routers remotely, so don't want a long car trip to make changes.

We have a Python environment for use with Ansible, and a Makefile to run the playbook by just running `make`. We can also test the playbook, without making changes, with `make check`.

### Ansible installed in my ~/bin dir with
Prerequisite: `libssh` had already been installed on my laptop.

```
python3 -m venv ~/bin/ansible_env
# source just adds ~/bin/ansible_env/bin to the bash shell $PATH
# It is necessary for make to work too, though I bypass that with a permanent change to $PATH in .bashrc
source ~/bin/ansible_env/bin/activate
python3 -m pip install ansible
python3 -m pip install librouteros
python3 -m pip install ansible-pylibssh
```

## RouterOS 7.19 RB960 Reset configuration.

Reset the router by holding down the `Reset` button while plugging in the power and wait for the `USR` LED to flash, then stop flashing. The router will get a `DHCP` address, available on all ports, which are all now on `bridgeLocal`.

```
/interface bridge
add admin-mac=XX:XX:XX:XX:XX:XX auto-mac=no comment=defconf name=bridgeLocal
/interface wireless security-profiles
set [ find default=yes ] supplicant-identity=MikroTik
/interface bridge port
add bridge=bridgeLocal comment=defconf interface=ether1
add bridge=bridgeLocal comment=defconf interface=ether2
add bridge=bridgeLocal comment=defconf interface=ether3
add bridge=bridgeLocal comment=defconf interface=ether4
add bridge=bridgeLocal comment=defconf interface=ether5
add bridge=bridgeLocal comment=defconf interface=sfp1
/ip dhcp-client
add comment=defconf interface=bridgeLocal
/ip ssh
set host-key-type=ed25519 strong-crypto=yes
/system clock
set time-zone-name=Pacific/Auckland
```
