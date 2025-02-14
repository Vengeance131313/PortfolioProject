select * from customers
select * from rentals
select * from movies
 
3)create
procedure ccount_rental (@title varchar(20))
as
select title ,(select count(rentalid) from
rentals) from movies
where title = @title
exec ccount_rental run

2)create procedure iinsert_rental
@movieid int,@customerid int,@rentaldate date
as
 begin

insert into rentals(rentaldate)
values(@rentaldate)
insert into movies(movieid)
values(@movieid)
insert into customers(customerid)
values(@customerid)
end
exec iinsert_rental 7,2,'1997-03-03'

1)create procedure uupdate_movie_stock
(@movieid int, @stock int)
as 
update movies
set stock = @stock
where movieid = @movieid


exec uupdate_movie_stock 1,2




