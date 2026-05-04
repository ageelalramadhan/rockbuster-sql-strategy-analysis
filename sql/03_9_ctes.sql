-- ============================================================
-- Task 3.9 — Common Table Expressions (CTEs)
-- Author: Akeel Alramadhan
--
-- This file rewrites the Task 3.8 questions using CTEs instead of
-- nested subqueries. Same answers, more readable structure.
-- ============================================================

-- ------------------------------------------------------------
-- 1A — Average amount paid by the top 5 customers (CTE version)
-- ------------------------------------------------------------
WITH top_5_customers AS (
  SELECT
    cu.customer_id,
    cu.first_name,
    cu.last_name,
    co.country,
    ci.city,
    SUM(p.amount) AS total_amount_paid
  FROM customer AS cu
  JOIN address AS a  ON cu.address_id = a.address_id
  JOIN city    AS ci ON a.city_id     = ci.city_id
  JOIN country AS co ON ci.country_id = co.country_id
  JOIN payment AS p  ON cu.customer_id = p.customer_id
  WHERE ci.city IN (
    'Aurora', 'Acua', 'Adana', 'Adoni', 'Ahmadnagar',
    'Akishima', 'Akron', 'Allapuzha (Alleppey)', 'Allende', 'Alvorada'
  )
  GROUP BY cu.customer_id, cu.first_name, cu.last_name, co.country, ci.city
  ORDER BY total_amount_paid DESC
  LIMIT 5
)
SELECT AVG(total_amount_paid) AS average
FROM top_5_customers;

-- ------------------------------------------------------------
-- 1B — Top 5 customers by country (CTE version)
-- ------------------------------------------------------------
WITH top_5_by_country AS (
  SELECT
    cu.customer_id,
    co.country,
    SUM(p.amount) AS total_amount_paid
  FROM customer AS cu
  JOIN address AS a  ON cu.address_id = a.address_id
  JOIN city    AS ci ON a.city_id     = ci.city_id
  JOIN country AS co ON ci.country_id = co.country_id
  JOIN payment AS p  ON cu.customer_id = p.customer_id
  WHERE ci.city IN (
    'Aurora', 'Acua', 'Adana', 'Adoni', 'Ahmadnagar',
    'Akishima', 'Akron', 'Allapuzha (Alleppey)', 'Allende', 'Alvorada'
  )
  GROUP BY cu.customer_id, co.country
  ORDER BY total_amount_paid DESC
  LIMIT 5
)
SELECT
  co.country,
  COUNT(DISTINCT cu.customer_id) AS all_customer_count,
  COUNT(DISTINCT t5.customer_id) AS top_customer_count
FROM customer AS cu
JOIN address AS a  ON cu.address_id = a.address_id
JOIN city    AS ci ON a.city_id     = ci.city_id
JOIN country AS co ON ci.country_id = co.country_id
LEFT JOIN top_5_by_country AS t5 ON co.country = t5.country
GROUP BY co.country
ORDER BY all_customer_count DESC, co.country;
