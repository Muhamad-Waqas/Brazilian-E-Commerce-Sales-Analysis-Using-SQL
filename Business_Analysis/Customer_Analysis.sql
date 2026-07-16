-- ******************* Customer Analysis ********************* -- 

-- 1. top 5 customers with most revenue

select
    customer_id,
    sum(price) as total_revenue
from sales_base
group by customer_id
order by total_revenue desc
limit 5;

-- insight:
-- the top customer generated 13,440 in revenue,
-- nearly twice the revenue of the rest of the customers.



-- 2. what is the average spend per customer?

select
    customer_id,
    round(avg(price), 2) as avg_spend
from sales_base
group by customer_id
order by avg_spend desc;

-- insight:
-- customer spending varies significantly,
-- indicating different purchasing behaviors across the customer base.



-- 3. how many customers purchased only once?

select count(*) as customers_purchased_once
from (
    select customer_id
    from sales_base
    group by customer_id
    having count(distinct order_id) = 1
);

-- insight:
-- there are 98,666 customers who purchased only once.
-- this suggests a low repeat purchase rate and an opportunity
-- to improve customer retention.



-- 4. how many customers are repeat customers?

with repeat_customers as (
    select
        customer_id
    from sales_base
    group by customer_id
    having count(customer_id) > 1
)

select count(*) as repeat_customers
from repeat_customers;


-- insight:
-- there are 9,803 repeat customers.
-- repeat customers represent a smaller portion of the customer base.



-- 5. customers with successful/completed orders

select
    count(distinct customer_id) as completed_orders
from sales_base
where lower(order_status) in ('delivered', 'invoiced');

-- insight:
-- most customers successfully completed their orders with no of 96,790.



-- 6. customer segmentation based on revenue
with customer_revenue as (
     select
        customer_id,
        sum(price) as total_revenue
    from sales_base
    group by customer_id
)
select
    case
        when total_revenue >= 3000 then 'vip customer'
        when total_revenue >= 1800 then 'high value customer'
        when total_revenue >= 1000 then 'medium value customer'
        else 'low value customer'
    end as customer_segment,
    count(*) as total_customers,
    round(avg(total_revenue), 2) as avg_revenue
from customer_revenue
group by customer_segment
order by avg_revenue desc;

-- insight:
-- customer segmentation helps identify high-value customers
-- who contribute a significant share of revenue.



