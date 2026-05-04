-- ============================================================
-- Task 3.5 — Filtering Data
-- Author: Akeel Alramadhan
-- Database: Rockbuster Stealth (PostgreSQL)
-- ============================================================

-- 1a — Films whose title contains "Uptown"
SELECT film_id, title, description
FROM film
WHERE title ILIKE '%Uptown%';

-- 1b — Films longer than 120 minutes AND with a rental rate above $2.99
SELECT film_id, title, description
FROM film
WHERE length > 120
  AND rental_rate > 2.99;

-- 1c — Films with a rental duration between 3 and 7 days (inclusive)
SELECT film_id, title, description
FROM film
WHERE rental_duration BETWEEN 3 AND 7;

-- 1d — Films with a replacement cost under $14.99
SELECT film_id, title, description
FROM film
WHERE replacement_cost < 14.99;

-- 1e — Films rated either PG or G
SELECT film_id, title, description
FROM film
WHERE rating IN ('PG', 'G');
