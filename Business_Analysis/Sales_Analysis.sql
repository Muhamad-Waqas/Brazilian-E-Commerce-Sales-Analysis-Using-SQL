-- ****************** Sales Analysis ******************* -- 

-- 1. What is average reveneu per customer?

with customer_revenue as (
    select
        customer_id,
        sum(price) as revenue
   from sales_base
    group by customer_id
)

select
    avg(revenue) as avg_customer_revenue
from customer_revenue;
-- Avgerage Revenue per customer is around 137. 


-- 2. What is total revenue?

select sum(price) as total_revenue
from sales_base;  -- call view as sales_base

-- total Revenue is : 13591643.70 -- 


-- 3. What is monthly sales trend ?

with monthly_sales as (
    select
        date_trunc('month', order_purchase_timestamp) as month,
        sum(price) as sales
    from sales_base
    group by month
)

select
    month,
    sales,
    lag(sales) over (order by month) as previous_month_sales,
    round(
        ((sales - lag(sales) over (order by month))
         / lag(sales) over (order by month)) * 100,
        2
    ) as growth_pct
from monthly_sales;

-- 4. Which region generate the most sales ?

with state_sales as(
    select
        customer_state,
        sum(price) as revenue
    from sales_base
    group by customer_state
)

select
    customer_state,
    revenue,
    rank() over(order by revenue DESC) AS revenue_rank 
from state_sales;

-- SP 'São Paulo' region generate the most sales of '5202955'.


-- 5. Which month generate the lowest sales ? 

with monthly_sales as (
    select
        date_trunc('month', order_purchase_timestamp) as month,
        sum(price) as revenue
    from sales_base
    group by month
)

select *
from (
    select
        month,
        revenue,
        rank() over (order by revenue asc) as lowest_rank
    from monthly_sales
) 
where lowest_rank = 1;

-- -- Insight:
-- December 2016 recorded the lowest sales, indicating the weakest
-- revenue performance across the all period.


-- 6. Which year has the highest revenue?

with yearly_sales as (
    select
        extract(year from order_purchase_timestamp) as year,
        sum(price) as revenue
    from sales_base
    group by year
)

select
    year,
    revenue,
    dense_rank() over (order by revenue desc) as revenue_rank
from yearly_sales;

-- 2018 generated the highest revenue of 49785.92, 
-- This could be because the business had more time to grow and mature.


-- 7. Which year has the lowest reveneue? 

with yearly_sales as (
    select
        extract(year from order_purchase_timestamp) as year,
        sum(price) as revenue
    from sales_base
    group by year
)

select
    year,
    revenue,
    rank() over (order by revenue asc) as lowest_rank
from yearly_sales;

-- out of all 3 years, 2016 generated the lowest reveneue of 49785.92.
-- This is likely because the business was in its early stages during 2016.



