--=================================================================================================================
--**************************CREATE DATABASE**************************
-- create database- lưu theo mã code
create database Lib_Manager
on(
   name =Lib_Manager,
   filename='G:\PRATICE_CODE\Database_mySQL\thuc_hanh\MDF_Ontap\MDF_LibManager\Lib_Manager.mdf',
   size =20,
   maxsize = 40,
   filegrowth = 5
)log on(
 name = Lib_Manager_log,
 filename = 'G:\PRATICE_CODE\Database_mySQL\thuc_hanh\MDF_Ontap\MDF_LibManager\Lib_Manager_log.ldf',
 size =20,
 maxsize = 40,
 filegrowth = 5
)

-- use database
use Lib_Manager
go








-- ================================================================================================
-- ************NỘI DUNG CƠ BẢN: TẠO, THÊM, CHÈN, XÓA SỮA...******************************
-- create table
create table nhanvien(
   id varchar(10) not null primary key,
   name varchar(20) not null,
   address varchar(50) not null,
   phone int not null
)
go

-- insert them dl
insert into nhanvien
values('MA01', 'Tran Huu Phuc','Can tho',0962428167),
      ('MA02','Ngoc Phuong','Can Tho',0939052119)
	  go

-- doi ten bang nhanvien thanh Employee dùng tương tự khi đổi tên database
sp_rename employee, Employee
go

-- truy vấn
select * from Employee
go

-- đổi tên cột trong ms sql: đổi tên cột name thành Name trong bảng Employee
sp_rename 'Employee.name', 'Name', 'column'
go

-- đổi kiểu dữ liệu trong MS SQL: dùng alter table alter column
alter table Employee alter column phone nvarchar(10) not null
go

-- drop table
drop table Employee
go

-- xóa database 
drop database Lib_Manager
go

-- xóa cột trong table
alter table Employee drop column phone
go

select * from Employee

-- thêm cột 
alter table Employee add Phone int 

-- Update dữ liệu(update lại hai trường vừa xóa đi)
update Employee set Phone = 0993562477 where id ='MA02'


-- delete dữ liêu( vói drop là xóa hết table, database với delete chỉ xóa dữ liệu)
delete Employee
go

-- insert lại dữ liệu
insert into Employee
values('MA01','Trần Hữu Phúc','Cần thơ',0962428167),
      ('MA02','Ngọc Phương', 'Cà mau',0939052119)

select * from Employee

--Khóa chính Primary key ok!
-- khoa ngoai
-- Syntax:   alter table Employee add constraint key01 foreign key(?) references table2(?) -> ? ma lien ket
-- luu ý: de tao khoa ngoai thi khoa ngoại đó phải liên kết với khóa chính, cùng kiểu dl với khóa chính, cùng sl sắp xếp.








-- ====================================================================================================
-- ***************************  TRUY VẤN MS SQL ************************************

-- truy van tong quát
use northwind
go


select * from Employees


-- hiển thị trường muốn truy vấn hiển thị cụ thể trong một table 
select EmployeeID, FirstName,Address from Employees


-- trong table Employees có  2 cột lastName và FirstName-> hiển thị 2 cột và kết hợp lại làm 1 thì dùng dấu +,
-- ==>có thể đặt tên hiên thị riêng(lưu ý tên hiển thị chỉ là tển ảo)
select LastName + ' ' + Firstname AS 'FullName' from Employees


-- thuc hien phep tinh trong select: vd trong Oder Details có sl và dơn giá ta có the lay sl*dg -> display ra
select * from [Order Details]

select Quantity * UnitPrice AS 'thanh tien' from [Order Details]

-- Hiển hị số dòng muốn hiển thị
select top 10* from Customers

-- hiển thị theo phần trăm nghĩa là thay vì hiện số dòng-> ta tính tỉ lệ hiển thị theo % trên tổng dố row hiện có của table
select * from Employees
select top 10 percent * from Employees

-- Sắp xếp tăng/giảm theo Order By/desc
select * from [Order Details]

-- sắp xếp tăng
select * from [Order Details] order by UnitPrice
-- sắp xếp giảm
select * from [Order Details] order by Unitprice desc


