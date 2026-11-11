---
--- List products that are discontinued or have fewer than 10 units in stock.
---

select *
from products
where discontinued = 1 or units_in_stock < 10