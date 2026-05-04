-- ============================================================
-- Task 3.8 — Performing Subqueries in SQL
-- Author: Akeel Alramadhan
-- ============================================================

-- ------------------------------------------------------------
-- Question 1 — Average amount paid by the top 5 customers
-- (Reuses the 3.7 Step 3 query as a subquery.)
-- Expected output: 108.54
-- ------------------------------------------------------------
SELECT
  AVG(top_5.total_amount_paid) AS average
FROM (
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
) AS top_5;

-- ------------------------------------------------------------
-- Question 2 — How are the top 5 customers distributed by country?
-- Compares "all customers per country" against "top-5 customers per country".
-- ------------------------------------------------------------
SELECT
  co.country,
  COUNT(DISTINCT cu.customer_id) AS all_customer_count,
  COUNT(DISTINCT t5.customer_id) AS top_customer_count
FROM customer AS cu
JOIN address AS a  ON cu.address_id = a.address_id
JOIN city    AS ci ON a.city_id     = ci.city_id
JOIN country AS co ON ci.country_id = co.country_id
LEFT JOIN (
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
) AS t5 ON co.country = t5.country
GROUP BY co.country
ORDER BY all_customer_count DESC, co.country;
