-- ============================================================
-- Task 3.7 — Joining Tables of Data in SQL
-- Author: Akeel Alramadhan
-- ============================================================

-- ------------------------------------------------------------
-- Step 1 — Top 10 countries by number of customers
-- ------------------------------------------------------------
SELECT
  co.country,
  COUNT(DISTINCT cu.customer_id) AS customer_count
FROM customer AS cu
JOIN address AS a  ON cu.address_id = a.address_id
JOIN city    AS ci ON a.city_id     = ci.city_id
JOIN country AS co ON ci.country_id = co.country_id
GROUP BY co.country
ORDER BY customer_count DESC
LIMIT 10;

-- ------------------------------------------------------------
-- Step 2 — Top 10 cities within the top-10 countries
-- ------------------------------------------------------------
SELECT
  ci.city,
  COUNT(cu.customer_id) AS customer_count
FROM customer AS cu
JOIN address AS a  ON cu.address_id = a.address_id
JOIN city    AS ci ON a.city_id     = ci.city_id
JOIN country AS co ON ci.country_id = co.country_id
WHERE co.country IN (
  'India', 'China', 'United States', 'Japan', 'Mexico',
  'Brazil', 'Russian Federation', 'Philippines', 'Turkey', 'Indonesia'
)
GROUP BY ci.city
ORDER BY customer_count DESC
LIMIT 10;

-- ------------------------------------------------------------
-- Step 3 — Top 5 highest-paying customers within the top-10 cities
-- ------------------------------------------------------------
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
LIMIT 5;
