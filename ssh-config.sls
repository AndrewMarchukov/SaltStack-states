/etc/ssh/sshd_config:
  file.replace:
    - pattern: '#PasswordAuthentication yes'
    - repl: 'PasswordAuthentication no'
    - show_changes: True

sshd-passno:
  service.running:
    - name: ssh
    - restart: True
    - watch:
      - file: /etc/ssh/sshd_config
