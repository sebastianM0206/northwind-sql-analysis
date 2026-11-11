---
--- Find customers who have never placed an order (use a LEFT JOIN).
--- 

select c.* 
from customers c
left join orders o
on o.customer_id = c.customer_id 
where o.order_id is null
