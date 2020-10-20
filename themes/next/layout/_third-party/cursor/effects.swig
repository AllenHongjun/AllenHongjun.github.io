{% if theme.cursor.enable %}
  {% set cursor_effect = './js/src/cursor/' + theme.cursor.type + '.js' %}
  <script type="text/javascript" src="{{ cursor_effect }}"></script>
{% endif %}
