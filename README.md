# Northwind Traders: SQL Sales Analysis

I used the Northwind sample database (PostgreSQL) to answer business
questions about revenue, customers, products and employees, starting
with simple queries and working up to window functions. Revenue is
unit_price × quantity × (1 − discount) throughout.

## Data
The database has 14 tables and about 830 orders, from July 1996 to
May 1998. May 1998 is only a partial month. The table relationships
are in the [ER diagram](images/postgres-Northwind-public.png).

## Tools
PostgreSQL and DBeaver.

## SQL used
Joins (inner and left), GROUP BY / HAVING, CTEs, self-joins, CASE WHEN, subqueries and window functions
(RANK, LAG, SUM OVER, NTILE).

## What I found

1. The top 20% of customers (18 of the 89 that placed orders) bring in
   60.02% of total revenue. That is concentrated, but well below the
   80/20 rule, so the business doesn't depend on a tiny group of
   accounts.
   [query](scripts/23_top_20_percent_customer_revenue.sql) |
   [result](images/23_top_20_percent_customer_revenue.png)

2. QUICK-Stop, Ernst Handel and Save-a-lot Markets each bring in
   roughly $100K or more. Among the top 10 customers, the USA and
   Germany show up the most.
   [query](scripts/12_top_10_customers_revenue_country.sql) |
   [result](images/12_top_10_customers_revenue_country.png)

3. Revenue grew over time. Comparing July-December 1996 with
   July-December 1997, it went up 57.82%. Month-to-month growth jumps
   around a lot, and the drop in May 1998 is just the data ending
   mid-month.
   [growth query](scripts/18_month_revenue_growth_percentage.sql) |
   [result](images/18_month_revenue_growth_percentage.png) |
   [monthly revenue](scripts/13_Monthly_revenue_year.sql)

4. Beverages and Dairy Products make the most revenue. Beverages alone
   is $267,868.18, or 21.16% of the total. I also pulled the top 3
   products in each category.
   [category query](scripts/06_total_revenue_category.sql) |
   [top 3 per category](scripts/17_top_3_product_revenue_category.sql)

5. About 97% of customers ordered more than once. That makes sense for
   a wholesale business, but it probably wouldn't hold for consumer
   retail data.
   [query](scripts/21_percent_customers_more_one_order.sql)

## What I would recommend
- Look after the top 18 customers, since they bring in about 60% of
  revenue. Tracking how often they order would show early signs that
  one of them is drifting away.
- Reach out to customers whose gap between orders keeps growing,
  before they stop buying.
- Two customers never placed an order. Either follow up with them or
  clean them out of the customer list.

## Assumptions and limits
- Revenue includes discounts and leaves out freight.
- The top 20% is measured among the 89 customers who placed orders,
  using NTILE(5).
- The repeat-customer percentage uses all 91 customers as the base.
- The data only covers about two years, and 1996 and 1998 are partial
  years, so I compared matching months for growth.
- Northwind is sample data, so these results show the method, not real
  business performance.

## Repository
- `scripts/` has the SQL queries, numbered in the order I solved them.
- `images/` has screenshots of the results and the ER diagram.

## Running it
1. Create a PostgreSQL database and load the Northwind setup script
   [query](scripts/northwind.sql).
2. Open any query from `scripts/` in DBeaver or psql and run it.
