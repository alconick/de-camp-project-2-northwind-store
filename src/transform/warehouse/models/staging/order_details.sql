{{
    config(
        materialized='incremental',
		unique_key= ['order_id','product_id'], 
		incremental_strategy='delete+insert',
    )
}}

select
    order_id, 
    product_id, 
    unit_price, 
    quantity, 
    discount,
    _airbyte_extracted_at as last_update      
from {{source('northwind', 'order_details')}}



{% if is_incremental() %}
	where last_update > (select max(last_update) from {{ this }} )
{% endif %}   