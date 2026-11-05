---
--- Calculate month-over-month revenue growth percentage.
--- 

with month_Revenue as (
select
	extract (year from o.order_date) as order_years,
	extract(month from o.order_date) as  order_months,
	ROUND(SUM(od.unit_price * od.quantity * (1-od.discount))::numeric,2) as monthlyRevenue 
from orders o
join order_details od
on o.order_id = od.order_id
group by order_years, order_months 
),
previous_revenue as (
	select
		order_years,
		order_months,
		monthlyRevenue,
		lag(monthlyRevenue) over (order by order_years,order_months) as previous_month
	from month_revenue
)

select
	order_years,
	order_months,
	monthlyRevenue,
	round((monthlyRevenue - previous_month)/ previous_month * 100, 2) as percentage_difference
from previous_revenue
order by order_years, order_months asc