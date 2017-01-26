{% from "monit/map.jinja" import monit with context %}

{#- This is the main configuration file #}
{{ monit.config }}:
  file.managed:
    - source: salt://monit/files/monitrc
    - template: jinja
    - makedirs: True
    - mode: '0700'
    - watch_in:
      - service: {{ monit.service.name }}
    - context:
        config_includes: {{ monit.config_includes }}
        http_access: {{ monit.http_access }}

{#- This is the mail alert configuration #}
{% if monit.mail_alert is defined %}
{{ monit.config_includes }}/mail:
  file.managed:
    - source: salt://monit/files/mail
    - template: jinja
    - makedirs: True
    - watch_in:
      - service: {{ monit.service.name }}
    - context:
      mail_alert: {{ monit.mail_alert }}
{% endif %}

{#- This is populated by modules configuration
    from the contents of pillar. #}
{{ monit.config_includes }}/modules:
  file.managed:
    - source: salt://monit/files/modules
    - template: jinja
    - makedirs: True
    - watch_in:
      - service: {{ monit.service.name }}
    - context:
      modules: {{ monit.modules }}
