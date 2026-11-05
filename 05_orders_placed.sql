---
--- How many orders did each customer place? Show only customers with more than 10 orders.
---
select  customer_id, count(*) as orders_placed
from orders 
group by customer_id
having count(*) > 10