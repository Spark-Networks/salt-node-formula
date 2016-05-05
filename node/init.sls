{% set pillar_get = salt['pillar.get'] -%}
include:
{%- if pillar_get('node:install_from_source') %}
  - .source
{%- elif pillar_get('node:install_from_binary') %}
  - .binary
{%- else %}
  - .pkg
{%- endif %}
  - .config

# this was added to allow using requires on this formula; can be removed once
# that bug fix is merged into the next mainstream release
# https://github.com/saltstack/salt/issues/10852
dummy_testfile_include:
  module:
    - wait
    - name: test.ping
