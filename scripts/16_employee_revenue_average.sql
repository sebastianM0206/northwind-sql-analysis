---
--- Which employees have sold more than the average employee’s total revenue?
---

with employees_revenue as (
	select
		o.employee_id,
		round(sum(od.unit_price * od.quantity * (1-od.discount))::numeric, 2) as employee_revenue
	from order_details od
	join orders o
	on o.order_id = od.order_id 
	group by o.employee_id
)

select employee_id, employee_revenue
from employees_revenue
where employee_revenue > (
	select 
		avg(employee_revenue)
	from employees_revenue
	)
order by employee_revenue Desc