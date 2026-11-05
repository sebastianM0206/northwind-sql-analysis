---
--- Show the top 10 customers by total revenue, with their country.
---
select c.customer_id, c.company_name, c.country, round(sum(od.unit_price * od.quantity * (1 - od.discount))::numeric, 2) as total_revenue
from customers c
join orders o
on c.customer_id = o.customer_id 
join order_details od
on o.order_id = od.order_id
group by c.customer_id, c.company_name, c.country
order by total_revenue desc
limit 10