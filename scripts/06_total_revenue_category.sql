---
--- What is the total revenue for each product category?
---
select p.category_id, c.category_name, round(sum(od.unit_price * od.quantity * (1 - od.discount))::numeric,2) as total_revenue
from order_details od
join products p
on p.product_id = od.product_id
join categories c
on c.category_id = p.category_id 
group by p.category_id, c.category_name
order by total_revenue DESC