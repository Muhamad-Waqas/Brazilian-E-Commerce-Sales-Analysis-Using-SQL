-- **************** Product Analysis ****************** -- 


-- 1. Top 10 Category by Revenue ? 

select
     product_category_name as pc ,
	 sum(price) as generate_revenue
from sales_base
group by pc 
order by generate_revenue desc
limit 10;

-- "Beleza_saude" Category is the  Most highest Revenue Generated Category among 
-- other Categories. 


-- 2. Top 10 Lowest renenue generated Category? 

select product_category_name as pc, sum(price) as lowest_reveneue
from sales_base 
group by pc 
order by lowest_reveneue asc limit 10;

-- The 'seguros_e_servicos' is the lowest revneue genereated category. --

-- 3. Which region has the highest average order value?

select customer_state , avg(price) as avg_highest_order
from sales_base 
group by customer_state
order by avg_highest_order desc limit 1;

-- The Highest average order value region is "PB" region, With avgerage
-- highest order 191.475.

-- 4. What is the average price of each product category?

select 
    distinct product_category_name, 
	avg(price) avg_price_per_category
from sales_base 
group by product_category_name ;



-- 5. Which product category is most popular in a specific region?


with category_orders as (
    select
        customer_state,
        product_category_name,
        count(order_id) as total_orders
    from sales_base
    group by customer_state, product_category_name
),

ranked_categories as (
    select
        customer_state,
        product_category_name,
        total_orders,
        rank() over(
            partition by customer_state
            order by total_orders desc
        ) as category_rank
    from category_orders
)

select
    customer_state,
    product_category_name,
    total_orders
from ranked_categories
where category_rank = 1;
  