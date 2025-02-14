1)create function cube(@cubelength decimal,@cubewidth decimal,@cubeheight decimal)
returns decimal
as begin
return (@cubelength*@cubewidth*@cubeheight)
 end
 select dbo.cube (12.2,13.3,14.2);


 2)create function regionn(@regionparameter nvarchar(30))
 returns table
 as
return ( select customerid,companyname
from customers
where region = @regionparameter)
select * from  regionn('bc')

select * from customers
select * from orders
3)	create function custofcity(@city varchar(30))
returns @ordercustomertab table
(
 Contactname nvarchar(80),
City nvarchar(20),
OrderID int,
OrderDate date)
as begin
insert @ordercustomertab
select c.contactname,c.city,o.orderid,
o.orderdate from customers c
inner join orders o on c.customerid=o.customerid
where city = @city
return
end
select * from customercity('Berlin')

4)
create procedure outparam 
@paramout varchar(20) out
as
select @paramout = 'hellow world'

 
declare @message varchar(20)
exec outparam @paramout = @message out
select @message