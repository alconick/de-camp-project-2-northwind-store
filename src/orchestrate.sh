python -m main && cd transform/warehouse && dbt deps --target prod && dbt build --target prod