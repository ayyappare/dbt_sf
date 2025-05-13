{{ config(
    materialized='incremental',
    unique_key='order_id'
) }}

WITH orders AS (
    SELECT * FROM {{ ref('orders') }}
    {% if is_incremental() %}
        WHERE order_date > (SELECT MAX(order_date) FROM {{ this }})
    {% endif %}
),
customers AS (
    SELECT * FROM {{ ref('customers1') }}
),
products AS (
    SELECT * FROM {{ ref('products') }}
)

SELECT 
    o.order_id,
    o.order_date,
    c.customer_name,
    c.email AS customer_email,
    p.product_name,
    p.price AS product_price,
    o.quantity,
    (o.quantity * p.price) AS total_price
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
JOIN products p ON o.product_id = p.product_id
