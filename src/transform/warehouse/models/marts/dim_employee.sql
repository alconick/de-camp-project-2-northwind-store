

{{
    config(
        materialized='incremental',
		unique_key='employee_key',
		incremental_strategy='delete+insert',
    )
}}


select 
    {{dbt_utils.generate_surrogate_key(['e.employee_id']) }} as employee_key,
    e.employee_id,
    e.first_name||' '||e.last_name as employee_full_name,
    e.title      as employee_title,
    e.birth_date as employee_birth_date, 
    e.hire_date  as employee_hire_date,
    e.city       as employee_city, 
    e.region     as employee_region,
    e.country    as employee_country,
    e.last_update as employee_last_update
from {{ ref('employees') }} e



{% if is_incremental() %}
	where employee_last_update > (select max(employee_last_update) from {{ this }} )
{% endif %}