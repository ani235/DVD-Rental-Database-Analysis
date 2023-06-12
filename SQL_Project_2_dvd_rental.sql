/* Question 1: What are the top 10 and bottom 10 customers and their respective email addresses */

-- Top 10 customers by amount spent
select concat(a.first_name, ' ', a.last_name) as full_name, sum(b.amount) as total_spent, a.email
from customer a
left join 
payment b
on a.customer_id = b.customer_id
group by 1, 3
order by 2 desc

-- Bottom 10 customers by amount spent
select concat(a.first_name, ' ', a.last_name) as full_name, sum(b.amount) as total_spent, a.email
from customer a
left join 
payment b
on a.customer_id = b.customer_id
group by 1, 3
order by 2

/* Question 2: What are the top 10 and least 10 rented genres and what are their overall sales */

select * from category
select * from rental
select c.name as Genre, count(r.rental_id) as rental_demand, sum(amount) as total_sales
   from category c
   join film_category fc
   using(category_id)
   join inventory i 
   using(film_id)
   join rental r
   using(inventory_id)
   join payment p
   using(rental_id)
   group by 1
   order by 2 desc
   limit 10
   
select c.name as Genre, count(r.rental_id) as rental_demand, sum(amount) as total_sales
   from category c
   join film_category fc
   using(category_id)
   join inventory i 
   using(film_id)
   join rental r
   using(inventory_id)
   join payment p
   using(rental_id)
   group by 1
   order by 2 
   limit 10
  
/* Question 3: How many rented movies were returned on time, late, and early?*/

select case
		when f.rental_duration > date_part('day', r.return_date - r.rental_date) then 'returned early'
		when f.rental_duration = date_part('day', r.return_date - r.rental_date) then 'returned on time'
		else 'returned late'
		end as return_status,
		count(*) as no_of_films
		from film f
		inner join inventory i
		using(film_id)
		inner join rental r
		using(inventory_id)
		group by 1
		order by 2 desc
		
/*Question 4: Average rental rate for each genre ordered from the highest to the lowest*/

select name as Genre, round(avg(rental_rate), 2) as average_rental_rate from category
left join film_category
using(category_id)
left join film
using(film_id)
group by 1
order by 2 desc

/*Question 5: what is the customer base in each country and their total sales? */

select country, count(distinct customer_id) as customers, sum(amount) as total_sales from country
left join city 
using(country_id)
left join address
using(city_id)
left join customer
using(address_id)
left join payment 
using(customer_id)
group by 1
order by 2 desc

/*Question 6: How many distinct users have retned each genre*/

select * from category
select * from rental
select c.name as Genre, count(distinct r.customer_id) as total_demand 
   from category c
   join film_category fc
   using(category_id)
   join inventory i 
   using(film_id)
   join rental r
   using(inventory_id)
   join payment p
   using(rental_id)
   group by 1
   order by 2 desc
   limit 10