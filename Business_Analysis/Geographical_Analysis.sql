-- **************** Geographic Analysis ***************** -- 

-- 1. Which state generates the highest revenue?

with state_revenue as (
   select customer_state, 
   sum(price) as highest_revenue
from sales_base 
group by customer_state 
)
select customer_state,
       highest_revenue
from state_revenue
order by highest_revenue desc limit 1;


-- "SP" State is the state which genereate the highest Reveneue of '5202955.05'. 


-- 2. Which states have the lowest sales?

select customer_state , sum(price) lowest_sales
from sales_base 
group by customer_state 
order by lowest_sales asc limit 1;

-- The Lowest sales of 7829 is genereated by the "RR" state.

-- 3. Which states have the most customers? 

select 
    customer_state, 
	count(distinct customer_id) as most_Customer_State
from sales_base 
group by customer_state
order by most_Customer_State desc limit 1;

-- "Sao Paulo" has the highest customer base with 41,375 customers. 

-- 4. Top 5 Cities By revenue ?

select customer_city, sum(price) as total_revenue
from sales_base 
group by customer_city
order by total_revenue desc limit 5;

-- "São Paulo" has a significantly larger revenue compared to other cities,
-- with around 1.9 million and the rest of cities are below the 1 million. 


-- 5. Top Cities by customer count ?

select customer_city, count(distinct customer_id) as customer_count 
from sales_base
group by customer_city 
order by customer_count desc limit 5;

-- "Sao Paulo" city has the highest customer base of 15,402 and rest of the 
-- cities have significantly low customer ranging from around 2000 to 7000.
