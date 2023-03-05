#In this lab, you will be using the Sakila database of movie rentals.
USE sakila;

# 1. Rank films by length (filter out the rows with nulls or zeros in length column). Select only columns title, length and rank in your output.
SELECT title, length, DENSE_RANK () OVER (ORDER BY length desc) AS "rank"
FROM film
WHERE length > 0;

# 2. Rank films by length within the rating category (filter out the rows with nulls or zeros in length column). In your output, only select the columns title, length, rating and rank.
SELECT f.title, f.length, f.rating, RANK() OVER (PARTITION BY f.rating ORDER BY f.length DESC) AS "rank"
FROM film f
WHERE f.length > 0;

# 3. How many films are there for each of the categories in the category table? Hint: Use appropriate join between the tables "category" and "film_category".
SELECT c.name, COUNT(*) AS num_of_films
FROM category c
LEFT JOIN film_category fc ON c.category_id = fc.category_id
GROUP BY c.name;

# 4. Which actor has appeared in the most films? Hint: You can create a join between the tables "actor" and "film actor" and count the number of times an actor appears.
SELECT a.first_name, a.last_name, COUNT(fa.actor_id) AS num_films
FROM actor a
LEFT JOIN film_actor fa ON a.actor_id = fa.actor_id
GROUP BY a.actor_id
ORDER BY num_films DESC
LIMIT 1;

# 5.Which is the most active customer (the customer that has rented the most number of films)? Hint: Use appropriate join between the tables "customer" and "rental" and count the rental_id for each customer.
SELECT c.first_name, c.last_name, COUNT(*) AS num_rentals
FROM customer c
LEFT JOIN rental r ON c.customer_id = r.customer_id
GROUP BY c.customer_id
ORDER BY num_rentals DESC
LIMIT 1;


