
{{
    config(
        materialized='incremental',
		unique_key='customer_id',
		incremental_strategy='delete+insert',
    )
}}

select 
	customer_id,
	postal_code,
	company_name,
	contact_name,
	contact_title,
	address,
    city,
	case when country = 'USA' then 'United States' else country end as country ,
    region ,
    phone,
	fax,
	_airbyte_extracted_at as last_update
from {{source('northwind', 'customers')}}


{% if is_incremental() %}
	where last_update > (select max(last_update) from {{ this }} )
{% endif %}