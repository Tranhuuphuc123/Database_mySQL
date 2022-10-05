
use northwind
go

-- tìm hiểu veev view
-- bài tạp đặt ra tạo view, th insert, update view đển dữ iệu insert, upate ánh xạ lên table chính
create view New_table
as
 select * from  Customers
 --> thực thi ktra
 select * from New_table

 --> tiến hành thực thi 1 lệnh minh họa update
 update New_table 
 set City='Vietnam'
 where CustomerID='ALFKI'

 --> tiến hành ktra ở view
 select * from New_table --đã thay đổi ok
 --> tiến hành kiểm tra ở tbale chính xem sau?
  select * from Customers --cũng ok đã đc update ở bản chính


--## tạo view cho nhiều bảng table
select * from Customers
select * from Orders
 
 create view New_tables
 as
  select O.CustomerID, CompanyName,EmployeeID, OrderDate
   from Customers C join Orders O on O.CustomerID=C.CustomerID
   --> thành công tiến hành ktra bảng view lk nhiều tbal(áp dụng 3 4 5 bảng đều đc)

select * from New_tables
--====> như vậy khi tạo thành cong thì ta có thể tiến hành insert, update, delete trên bảng view một cách bt
--==> những thay đổi đó sẽ đc ánh xạ cập nhật trên bảng chính cùng lúc.
--+===> lưu ý cách tạo view sau as sẽ lệnh truy vấn như bt, khi có bảng view thì tiến hành thực thi trên
-- view và các dữ liệu lk sẽ đc ánh xạ cập nhật trên bảng chính rất tiện lợi

--***NOTE: lưu ý View có những ràng buộc sau:
 --+ không chứa truy vấn với TOP
 --+ view không có Into
 --+ Không đc trung tên với table dễ gây truy vấn nhầm
 --+ không có giá trị DEFAULT
 --+ không chứa quá 1024 column
 --+ Lưu ý khi Insert với view không insert: thuộc tính tự tăng identity, các dữ liệu tính toán, số học.
 --+ Update trên view: Indentity, null... 


 -------------------------------------------------------------------------------




 --sữa View: vd bảng view vừa create muuns thêm một colum hay bớt đi để thực thi laaij ta dùng alter
 select * from New_tables
 --> ta mún bỏ đi(hay thêm vào cũng tg tự) cột oderdate trên bảng view
 alter view New_tables
 as
    select O.CustomerID, CompanyName,EmployeeID
   from Customers C join Orders O on O.CustomerID=C.CustomerID
   
--> bỏ bớt Odderdate, thực thi thành công-> tiến hành ktra lại kq
select * from New_tables--> lúc này đã ất column Orderdate


----------------------------------------------------------------------------------
--câu lệnh xáo view
drop view New_tables



-- xem định nghĩa của view
sp_helptext [New_tables]

---> với câu lệnh này ta xem đc cú pháp tao view cũng như định nghĩa và trg truy vấn mà ta đã làm lúc ban đầu.


------------------------------------------------------------------------------------------
--check option trên view:


