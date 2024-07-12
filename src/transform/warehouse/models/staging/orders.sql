
{{
    config(
        materialized='incremental',
		unique_key='order_id',
		incremental_strategy='delete+insert',
    )
}}
select 
    order_id, 
    customer_id, 
    employee_id, 
    order_date, 
    required_date, 
    shipped_date, 
    ship_via, 
    freight, 
    ship_name, 
    ship_address, 
    ship_city, 
    ship_region, 
    ship_postal_code, 
    ship_country,
    _airbyte_extracted_at as last_update    
from {{source('northwind', 'orders')}}


{% if is_incremental() %}
	where last_update > (select max(last_update) from {{ this }} )
{% endif %}   