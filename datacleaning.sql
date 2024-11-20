---clrearing data in sql queries
select * from house
select saledateconverted, convert(date,saledate) from house

update house
set saledate = convert(date,saledate)

alter table house
add saledateconverted date

 update house
set saledateconverted = convert(date,saledate)


---populate property address data
select * from house
--where propertyaddress is null
order by parcelid


select a.parcelid,a.propertyaddress,b.parcelid,b.propertyaddress, isnull(a.propertyaddress,b.propertyaddress)
from house a join house b 
on a.parcelid = b.parcelid
and a.uniqueid <> b.uniqueid
where a.propertyaddress is null
  


 UPDATE a  
 SET propertyaddress = isnull(a.propertyaddress,b.propertyaddress)
 from house a join house b 
on a.parcelid = b.parcelid
and a.[UniqueID ] <> b.[UniqueID ]
where a.propertyaddress is null
-----------------

--breaking out address data individual columns(address,city,state)

select propertyaddress from house

select substring(propertyaddress,1,charindex(',',propertyaddress)-1),
substring(propertyaddress,charindex(',',propertyaddress)+1,len(propertyaddress))
from house  
select * from house

alter table house
add propertysplitaddress nvarchar(100)

 update house
set propertysplitaddress = substring(propertyaddress,1,charindex(',',propertyaddress)-1)

alter table house
add propertysplitcity nvarchar(100)

 update house
set property = splitcity = substring(propertyaddress,charindex(',',propertyaddress)+1,len(propertyaddress))
select owneraddress from house
 select parsename(replace(owneraddress,',','.'),1),
 parsename(replace(owneraddress,',','.'),2),
 parsename(replace(owneraddress,',','.'),3)
 from house


 alter table house
add ownersplitaddress nvarchar(100)

 update house
set ownersplitaddress = parsename(replace(owneraddress,',','.'),1)

alter table house
add ownersplitcity nvarchar(100)

 update house
set ownersplitcity =  parsename(replace(owneraddress,',','.'),2)


alter table house
add ownersplitstate nvarchar(100)

 update house
set ownersplitstate =  parsename(replace(owneraddress,',','.'),3)

select * from house

--change y and n to yes and no in sold in vacant field
select distinct(soldasvacant),count(soldasvacant) from house
group by soldasvacant
order by 2
 
 select soldasvacant,
  case
     when soldasvacant = 'Y' Then 'YES'
     WHEN soldasvacant = 'N' then 'No'
     else soldasvacant
 end
 from house

 update house
 set soldasvacant =  case
     when soldasvacant = 'Y' Then 'YES'
     WHEN soldasvacant = 'N' then 'No'
     else soldasvacant
 end
 select soldasvacant from house


 -----remove duplicates
 with rownumcte as (
 select *,
 row_number() over(partition by parcelid,
 propertyaddress,saleprice,saledate,legalreference
 order by uniqueid) rownum
 from house
 )
delete from rownumcte
where rownum > 1
 
 -----------------------
 ---delete unused columns

 alter table house
 drop column saledate