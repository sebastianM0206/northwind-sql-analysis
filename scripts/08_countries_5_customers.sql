---
--- Which countries have more than 5 customers, and how many do they have?
---
select country, count(*) as customer_amount
from customers
group by country
having count(*) > 5
order by customer_amount desc

