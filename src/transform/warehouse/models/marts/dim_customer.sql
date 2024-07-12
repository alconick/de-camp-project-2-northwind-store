
{{
    config(
        materialized='incremental',
		unique_key='customer_key',
		incremental_strategy='delete+insert',
    )
}}

select 
    {{dbt_utils.generate_surrogate_key(['customer_id']) }} as customer_key,
	customer_id,
	contact_name as customer_contact_name,
	contact_title as customer_contact_title,
	company_name  as customer_company_name,
	city as customer_city,
	country as customer_country,
    last_update customer_last_update
from {{ref('customers') }} 


{% if is_incremental() %}
	where customer_last_update > (select max(customer_last_update) from {{ this }} )
{% endif %}