-- truy vấn với điều kiện: dùng where : sau đk có thể dùng toán tử, Between, in(~...)...
-- ví dụ tiềm kiếm giá từ table Order Details với giá từ 10 tới 50
select * from [Order Details] where UnitPrice  = 81

select * from [Order Details] where UnitPrice between 10 and 50 order by UnitPrice

select * from Employees where City in ('Seattle','London')


-- truy vấn truy xuất nội dung cần hiển thị theo điều kiện là ký tự mong muốn
-- lấy tên nhân viên có chưa 'Seattle'
select * from Employees where City = 'Seattle'
-- lấy ký tự có ký tự S or Se với like %
select * from Employees where City like '%S%' -- S% là trc ký tự có chữ S là đc, %S% là miễn sao có chữ S là chấp nhận hết

-- tiềm ký tự chỉ định
select * from Employees where FirstName like 'N [an] [AN]'

-- đếm table có nhiêu dòng
--.>>> với select * from table có thể liệt kê hết nhưng hông rõ có nhiêu dong
select count(*) from [Order Details] --> giúp ta có thể biết đc tổng số dòng nhanh hơn


-- truy vấn tính dc tổng: vd bảng Oder Details muốn biết 2155 dòng Unit Price có giá tổng nhiêu thay vì mắc công cộng từ dòng
--> sử dụng hàm sum
select sum(UnitPrice) as 'tổng tiền' from [Order Details]


-- tiềm giá trị max min
-- tiềm giá cao nhất trong table Order Details
select MAX(UnitPrice) from [Order Details]

-- hienr thị giá tháp nhất trong Order Details
select MIN(UnitPrice) from [Order Details]


-- lấy giá trị trung bình giá của 2155 dòng UnitPrice trong Order Detils
select * from [Order Details]
select AVG(UnitPrice) from [Order Details]








--===========================================================================================
-->>>>>>>>>>>>>>>>> TRUY VẤN VỚI SELECT GROUP BY<<<<<<<<<<<<<<<<<<

-- đếm xem có bao nhiêu mã ID trong cột SuplierID của bảng Products
select * from Products
select SupplierID, count(*) from Products group by SupplierID --= tức là nó nhóm các mã ID giống nhau thành 1

-- đếm và nhóm các id của cột customerID trong bảng Orders, hỉu nôm na là xem các mã ID trùng trông cột customerID  gộp thành một
-- nhóm và tiến hành đếm ra, đếm xem mỗi mã ID trùng nhau dã đc gộp với groupby đã xuất hiện bao nhiêu lần
select * from Orders
select CustomerID, count(*) from Orders group by CustomerID


-- gộp groupby cột product ID để gộp các mã sản pẩm giống nhau thành một, và dùng sum để tính xem mỗi loại mã sp tổng doanh thu đc nhiêu
select * from [Order Details]
select ProductID,count(*), sum(UnitPrice) from [Order Details] group by ProductID

-- nhóm OrderID lại để biết user đặt được bao nhiêu đơn hàng mỗi loại và tính tổng = đơn giá * sl đặt tên cột gợi nhớ là 'tổng'
select OrderID, count(*), sum(UnitPrice*Quantity) as 'Tổng' from [Order Details] group by OrderID

-- câu lệnh điều kiện truy vấn having với groupby (dùng group by thì không dùng where đc)
-- muốn hiển thị những đơn hàng OrderID có unitPrice >100 ngàn
select * from [Order Details]
select OrderID, count (*), sum(UnitPrice) from [Order Details] group by OrderID having sum(UnitPrice) > 200
-- hiển thị các nhóm OrderID có sl xuất hiện trên 10
select OrderID, count(*) from [Order Details] group by OrderID having count(*) >= 10



/************************************************************************/
-- Phần CUBE, ROILLUP và SUB_QUERY:?
-- Rollup và cube được dùng để tự tính tổng với group by--> điểm lợi là khi liên kết join nhiều bảng việc chỉ
-- >dùng sum sẽ bị hàn chế, nên rollUp và cube giúp có thể đơn giản hóa việc thực thi đó.


