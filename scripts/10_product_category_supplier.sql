---
--- List every product with its category name and supplier name.
---
select p.product_id, p.product_name, ca.category_name , su.company_name as supplier_name
from products p
join categories ca
on p.category_id = ca.category_id 
join suppliers su
on p.supplier_id = su.supplier_id
order by p.product_id desc