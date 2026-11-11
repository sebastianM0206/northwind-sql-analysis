---
--- Find all orders placed in 1997 that shipped late (ShippedDate after RequiredDate).
---
select *
from orders
where order_date >= '1997-01-01' and order_date <= '1997-12-31' and
shipped_date > required_date 
