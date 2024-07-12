

{{
    config(
        materialized='incremental',
		unique_key='sales_key',
		incremental_strategy='delete+insert',
    )
}}

SELECT 
    {{dbt_utils.generate_surrogate_key(['o.order_id', 'od.product_id']) }} as sales_key,   
    {{dbt_utils.generate_surrogate_key(['o.order_id']) }} as order_key,   
    {{dbt_utils.generate_surrogate_key(['od.product_id']) }} as product_key,       
    {{dbt_utils.generate_surrogate_key(['o.customer_id']) }} as customer_key,    
    {{dbt_utils.generate_surrogate_key(['o.employee_id']) }} as employee_key,    
    o.order_date,
    o.order_id,
    o.customer_id,
    od.product_id,
    o.employee_id,
    o.required_date as order_required_date,
    o.shipped_date  as order_ship_date,
    sh.company_name as order_shipping_company,
    o.freight       as order_freight,
    od.unit_price   as order_unit_price,
    od.quantity     as order_quantity,
    od.discount     as order_discount,
    o.ship_name     as order_ship_name,
    o.ship_address  as order_ship_address,
    o.ship_city     as order_ship_city,
    od.unit_price * od.quantity   as order_revenue,
    o.shipped_date - o.order_date as days_to_ship,
    CASE WHEN shipped_date > required_date THEN 1 ELSE 0 END as is_delayed_order,
    o.ship_region   as order_ship_region,
    o.ship_postal_code as order_ship_postal_code,
    o.ship_country  as order_ship_country,
    o.last_update   as order_last_update
FROM {{ref('orders') }} o
LEFT JOIN {{ref('order_details')}} od ON o.order_id = od.order_id
LEFT JOIN {{ref('shippers')}} sh ON o.ship_via = sh.shipper_id
order by o.order_date



{% if is_incremental() %}
	where order_last_update > (select max(order_last_update) from {{ this }} )
{% endif %}