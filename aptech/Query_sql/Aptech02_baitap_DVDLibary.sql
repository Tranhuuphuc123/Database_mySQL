-- aptech 02 luyện tập về TABLE VÀ GIÁ TRỊ VALUE
-- bài tập trên lớp

 create database DVDLibary on(
  name = DVDLibary,
  filename='D:\A21204_phuc_24082022\DVDLibary.mdf',
  size=100mb,
  maxsize=unlimited,
  filegrowth=100mb
)
log on(
	name = DVDLibary_log,
	filename ='D:\A21204_phuc_24082022\DVDLibarr_log.ldf',
	 size=100mb,
  maxsize=unlimited,
  filegrowth=100mb
)
go

use DVDLibary
go

--tao bang employees
create table employees(
	employeeID char(30) primary key,
	employeename nvarchar(50) not null default 'user',
	password char(10) not null default 'user'
)
go

-- toa bang customer
create table customer (
   CustomerID int identity(10,1) primary key,
   Custometname varchar(50) not null default 'no name',
   Adress varchar(50) null,
   Discount int not null default 0
)
go

select * from customer



-- tao bang order

create table Oder(
	OrderID int identity(10,1) primary key,
	CustomerID int null,
	CustomerAdd nvarchar(50) null,
	employeeID char(30) not null
)
go

alter table dbo.Oder add foreign key(CustomerID) references dbo.customer(CustomerID)
alter table dbo.Oder add foreign key(employeeID) references dbo.employees(employeeID)


-- tao bang DVDLibary
create table DVDLibary(
	DVDcodeNo numeric(9) primary key,
	DVDtitle char(40) not null,
	Language char(40) null default 'N/A',
	Subtitle bit null,
	Price money not null default 1500
)
go

-- tao bang Oderdetails

create table Oderdetails(
	OrderID int identity(10,1) primary key,
	DVDcodeNo numeric(9) not null,
	Quanlity int not null,
	Date money null
	)
	go

	alter table dbo.Oderdetails add foreign key(Orderid) references dbo.Oder(OrderID)
	alter table dbo.Oderdetails add foreign key(DVDcodeNo) references dbo.DVDLibary(DVDcodeNo)



-- them cot  age vao bang sustomer


alter table customer add Age money not null
select * from customer


-- doi ten cot du lieu da co age trong customer thanh int

alter table dbo.customer alter column Age int 


--xoa cot date cua order details

alter table dbo.Oderdetails drop column date


--them rang buoc age cua du lieu Age cua bang customer
alter table customer add check (Age>=18)

--- nhap du lieu
  --dvdLibary

  insert dbo.DVDLibary(
  DVDcodeNo,
    DVDtitle,
	Language,
	Subtitle,
	Price
  )
  values(
    1,
	'Thecode of davinci',
	'English',
	1,
	15000
  )


  insert into DVDLibary
  values
  (
    2,
	'Vinci',
	'French',
	0,
	25000
  ),
  (
    3,
	'Vinci',
	'French',
	1,
	25000
  ),
  (
    4,
	'Vinci',
	'French',
	1,
	25000
  ),
  (
    5,
	'Vinci',
	'French',
	1,
	25000
  )


  -- tao du lieu cho bang customer

  insert into dbo.customer(
	Custometname,
	Adress,
	Discount,
	Age
  )
  values
  (
	'Cusc',
	'ly tu trong can tho',
	5,
	19
  ),
 (
	'Cantho',
	'phan van tri can tho',
	6,
	23
  )
  go

  

  select * from dbo.customer




