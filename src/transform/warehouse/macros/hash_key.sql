{% macro hash_key(year) %}
    (md5({{year}}))
{% endmacro %}