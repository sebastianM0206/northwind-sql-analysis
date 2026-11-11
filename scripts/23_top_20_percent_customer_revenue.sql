---
--- what share of total revenue comes from the top 20% of customers?
---
with customer_revenue as (
	select
		o.customer_id,
		c.company_name,
		round(SUM(od.unit_price * od.quantity * (1-od.discount))::numeric, 2) as customer_revenue
	from order_details od
	join orders o on o.order_id = od.order_id 
	join customers c on c.customer_id = o.customer_id
	group by o.customer_id, c.company_name
),
bucketed as (
	select
		*,
		NTILE(5) over (order by customer_revenue Desc) as buckets
	from customer_revenue
		
), topRevenue as (
	select 
		(select sum(customer_revenue) from customer_revenue) as total_revenue, 
		sum(customer_revenue) as top_20_revenue
	from bucketed
	where buckets = 1

)


select round(((top_20_revenue / total_revenue) * 100 )::numeric, 2) as percent_revenue_from_top_20
from topRevenue