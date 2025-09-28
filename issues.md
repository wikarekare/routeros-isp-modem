# Issues

The following report `changed` when there is no change to the routeros config.

These don't fail, and they don't produce duplicate configuration entries.
* time.yml enabling ntp
* snmp.yml enabling snmp; setting parameters
* dns.yml enabling dns remote path
* bridge_interfaces.yml assigning ports to the bridge_interfaces
* vlan.yml adding vlans to the bridge
* bridge_vlans.yml enabling vlan filtering on the bridge
* switch_ports.yml setting switch vlan attributes
* nat.yml adding masquerade rule

This one works for all firewall rules but one.
* firewall.yml  fasttrack-connection rule with hw=yes always shows `changed` and adds a dulicate rule to the end of the rules.
