---
--- for each customer, find the average number of days between consecutive orders.
--- 
with order_amounts as (
	select
		 c.customer_id,
		 c.company_name,
		 o.order_id,
		 o.order_date,
		 lag(o.order_date) over (partition by c.customer_id order by o.order_date, o.order_id) as previous_date
		 
	from customers c
	left join orders o on c.customer_id = o.customer_id
),

date_difference as (
	select
		customer_id,
		company_name,
		round(avg(order_date - previous_date)::numeric, 2) as avg_date_difference
	from order_amounts
	group by customer_id, company_name
)

select *
from date_difference
order by avg_date_difference nulls last