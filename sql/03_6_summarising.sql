-- ============================================================
-- Task 3.6 — Summarising and Cleaning Data
-- Author: Akeel Alramadhan
-- ============================================================

-- ------------------------------------------------------------
-- Step 1 — Data quality checks (missing-value scan)
-- ------------------------------------------------------------
SELECT
  COUNT(*)              AS total_rows,
  COUNT(film_id)        AS non_null_film_id,
  COUNT(title)          AS non_null_title,
  COUNT(description)    AS non_null_description,
  COUNT(rental_duration) AS non_null_rental_duration,
  COUNT(rental_rate)    AS non_null_rental_rate,
  COUNT(length)         AS non_null_length,
  COUNT(replacement_cost) AS non_null_replacement_cost,
  COUNT(rating)         AS non_null_rating
FROM film;

-- ------------------------------------------------------------
-- Step 2A — Numerical descriptive statistics on the film table
-- ------------------------------------------------------------
SELECT
  MIN(length)           AS min_length,
  MAX(length)           AS max_length,
  AVG(length)           AS avg_length,
  MIN(rental_rate)      AS min_rental_rate,
  MAX(rental_rate)      AS max_rental_rate,
  AVG(rental_rate)      AS avg_rental_rate,
  MIN(replacement_cost) AS min_replacement_cost,
  MAX(replacement_cost) AS max_replacement_cost,
  AVG(replacement_cost) AS avg_replacement_cost
FROM film;

-- ------------------------------------------------------------
-- Step 2B — Mode of film rating
-- ------------------------------------------------------------
SELECT MODE() WITHIN GROUP (ORDER BY rating) AS most_common_rating
FROM film;

-- ------------------------------------------------------------
-- Step 2C — Customer numerical statistics
-- ------------------------------------------------------------
SELECT
  MIN(customer_id)   AS min_customer_id,
  MAX(customer_id)   AS max_customer_id,
  COUNT(customer_id) AS total_customers
FROM customer;

-- ------------------------------------------------------------
-- Step 2D — Mode of customer active status
-- ------------------------------------------------------------
SELECT MODE() WITHIN GROUP (ORDER BY active) AS most_common_active_status
FROM customer;

-- ------------------------------------------------------------
-- Step 3 — Grouped statistics (rental rate by rating)
-- ------------------------------------------------------------
SELECT
  rating,
  AVG(rental_rate) AS avg_rental_rate
FROM film
GROUP BY rating
ORDER BY avg_rental_rate DESC;

-- Min and max rental duration grouped by rating
SELECT
  rating,
  MIN(rental_duration) AS min_rental_duration,
  MAX(rental_duration) AS max_rental_duration
FROM film
GROUP BY rating
ORDER BY rating;
