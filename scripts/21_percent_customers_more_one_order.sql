---
--- what percentage of customers placed more than one order?
---

with order_amounts as (
	select
		 c.customer_id,
		 c.company_name,
		 count(o.order_id) as order_amount
	from customers c
	left join orders o on c.customer_id = o.customer_id
	group by c.customer_id, c.company_name
	having count(o.order_id) > 1
)

select round(100.0 * count(oa.*)/count(c.*)) as more_tan_one
from customers c
left join order_amounts oa on oa.customer_id =  c.customer_id