-- với cube: mún xem tổng số kh mà nhân vieen bán đc:
select * from Orders

-- với cube sẽ làm đc những cái sao: qua bài toán trong đơn đặt hàng orders quản lý muốn biết nv mình đã bán đc cho bao nhiêu 
--khách hàng và tống số sản phẩm bán đc cho từng ấy kh là bao nhiêu: khi dùng cube như câu lệnh dưới ta sẽ biết đc nv số 1 
--bán đc cho 65 kh và có tổng 123 sản phẩm đc bán ra(vì đôi khi 1 kh có thể mua hơn 1 sp)...tg tự cho các nv kế tiếp.
-- với cube khi kéo tới cúi tble truy ván ta còn biết đc mã kh đó đã mua đc bao nhiêu sp(tuy nhiên lại không thống kê được 
-- là những sản phẩm ấy đc bán bởi nv nào--> để giải quyết ta dùng rollup ở câu lệnh sau sẽ rõ).
--> tóm lại cube giúp ta nhsom nhiều đối tượng hơn giúp chi tiết truy vấn xem đc nhiều thông tin hơn như vd ở trên
select CustomerID, EmployeeID, count(*) as "sum" from Orders group by CustomerID, EmployeeID with cube



-- với rollup như đã nói nó đi chi tiết hơn.. chứ không tổng quát như cube vd cube đã trình bài ở trên có điểm yếu là biết được
-- mỗi nv đã bán đc bao sp cho bao kh và biết đc mỗi kh đã mua đc nhiêu sp nhưng lại không thống kê đc mỗi kh đó đc bán bởi ai
-- thì câu lệnh rollup phía dưới giúp cho ta truy vấn thông tin chi tiết đc mỗi kh đã mua đc sl spham la bnhieu và đc bán bởi ai
---> Như vậy rollup đi chi tiết 
---> lưu ý rollup nó sẽ căn cứ đk xét vào nhóm , thống kê theo đối tượng cần group by đầu tiên xuất hiện trong câu lệnh
-- ví du: trong câu lệnh dưới mún biết chi tiết mỗi kh đã mua nhiêu sp và bởi nv nào thì ta cần đưa mã kh CustomerID xuất hiện trc

select CustomerID, EmployeeID, count(*) as "sum" from Orders group by CustomerID, EmployeeID with rollup



===================================================================================================================
--------------------------------------------------------------------------------------
-->>>>>>>>>>>>>>>>>>>>>TRUY VẤN SUB_QUERY<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
-- sub_query đơn giản là lệnh truy vấn trong một lệnh truy vấn.. câu lệnh lồng nhau
-- vd: muốn xem tất cả thông tin của bản OrderDetails
select * from [Order Details] 
-- tiếp tục yêu cầu muốn xem giá lớn nhất của cột Unitprice
select max(UnitPrice) from [Order Details]
-- điểm yếu của max chỉ thấy đc môi giá lớn nhất giờ mún xem giá lớn nhất và các tt liên quan của cột giá lớn nhất
select top 1* from [Order Details] order by UnitPrice Desc

--++> để làm đc các yêu cầu này khá lòng vòng và mất công nào phải sắp xếp rồi hiện ra khá lu bu--> nếu kết hợp đk của nhiều
-- câu lệnh select thì sao
select * from [Order Details] where UnitPrice = (select max(UnitPrice) from [Order Details])
--> bảng thấy đó thông qua câu lệnh sub_query kết hợp này ta thấy đc tất cả thông tin của những giá cao nhất vì rõ ràng trong bảng 
-- Orders Details nay có tới 16 sp cs giá cao nhất là 263.50.. với lệnh oder by desk sắp xếp giảm dần hay max thì ta thấy đc có mỗi
-- một giá trị cao nhất thui.. với viêc kết hợp nhiều câu lệnh lồng nhau ta có thể truy vấn chi tiết và cung cấp thông tin bao quát
-- hơn.






