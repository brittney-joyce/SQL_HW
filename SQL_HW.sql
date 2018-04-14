-- 1a. select 1st & last name of actor
USE sakila;

SELECT first_name , last_name
FROM actor

-- 1b. single column labeled actor name


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
UNIQUEIDENTIFIER 

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
    p.amount
FROM staff s
LEFT JOIN payment p
ON s.staff_id = p.staff_id
GROUP BY p.staff_id


SELECT 	s.staff_id AS 'Customer ID', 
		s.first_name AS 'First Name', 
		s.last_name AS 'Last Name', 
        p.payment_date AS 'Date'
        SUM(amount) AS 'Total Sold'
FROM sakila.payment p
	INNER JOIN staff s ON
	s.staff_id = p.staff_id
GROUP BY s.staff_id
ORDER BY p.payment_date

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

