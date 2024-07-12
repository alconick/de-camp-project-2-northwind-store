


select 
    {{dbt_utils.generate_surrogate_key(['customer_id']) }} as customer_key,
	customer_id,
	contact_name as customer_contact_name,
	contact_title as customer_contact_title,
	company_name  as customer_company_name,
	city as customer_city,
	country as customer_country,
    last_update as customer_last_update
from {{ref('customers') }} c
