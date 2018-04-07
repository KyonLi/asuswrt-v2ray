config.json ------------ v2ray config file
bypass_from_ip.txt ----- bypass proxy for source IP in this file, one IP address per line.
bypass_from_mac.txt ---- bypass proxy for source MAC in this file, one MAC address per line.

After modifying v2ray config or upgrading v2ray binary, please run [ /opt/etc/init.d/S60v2ray restart ] to restart v2ray.
After modifying bypass rules, please run [ /opt/etc/init.d/S60v2ray firewall-restart ] to refrsh iptables rules.
