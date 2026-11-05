---
--- Rank products by revenue within each category and return only the top 3 per category (RANK or ROW_NUMBER with PARTITION BY).
---
with product_revenue as (
	select 
		c.category_id, 
		c.category_name, 
		round(sum(od.unit_price * od.quantity *(1-od.discount))::numeric, 2) as total_revenue, 
		p.product_id, 
		p.product_name
	from order_details od
	join products p
		on od.product_id = p.product_id
	join categories c
		on p.category_id = c.category_id
	group by c.category_id, c.category_name, p.product_id, p.product_name 
),
product_ranking as (
	select
		category_name,
		product_name,
		total_revenue,
		RANK() OVER (PARTITION BY category_id ORDER BY total_revenue desc) as revenue_rank
	from product_revenue

)

select 
	category_name,
	product_name,
	total_revenue
from product_ranking
where revenue_rank <= 3
order by category_name, revenue_rank