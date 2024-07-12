
SELECT 
--fact    
    f.order_date,
    f.order_id,
    order_required_date,
    order_ship_date,
    order_freight,
    order_unit_price,
    order_quantity,
    order_discount,
    order_ship_name,
    order_ship_address,
    order_ship_city,
    order_revenue,
    days_to_ship,
    is_delayed_order,
    order_ship_region,
    order_ship_postal_code,
    order_ship_country,
    order_shipping_company,

--customer
    c.customer_id,
    customer_contact_name,
	customer_contact_title,
	customer_company_name,
	customer_city,
	customer_country,

--product
    p.product_id,
    p.product_name,
    p.supplier_name,
    p.supplier_contact,
    p.supplier_contact_title,
    p.supplier_city,
    p.supplier_country,
    p.category_name,
    p.category_description,
    p.quantity_per_unit,
    p.unit_price,
    p.units_in_stock,
    p.units_on_order,
    p.reorder_level,
    p.discontinued,

--employee
    f.employee_id,
    employee_full_name,
    employee_title,
    employee_birth_date, 
    employee_hire_date,
    employee_city, 
    employee_region,
    employee_country
    
--dim_date

    ,date_day
    ,prior_date_day
    ,next_date_day
    ,prior_year_date_day
    ,prior_year_over_year_date_day
    ,day_of_week
    ,day_of_week_iso
    ,day_of_week_name
    ,day_of_week_name_short
    ,day_of_month
    ,day_of_year
    ,week_start_date
    ,week_end_date
    ,prior_year_week_start_date
    ,prior_year_week_end_date
    ,week_of_year
    ,iso_week_start_date
    ,iso_week_end_date
    ,prior_year_iso_week_start_date
    ,prior_year_iso_week_end_date
    ,iso_week_of_year
    ,prior_year_week_of_year
    ,prior_year_iso_week_of_year
    ,month_of_year
    ,month_name
    ,month_name_short
    ,month_start_date
    ,month_end_date
    ,prior_year_month_start_date
    ,prior_year_month_end_date
    ,quarter_of_year
    ,quarter_start_date
    ,quarter_end_date
    ,year_number
    ,year_start_date
    ,year_end_date
FROM 
   {{ref('fact_sales') }} f
   
JOIN 
    {{ref('dim_product') }} p ON f.product_key = p.product_key
JOIN 
    {{ref('dim_employee') }}  e ON f.employee_key = e.employee_key
JOIN 
    {{ref('dim_customer') }} c ON f.customer_key = c.customer_key
JOIN 
    {{ref('dim_date') }} d ON f.order_date = d.date_day
  
ORDER BY 
    order_revenue ASC
