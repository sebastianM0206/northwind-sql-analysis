---
--- Show a running (cumulative) revenue total per customer over time, ordered by order date.
---
with order_revenues as (
	select 
		o.customer_id,
		c.company_name,
		o.order_id,
		o.order_date,
		SUM(od.unit_price * od.quantity * (1-od.discount)) as revenue 
	from order_details od
	join orders o 
	on o.order_id = od.order_id 
	join customers c
	on o.customer_id = c.customer_id
	group by o.order_id, o.customer_id, o.order_date, c.company_name
)
select 
	order_id,
	customer_id,
	company_name,
	order_date,
	round(revenue::numeric, 2) as order_revenue,
	round(SUM(revenue) over (
	partition by customer_id
	order by order_date, order_id):: numeric, 2) as running_total
from order_revenues
order by customer_id, order_date, order_id