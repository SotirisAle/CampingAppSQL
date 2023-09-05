Create table customers
  (custCode int primary key,
  custName varchar(30),
  custSurname varchar(30)
);
insert into customers select custCode,custName,custSurname from
CAMPDB.dbo.customer
  
create table campings
  (campCode char(3) primary key,
  campName varchar(30)
);
insert into campings select campCode, campName from CAMPDB.dbo.camping
  
create table calendar
  (startDt date primary key,
  t_year int,
  t_month int,
  t_day int
):
insert into calendar
  select distinct startDt, datepart(year, startDt), datepart(month, startDt),
      datepart(day, startDt)
    from CAMPDB.dbo.Rental
  
create table fact
(bookCode int,
custCode int foreign key references customers(custCode),
campCode char(3) foreign key references campings (campCode),
startDt date foreign key references calendar(startDt),
empNo int,
catcode char(1),
noPers int,
cost numeric (6,2)
primary key (bookCode, custCode, campCode, startDt, empNo)
);

insert into fact
select CAMPDB.dbo.booking.bookcode, CAMPDB.dbo.booking.custCode,
  CAMPDB.dbo.rental.campCode, startDt, CAMPDB.dbo.rental.empNo,
  CAMPDB.dbo.emplacement.catcode, noPers,
  nopers*unitcost*(DATEDIFF(day,startDt,endDt)+1)
from CAMPDB.dbo.rental, CAMPDB.dbo.booking,
  CAMPDB.dbo.Emplacement, CAMPDB.dbo.Category
where CAMPDB.dbo.rental.bookCode=CAMPDB.dbo.booking.bookCode and
  CAMPDB.dbo.rental.campCode=CAMPDB.dbo.emplacement.campCode and
  CAMPDB.dbo.rental.empNo=CAMPDB.dbo.emplacement.empno and
  CAMPDB.dbo.emplacement.catcode=CAMPDB.dbo.Category.catcode

--Q1
  
select top 100 customers.custCode, custName, custSurname, sum(cost)
    from customers, fact
  where customers.custCode=fact.CustCode
      group by customers.custCode, custName, custSurname
      order by sum(cost) desc
  
--Q2
  
select campname, catCode, sum(cost)
    from campings, calendar, fact
  where campings.campCode=fact.campCode and
        calendar.startDt=fact.startDt and t_year = 2000
        group by campname,catCode
        order by campname,catCode
  
--Q3
  
select campname, t_month, sum(cost)
    from campings, calendar, fact
  where campings.campcode=fact.campcode and
        calendar.startDt=fact.startDt and
        t_year = 2018
        group by t_month,campname
  
--Q4
  
select t_year, campName, catCode, sum(noPers)
    from calendar, campings, fact
  where calendar.startDt=fact.startDt and
        campings.campCode = fact.campcode
        group by ROLLUP (t_year, campName, catCode)
  
--Q5
  
select t_year, campName, catCode, sum(cost)
    from calendar, campings, fact
  where calendar.startDt=fact.startDt and
        campings.campCode = fact.campcode
        group by CUBE (t_year, campName, catCode)
