{{
    config(
        materialized='incremental',
		unique_key='category_id',
		incremental_strategy='delete+insert',
    )
}}

select 
	category_id,
	description,
	category_name,
	_airbyte_extracted_at as last_update
from {{source('northwind', 'categories')}}



{% if is_incremental() %}
	where last_update > (select max(last_update) from {{ this }} )
{% endif %}