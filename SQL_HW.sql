-- 1a. select 1st & last name of actor
USE sakila;

SELECT first_name , last_name
FROM actor

-- 1b. single column labeled actor name


-- 2a. actors named Joe
SELECT actor_id, first_name, last_name
FROM actor
WHERE first_name = "JOE";

-- 2b. last name Gen 
SELECT actor_id, first_name, last_name
FROM actor
WHERE last_name LIKE '%GEN%';


-- 2c. last name has Li, sort by last name
SELECT actor_id, first_name, last_name
FROM actor
WHERE last_name LIKE '%LI%'
ORDER BY last_name;

-- 2d. display countries- Afghnaistan, Bangladesh, China
SELECT *
FROM country 
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