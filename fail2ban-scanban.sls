fail2ban:
  pkg.latest:
    - refresh: True
    - name: fail2ban

{% for pattern, repl in [('bantime  = 600', 'bantime  = 3600'), ('findtime = 600', 'findtime = 3600')] %}

/etc/fail2ban/jail.conf change {{ repl }}:
  file.replace:
    - name: /etc/fail2ban/jail.conf
    - pattern: {{ pattern }}
    - repl: {{ repl }}
    - show_changes: True

{% endfor %}

/etc/fail2ban/jail.d/scanban.conf:
  file.managed:
    - contents: |
        [scanban]

        enabled = true

        filter = scanban

        port = anyport

        banaction = iptables-allports

        logpath = /var/log/iptables.log

        maxretry = 3


/etc/logrotate.d/iptables:
  file.managed:
    - contents: |
        /var/log/iptables.log {

        daily

        rotate 30

        compress

        missingok

        notifempty

        sharedscripts

        }

/etc/rsyslog.d/iptables.conf:
  file.absent

/etc/rsyslog.d/11-iptables.conf:
  file.managed:
    - contents: |
        :msg, contains,"Iptables: " -/var/log/iptables.log

        & ~


rsyslog-restart-iptables:
  service.running:
    - name: rsyslog
    - restart: True
    - watch:
      - file: /etc/rsyslog.d/11-iptables.conf


/etc/fail2ban/filter.d/scanban.conf:
  file.managed:
    - contents: |
        [Definition]


        failregex = .* Iptables: .* SRC=<HOST> .* (DPT=9|DPT=13|DPT=21|DPT=23|DPT=25|DPT=26|DPT=37|DPT=53|DPT=79|DPT=81|DPT=88|DPT=106|DPT=110|DPT=111|DPT=113|DPT=119|DPT=135|DPT=139|DPT=143|DPT=144|DPT=179|DPT=199|DPT=389|DPT=427|DPT=443|DPT=445|DPT=444|DPT=465|DPT=513|DPT=515|DPT=514|DPT=543|DPT=544|DPT=548|DPT=554|DPT=587|DPT=631|DPT=646|DPT=873|DPT=990|DPT=993|DPT=995|DPT=1025|DPT=1029|DPT=1026|DPT=1027|DPT=1028|DPT=1110|DPT=1433|DPT=1720|DPT=1723|DPT=1755|DPT=1900|DPT=2000|DPT=2001|DPT=2049|DPT=2121|DPT=2717|DPT=3000|DPT=3128|DPT=3306|DPT=3389|DPT=3986|DPT=4899|DPT=5000|DPT=5009|DPT=5051|DPT=5060|DPT=5101|DPT=5190|DPT=5357|DPT=5432|DPT=5631|DPT=5666|DPT=5800|DPT=5900|DPT=6000|DPT=6001|DPT=6646|DPT=7070|DPT=8008|DPT=8009|DPT=8080|DPT=8081|DPT=8443|DPT=8888|DPT=9100|DPT=9999|DPT=10000|DPT=32768|DPT=49152|DPT=49157|DPT=49153|DPT=49154|DPT=49155|DPT=49156) .*

        ignoreregex =


fail2ban-restart-scanban:
  service.running:
    - name: fail2ban
    - restart: True
    - watch:
      - file: /etc/fail2ban/filter.d/scanban.conf
