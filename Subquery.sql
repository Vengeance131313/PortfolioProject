select * from customers
SELECT * FROM PRODUCTS

select categoryid,sum(unitsinstock) from(
Select categoryid,productname,productid,unitsinstock,
dense_rank() over(partition by categoryid order by unitsinstock) as rank
from products
)t
group by categoryid
select * from products

select sum(unitprice),condition from
(select productname,unitprice,categoryid,case 
when unitprice > 35 then 'High'
when unitprice >25 then 'Normal'
when unitprice >18 then 'Cheap'
else 'very cheap'  
end as condition
from products
) t  
  group by condition

 select productname,unitsinstock,
 lead(unitprice) over(order by unitsinstock) next,
  lag(unitprice) over(order by unitsinstock) previous,
  FIRST_VALUE(unitprice) over(order by unitsinstock) firstvalue,
   FIRST_VALUE(unitprice) over(order by unitsinstock desc) lastvalue
 from products


 select * from products

select * from(
 SELECT PRODUCTNAME,UNITSINSTOCK,UNITPRICE,
 Sum(unitprice) over(partition by supplierid order by unitprice) as sum
 from products
  )t
  where unitsinstock > 10


