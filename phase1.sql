CREATE TABLE campData(
  bookCode int NULL,
  bookDt date NULL,
  payCode int NULL,
  payMethod char(2) NULL,
  custCode int NULL,
  custName varchar(30) NULL,
  custSurname varchar (30) NULL,
  custPhone varchar (20) NULL,
  staffNo int NULL,
  staffName varchar (30) NULL,
  staffSurname varchar (30) NULL,
  totalCost numeric(19, 2) NULL,
  campCode char(3) NULL,
  campName varchar (50) NULL,
  numOfEmp int NULL,
  empNo int NULL,
  catCode char (1) NULL,
  areaM2 int NULL,
  unitCost numeric(4,2) NULL,
  startDt date NULL,
  endDt date NULL,
  noPers int NULL,
  costPerRental numeric(19, 2) NULL
);

SET DATEFORMAT dmy;
BULK INSERT campData
  FROM 'C:\data\campData.txt'
WITH (FIRSTROW = 2,FIELDTERMINATOR= ',', ROWTERMINATOR = '\n');
