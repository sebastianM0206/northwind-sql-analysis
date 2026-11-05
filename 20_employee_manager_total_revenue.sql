---
--- List each employee with their manager’s name, then add each manager’s team’s total revenue.
---
with employee_revenue as (
	select
		o.employee_id,
		SUM(od.unit_price * od.quantity * (1-od.discount)) as revenue
	from order_details od
	join orders o on od.order_id = o.order_id 
	group by o.employee_id
)


select
	e1.employee_id,
	(e1.first_name || ' ' || e1.last_name) as employee_name,
	(e2.first_name || ' ' || e2.last_name) as Manager,
	round(er.revenue::numeric,2) as Employee_revenue,
	round(SUM(er.revenue) over(
		partition by e1.reports_to)::numeric, 2) as Team_total_revenue
from employees e1
left join employee_revenue er on e1.employee_id = er.employee_id
left join employees e2 on e1.reports_to = e2.employee_id
order by manager NULLS first, employee_name