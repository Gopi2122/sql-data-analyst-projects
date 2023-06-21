--q1: find the most senior employee based on job title

select * from employee
order by levels desc
limit 1

--q2 which countries hav most invoices?

select billing_country, count(invoice_id) as total from invoice
group by billing_country 
order by total desc 

--top 3 values of total invoices

select total from invoice
order by total desc
limit 3

-- write a query that returns one city that has the highest sum of invoice
--totals. return both the city name and sum of all invoices totals

select billing_city, sum(total) as total_invoice from invoice
group by billing_city
order by total_invoice desc
limit 1

--write a queery that returns the person who has spent the most money

select customer.customer_id, customer.first_name, customer.last_name,
sum(invoice.total) as total_sum from customer
join invoice on customer.customer_id = invoice.customer_id
group by customer.customer_id
order  by total_sum desc
limit 1

--write a query to return the email, first_name, last_name and genre 
--of all Rock music listeners. return ordered alphabetically starting with A

select Distinct email, first_name, last_name 
from customer
join invoice on customer.customer_id = invoice.customer_id
join invoice_line on invoice.invoice_id = invoice_line.invoice_id
join track on invoice_line.track_id = track.track_id
join genre on track.genre_id = genre.genre_id
where genre.name like 'Rock'
order by email 
           --or
select Distinct email, first_name, last_name  
from customer
join invoice on customer.customer_id = invoice.customer_id
join invoice_line on invoice.invoice_id = invoice_line.invoice_id
where track_id in(
select track_id from track
join genre on genre.genre_id = track.genre_id
where genre.name like 'Rock')
order by email

--let's invote the artist who have written the most Rock music in our data
--dataset. write a query to written the artist name and total track count 
--of the top 10 rock bands
select artist.artist_id, artist.name, count(artist.artist_id) as num_songs
from track
join album on album.album_id = track.album_id
join artist on artist.artist_id = album.artist_id
join genre on track.genre_id = genre.genre_id
where genre.name like 'Rock'
group by artist.artist_id
order by num_songs desc
limit 10