-- Identify and Understand Joins -- 


-- customer <-> orders -- 
SELECT * FROM customers LIMIT 5;
SELECT * FROM orders LIMIT 5; 

-- verify relationships --
SELECT * FROM customers c
join orders o
on c.customer_id = o.customer_id;


-- orders <-> order_items -- 
SELECT * FROM orders LIMIT 5; 
SELECT * FROM order_items LIMIT 5;

-- Verify Relationship -- 
SELECT * FROM orders o
join order_items oi
on o.order_id = oi.order_id;


-- order_items <-> products -- 
SELECT * FROM order_items LIMIT 5;
SELECT * FROM products LIMIT 5;

-- verify joins --
SELECT * FROM order_items oi 
JOIN products p
on oi.product_id = p.product_id ;


-- orders <-> payments -- 
SELECT * FROM payments LIMIT 5;
SELECT * FROM orders LIMIT 5;

-- verify joins --
SELECT * FROM payments py
JOIN orders o
on py.order_id = o.order_id ;
