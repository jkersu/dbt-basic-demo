{% macro integer_to_dollar(column_name) %}
    ({{ column_name }} / 1000000)
{% endmacro %}
