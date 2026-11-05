---
--- List all customers from Germany, showing company name, city, and contact name.
---

select company_name, city, contact_name
from customers
where country = 'Germany';