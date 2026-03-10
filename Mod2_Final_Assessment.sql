-- Connect to the sakila database, which simulates a film rental store
USE sakila; 

-- ============================================
-- 1. Select all film titles without duplicates
-- ============================================

SELECT DISTINCT title AS film_titles_no_duplicates
	FROM film;

-- =============================================
-- 2. Select all film titles with a "PG-13" rating
-- =============================================

SELECT title AS film_titles_PG13, rating
	FROM film
    WHERE rating = 'PG-13';

-- =============================================
-- 3. Find the title and description of all films that contain "amazing" in their description
-- =============================================

SELECT title, description
	FROM film
    WHERE description LIKE '%amazing%';

-- =============================================
-- 4. Find the title of all films longer than 120 minutes
-- =============================================

SELECT title, length 
	FROM film
    WHERE length > 120;

-- =============================================
-- 5. Show the full name of all actors
-- =============================================

SELECT first_name, last_name
	FROM actor;

-- =============================================
-- 6. Find name and surname of all actors with "Gibson" as surname
-- =============================================

SELECT first_name, last_name
	FROM actor
    WHERE last_name = 'Gibson';

-- =============================================
-- 7. Find the full name of all actors whose ID is between 10 and 20
-- =============================================

SELECT first_name, last_name, actor_id
	FROM actor
    WHERE actor_id BETWEEN 10 AND 20;

-- =============================================
-- 8. Select all film titles without a "R" or "PG-13" rating
-- =============================================

SELECT title, rating
	FROM film
    WHERE rating <> 'PG-13' AND rating <> 'R';

-- =============================================
-- 9. Count the total of films per rating and show the result and the rating
-- =============================================

SELECT COUNT(DISTINCT film_id) AS total_films, rating
	FROM film
    GROUP BY rating;

-- =============================================
-- 10. Find the total number of films rented by each customer, incluiding their ID and full name
-- =============================================

SELECT c.customer_id, c.first_name, c.last_name, COUNT(r.rental_id) AS total_films_rented
	FROM customer AS c
    INNER JOIN rental AS r
		ON c.customer_id = r.customer_id
	GROUP BY c.customer_id, c.first_name, c.last_name;
		
