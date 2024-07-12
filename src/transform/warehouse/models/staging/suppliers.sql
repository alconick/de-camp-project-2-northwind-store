
{{
    config(
        materialized='incremental',
		unique_key='supplier_id',
		incremental_strategy='delete+insert',
    )
}}

select 
   supplier_id, 
   company_name, 
   contact_name, 
   contact_title, 
   address, 
   city, 
   region, 
   postal_code, 
   country, 
   phone, 
   fax, 
   homepage,
   _airbyte_extracted_at as last_update  
from {{source('northwind', 'suppliers')}}


{% if is_incremental() %}
	where last_update > (select max(last_update) from {{ this }} )
{% endif %}   