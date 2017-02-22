{% from "monit/map.jinja" import monit with context %}

{#- This is the main configuration file #}
{{ monit.config }}:
  file.managed:
    - source: salt://monit/files/monitrc
    - template: jinja
    - makedirs: True
    - mode: '0700'
{%- if monit.service.status == 'running' %}
    - watch_in:
      - service: {{ monit.service.name }}
{%- endif %}

{#- This is the mail alert configuration #}
{% if monit.mail_alert is defined %}
{{ monit.config_includes }}/mail:
  file.managed:
    - source: salt://monit/files/mail
    - template: jinja
    - makedirs: True
{%- if monit.service.status == 'running' %}
    - watch_in:
      - service: {{ monit.service.name }}
{%- endif %}
{% endif %}

{#- This is populated by modules configuration
    from the contents of pillar. #}
{{ monit.config_includes }}/modules:
  file.managed:
    - source: salt://monit/files/modules
    - template: jinja
    - makedirs: True
{%- if monit.service.status == 'running' %}
    - watch_in:
      - service: {{ monit.service.name }}
{%- endif %}