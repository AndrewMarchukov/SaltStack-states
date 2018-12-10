{% for usr, pass in [('user', 'passwordhash'), ('user2', 'password2hash')] %}

{{ usr }}:
  user.present:
    - shell: /bin/bash
    - password: {{ pass }}
{{ usr }}_key:
  ssh_auth.present:
    - user: {{ usr }}
    - source: salt://ssh_keys/{{ usr }}.id_rsa.pub
{% endfor %}


/etc/sudoers.d/sysadmins:
  file.managed:
    - source: salt://sudoers.d/sysadmins
    - user: root
    - group: root
    - mode: 440
