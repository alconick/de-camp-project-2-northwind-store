

{% set category = dbt_utils.get_column_values(table=ref('categories'), column="category_name") %}

    SELECT 
        customer_key,
        min(order_date)    as customer_first_order_date,
        max(order_date)    as customer_most_recent_order_date,
        count(order_key)   as customer_total_orders,
        sum(order_revenue) as customer_total_spend,
        {% for category_name in category %}
        sum(case when category_name = '{{ category_name }}' then order_revenue else 0 end) as {{ category_name.replace("-", "_").replace("/", "_").replace(" ", "_") }}_total_spent
        {%- if not loop.last -%}
            ,
        {% endif %}
    {% endfor %}
   
    FROM {{ref('fact_sales') }} fs
    LEFT JOIN  {{ref('dim_product') }} p ON fs.PRODUCT_key = p.PRODUCT_key
    GROUP BY customer_key

