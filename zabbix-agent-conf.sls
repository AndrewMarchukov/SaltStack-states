/etc/zabbix/zabbix_agentd.conf:
  file.managed:
    - contents: |
        PidFile=/var/run/zabbix/zabbix_agentd.pid
        LogFile=/var/log/zabbix/zabbix_agentd.log
        LogFileSize=1
        DebugLevel=3
        Server=example.com
        StartAgents=8
        ServerActive=example.com
        Hostname={{ grains['host'] }}
        BufferSend=5
        BufferSize=600
        MaxLinesPerSecond=600
        Timeout=30
        AllowRoot=1
        Include=/etc/zabbix/zabbix_agentd.d/*.conf
        UnsafeUserParameters=0


zabbix-agent-conf:
  service.running:
    - name: zabbix-agent
    - restart: True
    - watch:
      - file: /etc/zabbix/zabbix_agentd.conf
