{{
    config(
        materialized='incremental',
		unique_key='shipper_id',
		incremental_strategy='delete+insert',
    )
}}


select 
   shipper_id, 
   company_name, 
   phone,
   _airbyte_extracted_at as last_update  
from {{source('northwind', 'shippers')}}



{% if is_incremental() %}
	where last_update > (select max(last_update) from {{ this }} )
{% endif %}   