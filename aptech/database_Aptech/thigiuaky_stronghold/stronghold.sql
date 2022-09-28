
--cau 1 create database
create database StrongHold
on(
  name = StrongHold,
  filename='G:\PRATICE_CODE\Database_mySQL\aptech\database_Aptech\thigiuaky_stronghold\StrongHold.mdf',
  size = 5,
  maxsize =100,
  filegrowth = 2
)
log on(
	name = StrongHold_log,
	filename='G:\PRATICE_CODE\Database_mySQL\aptech\database_Aptech\thigiuaky_stronghold\StrongHold_log.ldf',
	size = 3,
	maxsize=50,
	filegrowth=5
)

use StrongHold
go

--02/ create type

create type Ordertype from char(10) not null
 




--03/Create tables

create table Customer(
	Ccode char(3) primary key,
	CName  char(50) not null,
	Caddress varchar(100) not null default'notfound',
	Cphone char(15) default'###'
)


create table OrderMaster(
	OrderNo Ordertype primary key,
	OrderDate datetime not null default '2022-01-01',
	Ccode char(3) not null
)
alter table OrderMaster add constraint key_01 foreign key(Ccode) references Customer(Ccode)

create table Orderdetails(
	SrNo bigint identity(1,1) primary key,
	Orderno Ordertype not null,
	Icode char(15) not null,
	Qty int not null default 10 check(Qty>=10)
)
alter table Orderdetails add constraint key_02 foreign key(Orderno) references OrderMaster(Orderno)
alter table Orderdetails add constraint key_03 foreign key(Icode) references Item(Icode)



create table Item(
 Icode char(15) Primary key,
 IName char(50) not null,
 Rate numeric(10,2) not null default 0 check(Rate>0)
)


--4. Tạo ràng nuộc kiểm tra cho trường ICode của bảng Item để đảm bảo rằng dữ liệu
--nhập vào trường phải bắt đầu bằng chữ ‘R’ hoặc ‘S’

alter table Item add check(Icode like 'R%' or Icode like 'S%')

--05/Inset data to tables:
select * from Customer
insert into Customer
values('GHL', 'Great Holidays Ltd.','1, Lydias Avenue, Durham-41', '115-72-43'),
( 'TLT', 'Travelite Ltd.', '22, Rodeo Drive, Manhattan-11',' '),
('ULS','United Luggage Services','14, Park Avenue, NY-27','123-56-34' )


select * from OrderMaster
insert into OrderMaster
values('0704/99','1999-10-15','ULS'),
      ('0256/99','1999-10-06','ULS'),
	  ('0856/99','1999-10-09','TLT'),
	  ('0703/99','1999-10-15','TLT'),
	  ('0083/98','1999-12-30','TLT')



select * from Item
insert into Item
values('RKSK-B','R ucksacks-Brown', 450),
      ('RKSK-T', 'Rucksacks-Tan', 500),
	  ('STCS-24-S-DB', 'Suitcase 24, Soft, Dark Brown', 1575),
	  ('STCS-28-S-B', 'Suitcase 28, Soft, Blue', 1790)

select *from Orderdetails
insert into Orderdetails
values('0083/98','RKSK-T', 100),
   ('0083/98', 'STCS-24-S-DB', 100),
    ('0256/99', 'STCS-24-S-DB', 50),
	('0703/99',' RKSK-T', 70),
	('0703/99', 'STCS-24-S-DB', 30),
	('0704/99', 'RKSK-T', 20),
	('0856/99','RKSK-T', 120)


--06/Sử dụng các câu truy vấn SQL:
--a. Hiển thị ICode, IName và Discounted Rates (giá đã được giảm) cho các
--sản phẩm. Giả sử giảm 20% trên từng sản phẩm. Tiêu đề cua các cột
--chuyển thành Columns as Item Code, Item Name và Discounted rate.
	
	select * from Item

	select Icode as itemCode, IName as ItemName,  Rate*0.25 as DiscountRate
	from Item


--b. Hiển thị tên các sản phẩm bắt đầu bằng chữ ‘S’
select * from Item
select * from Item where IName like 'S%'

--c. Hiển thị tổng lượng bán của sản phẩm có mã ‘RKSK-T’
select * from Orderdetails
select Icode, sum(Qty)
from Orderdetails 
where Icode ='RKSK-T'
group by Icode 

--d. Hiển thị số lượng hóa đơn do khách hàng có mã ‘TLT’ đặt.
select * from OrderMaster
select * from Orderdetails

select Ccode, O.Orderno, Qty
from OrderMaster O join Orderdetails r on O.OrderNo = r.Orderno 
where Ccode ='TLT'


--e. Hiển thị các khách hàng thuộc công ty trách nhiệm hữu hạn (tên công ty có
--chữ ‘Ltd.’)
select * from Customer
select * from Customer where CName like '%Ltd.%'

--f. Hiển thị 2 sản phẩm có giá cao nhất
select * from Item
select top 2 * from Item order by rate desc

--g. Cập nhật Giá của sản phẩm Rucksacks-Brown thành 400
select * from Item
update Item
set rate = 400.00
where IName = 'R ucksacks-Brown'

--h. Xóa mẫu tin từ bảng Item với Item code=’RKSK-B’
select * from Item
delete from Item where Icode = 'RKSK-B'

--i. Hiển thị OrderNo, OrderDate, ItemCode, ItemName, Qty và Rate của các
--đơn hàng

