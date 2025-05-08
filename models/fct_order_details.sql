{{ config(materialized='table') }}

WITH orders AS (
    SELECT * FROM {{ ref('orders') }}
),
customers AS (
    SELECT * FROM {{ ref('customers') }}
),
products AS (
    SELECT * FROM {{ ref('products') }}
)

SELECT 
    o.id AS order_id,
    o.order_date,
    o.total_amount,
    c.name AS customer_name,
    c.email AS customer_email,
    p.name AS product_name,
    p.category,
    p.price AS product_price
FROM orders o
JOIN customers c ON o.id = c.id
JOIN products p ON p.id = o.id  
