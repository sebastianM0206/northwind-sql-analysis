---
--- Show the 10 most expensive products with their name and unit price.
---
select product_name, unit_price
from products
order by unit_price desc 
limit 10