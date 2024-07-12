
{{
    config(
        materialized='incremental',
		unique_key='product_id',
		incremental_strategy='delete+insert',
    )
}}

select 
    product_id, 
    product_name, 
    supplier_id, 
    category_id, 
    quantity_per_unit, 
    unit_price, 
    units_in_stock, 
    units_on_order, 
    reorder_level, 
    discontinued,
    _airbyte_extracted_at as last_update  
from {{source('northwind', 'products')}}



{% if is_incremental() %}
	where last_update > (select max(last_update) from {{ this }} )
{% endif %}   