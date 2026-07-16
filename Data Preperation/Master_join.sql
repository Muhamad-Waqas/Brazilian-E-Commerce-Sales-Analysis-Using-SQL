-- Write Master join in view For Reusability -- 

CREATE VIEW sales_base AS
SELECT
    o.order_id,
    o.customer_id,
    o.order_status,
    o.order_purchase_timestamp,
    c.customer_city,
    c.customer_state,
    oi.product_id,
    oi.order_item_id,
    oi.price,
    oi.freight_value,
    p.product_category_name
FROM orders o
JOIN customers c
    ON o.customer_id = c.customer_id
JOIN order_items oi
    ON o.order_id = oi.order_id
JOIN products p
    ON oi.product_id = p.product_id;


