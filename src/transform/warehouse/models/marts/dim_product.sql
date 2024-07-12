

SELECT 
    {{dbt_utils.generate_surrogate_key(['p.product_id']) }} as product_key,
    p.product_id,
    p.product_name,
    p.supplier_id,
    s.company_name AS supplier_name,
    s.contact_name AS supplier_contact,
    s.contact_title AS supplier_contact_title,
    s.address AS supplier_address,
    s.city AS supplier_city,
    s.country AS supplier_country,
    p.category_id,
    c.category_name,
    c.description AS category_description,
    p.quantity_per_unit,
    p.unit_price,
    p.units_in_stock,
    p.units_on_order,
    p.reorder_level,
    p.discontinued
FROM {{ref('products') }} p
LEFT JOIN {{ref('suppliers')}} s ON p.supplier_id = s.supplier_id
LEFT JOIN {{ref('categories')}} c ON p.category_id = c.category_id