select * from OrderMaster
select * from Item
select * from Orderdetails

select O.Orderno, OrderDate, I.Icode, IName, Rate, Qty
from OrderMaster O join Orderdetails r on O.OrderNo = r.Orderno
                    join Item I on r.Icode = I.Icode

--j. Tạo truy vấn hiển thị the item code, item name và rate cho các sản phẩm có
--giá lớn hơn sản phẩm Rucksacks-Tan

select * from Item
select * from Item where rate >500.00

--k. Tạo truy vấn hiển thị Customer name, Item name và the total amount (tổng
--số tiền phải trả = Qty* rate) cho mỗi mặt hàng.

select * from Customer
select * from OrderMaster
select * from Item
select * from Orderdetails


select CName, IName, Qty*Rate as total_amount
from Customer C join OrderMaster O on C.Ccode = O.Ccode
                join Orderdetails R on O.OrderNo = R.Orderno
				join Item I on R.Icode = I.Icode





--Câu 7. Use SQL statements to:
--a. Create a non-clustered index on columns CName of the Customer
--table. Ensure that the intermediate and leaf levels of the index pages
--are 25% empty

create nonclustered index CName
		on Customer(CName) 
		
		alter index CName
		on Customer
		rebuild with (fillfactor = 75, pad_index = on)



--b. Create view named Order_info that contains the Customer code,
--Customer Name, Phone no, Order date, Item Code, Quantity for all
--the orders.

select * from Customer
select * from Orderdetails
select * from OrderMaster

create view Order_info 
as
 select CName,Item, O.Ccode,Cphone, OrderDate,Icode,Qty
 from Customer C join OrderMaster O on C.Ccode = O.Ccode
               join Orderdetails R on O.OrderNo = R.Orderno

select * from Order_info

--> cách 02
  CREATE VIEW Order_info2 
	AS 
		SELECT CName, Cphone, OrderDate, Icode, Qty FROM Customer, OrderMaster, OrderDetails
		

select * from Order_info2


--c. Write a stored procedure named Process_counter that displays the
--square values of numbers starting from 5, in descending order. When
--the number reaches a value 2, an error should be raised, and no more
--square values should be displayed.





--d. Write a stored procedure named Dis_amount that accepts Customer
--code, Order No as parameters and display item code, item name,
--amount of money customer have to pay for each item.
select * from Customer
select * from OrderMaster
select * from Orderdetails
select * from Item
--parameter
 create proc Dis_amount 
    @Ccode char(3),
	@Orderno Ordertype
 as
 select r.Icode, IName, C.Ccode, r.OrderNo, Rate*Qty AS 'Amount' 
 from Customer C join OrderMaster O on C.Ccode=O.Ccode
                  join Orderdetails r on O.OrderNo=r.Orderno
				  join Item I on r.Icode= I.Icode
where C.Ccode = @Ccode and r.OrderNo = @Orderno

exec Dis_amount 'TLT', '0083/98'


--e. Create an INSERT trigger on item table to ensure that the prices of
--new products are not greater than 5000.
select * from Item

create trigger Item_new on Item 
for insert 
as
 if (select Rate from inserted) >5000
 begin 
   print 'new products are not greater than 5000'
   rollback transaction;
 end

 else
   begin
      insert into Item select * from inserted
	end

 ---> tiến hành kiểm tra
   insert into Item
   values('RKSK','ABC',6000)


 


 --f. Create an UPDATE trigger named CheckingUpdate on OrderDetails
--table that ensure that the existing quantity in the OrderDetails table is
--not modified to value less than 0.

create trigger CheckingUpdate
on OrderDetails 
for UPDATE
as 
if (select count(*) from inserted i, Item it 
				where i.Qty > 0 and i.Icode=it.ICode )>0
	begin 
		UPDATE OrderDetails
		set Qty = (select Qty from inserted i, Item it where i.Icode=it.ICode)
				--WHERE Icode IN (SELECT Icode FROM inserted)
		end
	else 
		
	  begin 
			Print 'OrderDetails table is not modified to value less than 0'
			rollback transaction
	 end

	 ---> tiến hành kiểm tra


		UPDATE OrderDetails
		set Qty = 0
		where Icode = 'STCS-24-S-DB'

--g. Create DELETE trigger to ensure that when delete records in
--OrderMaster tables, the records in related table are also deleted.

create trigger DeleteOrdermaster on OrderMaster
for delete
as
if(select count(*) from deleted d, OrderMaster om where d.OrderNo=om.OrderNo) > 0 
			begin 
				delete from OrderDetails where OrderNo = (select OrderNo from deleted)
				delete from OrderMaster where OrderNo = (select OrderNo from deleted)
			end
		else 
			begin 
				print'not valid'
				rollback transaction
			end

---> tiến hành kiểm tra

	delete OrderMaster where OrderNo = '0083/98'

--h. Create DELETE trigger that will not allow more than 2 records to be
--deleted from the OrderMaster table.

create trigger deleteOM 
	on OrderMaster
	for DELETE
	as 
		if (select count(*) from OrderMaster O, deleted D where O.OrderNo=D.OrderNo)>2
			begin
				print 'don`t delete more than 2 records in table'
				Rollback transaction
			end

			---> tiến hành kiểm tra
	delete OrderMaster
	where OrderNo IN ('0083/98', '0256/99', '0703/99')



--i/??
