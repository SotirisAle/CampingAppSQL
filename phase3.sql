insert into Customer
  select distinct custCode,custName,custSurname,custPhone
    from campData;

insert into Staff
  select distinct staffNo, staffName, staffSurname
    from campData;

insert into Payment
  select distinct payCode,payMethod
    from campData;

insert into Camping
  select distinct campCode,campName,numOfEmp
    from campData;

insert into Category
  select distinct catCode,areaM2,unitCost
    from campData;

insert into Emplacement
  select distinct campCode,empNo,catCode
    from campData;

insert into Booking
  select distinct bookCode,bookDt,payCode,custCode,staffNo
    from campData;

insert into Rental
  select distinct bookCode,campCode,empNo,startDt,endDt,noPers
    from campData;
