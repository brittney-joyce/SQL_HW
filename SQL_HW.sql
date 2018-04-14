-- 1a. select 1st & last name of actor
USE sakila;

SELECT first_name , last_name
FROM actor;

-- 1b. single column labeled actor name
SELECT CONCAT(first_name," ", last_name) 
AS Actor_Name
FROM actor;

-- 2a. actors named Joe
SELECT actor_id, first_name, last_name
FROM sakila.actor
WHERE first_name = "JOE";

-- 2b. last name Gen 
SELECT actor_id, first_name, last_name
FROM sakila.actor
WHERE last_name LIKE '%GEN%';


-- 2c. last name has Li, sort by last name
SELECT actor_id, first_name, last_name
FROM sakila.actor
WHERE last_name LIKE '%LI%'
ORDER BY last_name;

-- 2d. display countries- Afghnaistan, Bangladesh, China
SELECT *
FROM sakila.country 
WHERE country IN ('Afghanistan', 'Bangladesh', 'China');

-- 3a. add middle name column
ALTER TABLE actor
ADD COLUMN middle_name VARCHAR (20) ;

-- 3b. change middle name datatype 
ALTER TABLE actor
MODIFY middle_name BLOB ;

-- 3c. delete middle name
ALTER table actor
DROP COLUMN middle_name;

-- 4a. count last names
SELECT last_name, COUNT(*) 
FROM sakila.actor
GROUP BY last_name;

-- 4b. same last names
SELECT last_name, COUNT(*) 
FROM sakila.actor
GROUP BY last_name
HAVING COUNT(*) > 2;

-- 4c. fix actors last name
UPDATE sakila.actor
SET first_name = 'HARPO', last_name = 'WILLIAMS'
WHERE actor_id = 172;

-- 4d. change name back 


-- 5a. locate address schema
SHOW CREATE TABLE address

-- 6a. join staff and address
SELECT 
	s.address_id, 
    s.first_name, 
    s.last_name,
    a.address_id,
    a.address
FROM staff s
LEFT JOIN address a 
ON a.address_id = s.address_id
ORDER BY a.address_id;

-- 6b. join total amount sold by staff
SELECT 
	s.staff_id, 
    s.first_name,
    s.last_name,
    p.staff_id,
    p.payment_id,
    p.amount,
SUM(amount)
FROM staff s
INNER JOIN payment p
ON s.staff_id = p.staff_id
GROUP BY p.staff_id

-- 6c. number of actors per film
SELECT title, COUNT(actor_id)
FROM film a
INNER JOIN film_actor b
ON a.film_id = b.film_id
GROUP BY title;

-- 6d. hunchback impossible inventory
SELECT title, 
COUNT(inventory_id)
FROM film f
INNER JOIN inventory i 
ON f.film_id = i.film_id
WHERE title = "Hunchback Impossible";


-- 6e paid per customer
SELECT 
	c.customer_id, 
    c.first_name,
    c.last_name,
    p.customer_id,
    p.payment_id,
    p.amount
FROM customer c
LEFT JOIN payment p
ON c.customer_id = p.customer_id
GROUP BY c.customer_id
ORDER BY last_name ASC;

-- 7a. movies beging with K & Q
SELECT title 
FROM film f
WHERE language_id IN 
	(SELECT language_id 
    FROM language
    WHERE name = "English")
AND (title LIKE "K%") OR (title LIKE "Q%");

-- 7b. actors in Alone Trip
SELECT first_name, last_name
FROM actor
WHERE actor_id IN 
	(SELECT actor_id F
    FROM film_actor
    WHERE film_id IN
		(SELECT film_id 
        FROM film
		WHERE title = "Alone Trip"));

-- 7c. Canadian customers
SELECT first_name, last_name, email, country
FROM country a
LEFT JOIN customer b
ON a.country_id = b.customer_id
WHERE country = "Canada" ;

-- 7d. family films
SELECT title, category
FROM film_list
WHERE category = "Family";

-- 7e. most frequently rented movies
SELECT i.film_id, f.title, 
COUNT(r.inventory_id)
FROM inventory i
INNER JOIN rental r
ON i.inventory_id = r.inventory_id
INNER JOIN film_text f
on i.film_id = f.film_id
GROUP BY r.inventory_id
ORDER BY COUNT(r.inventory_id) DESC;

-- 7f. amount each store made
SELECT store.store_id, SUM(amount)
FROM store
INNER JOIN staff
ON store.store_id = staff.store_id
INNER JOIN payment 
ON payment.staff_id = staff.staff_id
GROUP BY store.store_id
ORDER BY SUM(amount);

-- 7g. each store's- store id, city, country
SELECT s.store_id, city, country
FROM store s
INNER JOIN customer cu
ON s.store_id = cu.store_id
INNER JOIN staff st
ON s.store_id = st.store_id
INNER JOIN address a
ON cu.address_id = a.address_id
INNER JOIN city ci
ON a.city_id = ci.city_id
INNER JOIN country coun
ON ci.country_id = coun.country_id;

-- 7h. top 5 grossing movies
SELECT name, 
SUM(amount)
FROM category c
INNER JOIN film_category fc
INNER JOIN inventory i
ON i.film_id = fc.film_id
INNER JOIN rental r
ON r.inventory_id = i.inventory_id
INNER JOIN payment p
GROUP BY name
LIMIT 5;

-- 8a. create view of top films
CREATE VIEW Top_Grossing_Films AS
SELECT name, SUM(p.amount)
FROM category c
INNER JOIN film_category fc
INNER JOIN inventory i
ON i.film_id = fc.film_id
INNER JOIN rental r
ON r.inventory_id = i.inventory_id
INNER JOIN payment p
GROUP BY name
LIMIT 5;

-- 8b. display new view
SELECT * FROM Top_Grossing_Films;

-- 8c. Drop view
DROP VIEW Top_Grossing_Films;