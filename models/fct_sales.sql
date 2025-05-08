{{ config(materialized='table') }}

select
    id,
    name as customer_name,
    email 
from {{ ref('customers') }}
