libpam-google-authenticator:
  pkg:
    - installed

/etc/pam.d/sshd:
  file.prepend:
    - text:
      - "auth required pam_google_authenticator.so"

/etc/ssh/sshd_config:
  file.replace:
    - pattern: ChallengeResponseAuthentication no
    - repl: ChallengeResponseAuthentication yes
    - show_changes: True

/home/user/.google_authenticator:
  file.managed:
    - source: salt://config/google_authenticator
    - user: user
    - group: user
    - mode: 400

my_id_1:
  file.prepend:
    - name: /etc/ssh/sshd_config
    - text:
      - "AuthenticationMethods publickey,keyboard-interactive"



ssh:
  service.running:
    - name: ssh
    - restart: True
    - watch:
      - file: /etc/ssh/sshd_config
