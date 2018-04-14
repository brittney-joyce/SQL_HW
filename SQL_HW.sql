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
SELECT first_name, last_name, address_id
FROM staff
LEFT JOIN address
	ON staff.address_id = address.address_id
    
SELECT 
	s.address_id, 
    s.first_name, 
    s.last_name,
    a.address_id,
    a.address,
FROM staff s
RIGHT JOIN address a 
ON c.address_id = a.address_id
ORDER BY c.address_id;