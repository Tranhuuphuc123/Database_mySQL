--*****************TÌM HIỂU VỀ STORED PRECEDURED**************************
--kiến thức tổng quát về câu lệnh của store procedured

--chức năng cũng như view merrge combiting sau câu lệnh create Procedured as
---> là các chức năng select, insert, update, delete nghĩa là sau khi create proc. thì sẽ thực thi
--câu lệnh truy vấn thông thường
use northwind
go

--lệnh select truy vấn hiển thị

select * from Customers
create Proc getcustomer
as
select CustomerID, CompanyName, ContactTitle, City, Country from Customers

--> thực thi truy vấn với prcedured

exec getcustomer


--add insert vói proc
create proc AddCustomer
as
 insert into Customers(CustomerID,CompanyName, Country) values('ALHH','ABC','Vietnam')

 exec AddCustomer
 select * from Customers


 --update với procedured
 select * from Customers

 create proc updateCus
 as
  update Customers
  set CustomerID='ALPP',
      CompanyName='AAA',
	  Country='Thailand'
where CustomerID= 'ALHH'

exec updateCus


--delete với procedured
create proc deleteCus
as
  delete Customers
  where CustomerID='ALPP'

  exec deleteCus

  select * from Customers


--tham số đầu vào với input parameter
--> parameter đc định nghĩa ngay sau khi tạo create proc 
select * from Customers

create proc parameter
   @City nvarchar(15)
as
 select * from Customers
 where City=@City

 --> thực thi
 exec parameter 'London'

-- parameter với nhiều giá trị
create proc Parameter2
@City nvarchar(15),
@CustomerID nchar(5)
as
select * from Customers 
where City=@City  and CustomerID= @CustomerID

exec Parameter2  'México D.F.', 'ANTON'
