---
--- Calculate monthly revenue for each year, ordered chronologically.
---

select 
	ROUND(SUM(od.unit_price * od.quantity * (1-od.discount))::numeric,2) as monthlyRevenue,
	EXTRACT(month FROM o.order_date) as order_month,
	EXTRACT(year from o.order_date) as order_year
from order_details od
join orders o
on o.order_id = od.order_id
group by order_year, order_month
order by order_year, order_month asc