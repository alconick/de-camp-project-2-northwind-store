
{{
    config(
        materialized='incremental',
		unique_key='employee_id',
		incremental_strategy='delete+insert',
    )
}}

select
   employee_id, 
   last_name, 
   first_name, 
   title, 
   title_of_courtesy, 
   birth_date, 
   hire_date, 
   address, 
   city, 
   region, 
   postal_code, 
   country, 
   home_phone, 
   extension, 
   photo, 
   notes, 
   reports_to, 
   photo_path,
   _airbyte_extracted_at as last_update
from {{source('northwind', 'employees')}}
	

{% if is_incremental() %}
	where last_update > (select max(last_update) from {{ this }} )
{% endif %}   