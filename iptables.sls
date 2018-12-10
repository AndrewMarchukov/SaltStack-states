/etc/iptables/rules.v4:
  file.replace:
    - pattern: -A INPUT -s 1.1.1.1/32 -m conntrack --ctstate NEW -j ACCEPT
    - repl: -A INPUT -s 2.2.2.2/32,3.3.3.3/32 -m conntrack --ctstate NEW -j ACCEPT
    - show_changes: True

iptables-persistent:
  service.running:
    - name: iptables-persistent
    - restart: True
    - watch:
      - file: /etc/iptables/rules.v4
