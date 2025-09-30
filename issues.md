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

For firewall rules, loops don't work as expected. If these are set, then the resulting firewall rule set becomes just the last rule in the loop. This disconnected me, part way through adding my ruleset, as the previous accepts had been removed.
```
    handle_absent_entries: remove
    handle_entries_content: remove_as_much_as_possible
    ensure_order: true
```
