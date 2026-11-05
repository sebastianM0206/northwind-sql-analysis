---
--- Using CASE WHEN, bucket customers into High (revenue over $10,000), Medium ($5,000 to $10,000), and Low tiers, and count customers per tier.
---

with customer_revenue as (
select
	o.customer_id,
	SUM(od.unit_price * od.quantity * (1-od.discount)) as total_revenue
	from order_details od
	join orders o
	on o.order_id = od.order_id
	group by o.customer_id
),
customer_tiers as (
select
	customer_id,
	total_revenue,
	case
		when total_revenue > 10000 then 'High'
		when total_revenue >= 5000 and total_revenue <= 10000 then 'Medium'
		else 'Low'
	end as revenue_tier
from customer_revenue
)

select 
	count(customer_id),
	revenue_tier
from customer_tiers
group by revenue_tier
order by
	case revenue_tier
		when 'High' then 1
		when 'Medium' then 2
		when 'Low' then 3
	end
	

