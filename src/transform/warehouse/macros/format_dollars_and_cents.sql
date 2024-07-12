{% macro format_dollars_and_cents(column_expression) %}
    round( {{column_expression}}, 2)
{% endmacro %}