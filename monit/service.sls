# -*- coding: utf-8 -*-
# vim: ft=sls

{% from "monit/map.jinja" import monit with context %}

{{ monit.service.name }}:
  service.{{ monit.service.status }}:
    - enable: {{ monit.service.enable }}
    - restart: True
