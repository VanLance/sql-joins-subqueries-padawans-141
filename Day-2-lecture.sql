SELECT * FROM CUSTOMER;

SELECT * FROM RENTAL;


SELECT first_name, last_name, rental_id
FROM Customer
INNER JOIN Rental
ON customer.customer_id = rental.customer_id;

SELECT CONCAT(first_name,' ' ,last_name) AS Name, COUNT(rental_id) AS RentalsMade
FROM Customer
INNER JOIN Rental
ON customer.customer_id = rental.customer_id
GROUP BY Name;

SELECT title, rating, CONCAT(first_name,' ' ,last_name) AS Name
FROM film
JOIN film_actor
ON film_actor.film_id = film.film_id
JOIN actor
ON actor.actor_id = film_actor.actor_id;

SELECT * FROM film;

SELECT * FROM category;

SELECT title, name
FROM film
INNER JOIN film_category
ON film_category.film_id = film.film_id
JOIN category
ON category.category_id = film_category.category_id
WHERE name = 'Animation';

SELECT *
FROM STAFF 
JOIN address ON staff.address_id = address.address_id
JOIN city ON address.city_id = city.city_id
JOIN country ON city.country_id = country.country_id
WHERE country = 'Canada';

SELECT * FROM STAFF;

SELECT COUNT(customer) FROM customer;

SELECT COUNT(customer_id), customer_id
FROM rental
GROUP BY customer_id;

-- Get count of rentals with "nick wahlberg"
SELECT * FROM actor;

SELECT COUNT(rental_id), CONCAT(first_name,' ' ,last_name) AS Name
FROM rental
JOIN inventory ON rental.inventory_id = inventory.inventory_id
JOIN film ON film.film_id = inventory.film_id
JOIN film_actor ON film_actor.film_id = film.film_id
JOIN actor ON actor.actor_id = film_actor.actor_id

WHERE last_name = 'Wahlberg' AND first_name = 'Nick'
GROUP BY Name;

SELECT * FROM LANGUAGE WHERE name = 'Mandarin';

SELECT name AS language, title, store_id
FROM LANGUAGE
JOIN film
ON language.language_id = film.language_id
JOIN inventory
ON film.film_id = inventory.film_id 
WHERE language.language_id = 4

-- subqueries

SELECT customer_id, SUM(amount)
FROM payment
GROUP BY customer_id
HAVING SUM(amount) >= 175
ORDER BY SUM(amount) DESC;


SELECT first_name, last_name, address_id
FROM customer
WHERE customer_id IN(
	SELECT customer_id
	FROM payment
	GROUP BY customer_id
	HAVING SUM(amount) >= 175
	ORDER BY SUM(amount) DESC
);

SELECT first_name, last_name, address
FROM customer
JOIN address ON customer.address_id = address.address_id
WHERE customer_id IN(
	SELECT customer_id
	FROM payment
	GROUP BY customer_id
	HAVING SUM(amount) >= 175
	ORDER BY SUM(amount) DESC
);

SELECT payment_id
FROM payment
GROUP BY payment_id
Having amount >= AVG(amount);

SELECT payment_id, amount 
FROM payment
WHERE amount > (
	SELECT AVG(amount)
	FROM payment
);

SELECT title
FROM film
WHERE film_id IN (
	SELECT film_id
		FROM film_actor
		WHERE actor_id IN (
			SELECT actor_id
			FROM actor
			WHERE last_name = 'Allen'
		)
)