--=======================================================================================================================
--******************************SELECT JOIN- TRUY VẤN JOIN**************************************
-- Join on có 3 loại:
--1/ Inner join: join các thuộc tính chung của 2 bên
--2/ left join: a và b join thì xem a là gốc, cái a và b có thì match, còn cái a có b không thì null
--3/ right join: a va b join xem b là gốc, tg tự a và b co thì match, còn b có mà a không thì null
--> thực hành:
  
  -- bài toán 1: lấy thông tin masp, maloai,tenloai, đơn giá từ 2 bảng product và categories
  select * from Products
  select * from Categories

  --join on:
  select ProductID,p.CategoryID,CategoryName,UnitPrice from Products p join Categories c on p.CategoryID =  c.CategoryID


  -- bài toán2: lấy tt sản phẩm từ 2 bảng Categories và products có tên loại là 'Beverages' và mã là 1
  --> có thể dùng sub-query:
  select * from Products where CategoryID =(select CategoryID from Categories where CategoryName = 'Beverages')
  -----> hạn chế của sub-query là truy vấn đúng yêu cầu nhưng rõ ràng tt hiển thị chỉ là bên bảng product
  ----> muốn xem CategoryName thì không hiển thị đc
  ---> dùng join để đạt yêu cầu là hiển thị tt tất cả từ product kèm theo tt categoryName owqr bảng Categories với 
  -- đk ban đầu đặt ra.
  select *,CategoryName from Products p join Categories c on p.CategoryID = c.CategoryID
  where CategoryName ='Beverages' -- kết hộp đk bình thường với where


  --------------------tính chất Outer Join && inner join---------------
  use Lib_Manager
  go

 create table lophoc(
 Malop varchar(10) primary key,
 Tenlop nvarchar(20) not null
)

create table sinhvien(
 Masv varchar(10) primary key,
 Hoten nvarchar(30) not null,
 Malop varchar(10)
)

insert into lophoc
values('L1', 'Lop1'),
('L2', 'Lop2'),
('L3', 'Lop3'),
('L4', 'Lop4'),
('L5', 'Lop5'),
('L6', 'Lop6')

ihttps://laptrinhjavaweb.com/khoa-hoc-java-web-co-ban-jsp-servlet-jdbc-va-mysqlnsert into sinhvien
values('sv01','Tran van A', 'L1'),
('sv02','Tran van B', 'L1'),
('sv03','Tran van C', 'L4'),
('sv04','Tran van D', 'L11'),
('sv05','Tran van E', 'L4'),
('sv06','Tran van F', 'L2'),
('sv07','Tran van G', 'L9'),
('sv08','Tran van H', 'L10')

--> đặt giả sử tạo 2 table với các trường tt chung và riêng
-- inner join:
select *, Masv,Hoten from lophoc l join sinhvien s on l.Malop = s.Malop
---> rõ ràng ta thấy chỉ những tt chung có ở 2 table dựa trên đk malop là L1,L2,L4 mới xuất
-- còn lại thì ẩn đi không match đc--> đó là Join on


 -- outer join:
 select l.*, Masv, Hoten 
from lophoc l left outer join sinhvien s on l.Malop = s.Malop 
--> với outer join: left outer join nó xem table lophoc là gốc so sánh
--> vậy những đk malop L1-> L6 thì tbale Sinhvien có trùng thì match và hiển thị còn không match
--match tức là tbale gốc lophoc co mà sinhvien khong có thì nó hiển thị null

--> tương tự với right outer join: lấy bản sinhvien lam gốc để so sánh match hiên thị

-->> liến kết join nhiều table

use northwind
go

shttps://laptrinhjavaweb.com/khoa-hoc-java-web-co-ban-jsp-servlet-jdbc-va-mysqlelect * from Products
shttps://laptrinhjavaweb.com/khoa-hoc-java-web-co-ban-jsp-servlet-jdbc-va-mysqlelect * from Categories
select * from Suppliers

-- hiên thị các trường mong muốn từ 3 table trên
select ProductID, p.CategoryID, p.SupplierID, ProductName,CategoryName,CompanyName
from Products p join Categories c on p.CategoryID = c.CategoryID
                join Suppliers s on p.SupplierID = s.SupplierID


