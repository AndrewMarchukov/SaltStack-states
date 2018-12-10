{% if grains['os'] == 'Debian' %}
{% set os = 'debian' %}
{% endif %}

{% if grains['os'] == 'Ubuntu' %}
{% set os = 'ubuntu' %}
{% endif %}

install_zabbix:
  pkg.installed:
    - sources:
      - zabbix-release: https://repo.zabbix.com/zabbix/3.4/{{ os }}/pool/main/z/zabbix-release/zabbix-release_3.4-1+{{ grains['oscodename'] }}_all.deb

zabbix_agent:
  pkg.latest:
    - refresh: True
    - name: zabbix-agent

zabbix_sender:
  pkg.latest:
    - name: zabbix-sender


zabbix-agent:
  service.running:
    - name: zabbix-agent
    - restart: True
    - watch:
      - pkg: zabbix-agent
