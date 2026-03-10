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
-- 10. Find the total number of films rented by each customer, including their ID and full name
-- =============================================
/* Using INNER JOIN because we only want the matching rows between the tables */

SELECT c.customer_id, c.first_name, c.last_name, COUNT(r.rental_id) AS total_films_rented
	FROM customer AS c
    INNER JOIN rental AS r
		ON c.customer_id = r.customer_id
	GROUP BY c.customer_id, c.first_name, c.last_name;
		
-- =============================================
-- 11. Find the total number of films rented by each category and show the result and the category name
-- =============================================
/* Using INNER JOIN because we only want the matching rows between the tables */

SELECT COUNT(r.rental_id) AS total_films_rented, ca.category_id, ca.name AS category_name
	FROM rental AS r
	INNER JOIN inventory AS i
		ON r.inventory_id = i.inventory_id
	INNER JOIN film AS f
		ON f.film_id = i.film_id
	INNER JOIN film_category AS fc
		ON fc.film_id = f.film_id
	INNER JOIN category AS ca
		ON ca.category_id = fc.category_id
	GROUP BY ca.category_id, ca.name;
    
-- =============================================
-- 12. Find the length average by each rating and show the result and the rating
-- =============================================

SELECT AVG(length) AS average_length_rating, rating
	FROM film
    GROUP BY rating;

-- =============================================
-- 13. Find the actors (full name) who appear in the film "Indian Love"
-- =============================================
/* Using INNER JOIN because we only want the matching rows between the tables */

SELECT a.first_name, a.last_name, f.title
	FROM actor AS a
    INNER JOIN film_actor AS fa
		ON fa.actor_id = a.actor_id
	INNER JOIN film AS f
		ON fa.film_id = f.film_id
	WHERE f.title = 'Indian Love';

-- =============================================
-- 14. Find the title of all films that contain "dog" or "cat" in their description
-- =============================================

SELECT title, description
	FROM film
    WHERE description LIKE '%dog%' OR description LIKE '%cat%';

-- =============================================
-- 15. Find actors who do not appear in any film of film_actor table
-- =============================================

SELECT a.first_name, a.last_name
	FROM actor AS a
    WHERE a.actor_id NOT IN (
		SELECT fa.actor_id
			FROM film_actor AS fa);

-- =============================================
-- 16. Find the title of all the films whose release_year is between 2005 and 2010
-- =============================================

SELECT title, release_year
	FROM film
    WHERE release_year BETWEEN 2005 AND 2010;

-- =============================================
-- 17. Find the title of all the films whose rating is the same as "Family"
-- =============================================

SELECT title, rating
	FROM film
    WHERE rating = (
		SELECT rating
			FROM film
            WHERE title = 'Family');
	
-- =============================================
-- 18. Find actors who appear in more than 10 films
-- =============================================

SELECT a.first_name, a.last_name, COUNT(DISTINCT f.film_id) AS total_films
	FROM actor AS a
    INNER JOIN film_actor AS fa
		ON a.actor_id = fa.actor_id
	INNER JOIN film AS f
		ON fa.film_id = f.film_id
	GROUP BY a.first_name, a.last_name
    HAVING total_films > 10;

-- =============================================
-- 19. Find the title of films with "R" rating and whose length is longer than 2 hours on film table
-- =============================================

SELECT title, rating, length 
	FROM film
    WHERE rating = 'R' AND length > 120;

-- =============================================
-- 20. Find all categories whose average film length is longer than 120 minutes
-- =============================================

SELECT ca.name, AVG(f.length) AS AVG_category_length
	FROM category AS ca
    INNER JOIN film_category AS fc
		ON ca.category_id = fc.category_id
	INNER JOIN film AS f
		ON fc.film_id = f.film_id
	GROUP BY ca.name
    HAVING AVG_category_length > 120;