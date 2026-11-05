---
--- What is the average freight cost per shipping company
---
select sh.company_name as Shipping_company, round(avg(o.freight)::numeric,2) as Average_freight_cost
from orders o
join shippers sh
on o.ship_via = sh.shipper_id
group by o.ship_via, sh.company_name
