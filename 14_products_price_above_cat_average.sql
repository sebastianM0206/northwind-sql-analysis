---
--- Find products priced above the average price of their own category (correlated subquery or CTE).
---

WITH category_avg AS (
    SELECT category_id, AVG(unit_price) AS avg_unit_price
    FROM products
    GROUP BY category_id
)
SELECT
    p.product_id,
    p.product_name,
    p.category_id,
    p.unit_price,
    ROUND(ca.avg_unit_price::numeric, 2) AS category_avg_price
FROM products p
JOIN category_avg ca ON p.category_id = ca.category_id
WHERE p.unit_price > ca.avg_unit_price
ORDER BY p.category_id, p.unit_price DESC;