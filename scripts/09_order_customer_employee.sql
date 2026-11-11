---
--- Show each order’s ID, customer name, and the employee who handled it (full name).
---
select o.order_id, c.company_name, (e.first_name || ' ' || e.last_name) as employee_name
from orders o
join customers c 
on o.customer_id = c.customer_id 
join employees e
on o.employee_id = e.employee_id
order by order_id desc
