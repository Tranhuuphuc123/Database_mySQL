---*********************TRUY VẤN NÂNG CAO VỚI JOINS*********************
use northwind
go

-->>>>>>>>>>> tìm hiểu về INNER JOIN<<<<<<<<<<<<<<<<<<

--**** bài toán: lấy các thông tin masp, tensp, maloai, tenloai don giá từ 2 bảng product và category
select * from Products
select * from Categories
--> vấn đề gặp phải là tên loại nằm ở bàng category còn các tt còn lại thì ở bảng product..
---> hg giải quyết là dùng joins
select ProductID,ProductName,Products.CategoryID, CategoryName, UnitPrice from Products join Categories
on Products.CategoryID = Categories.CategoryID


-- có thể đạt tên cho gọn code như sau
select ProductID,ProductName,p.CategoryID, CategoryName, UnitPrice from Products p join Categories c
on p.CategoryID = c.CategoryID




--****bài toán: đặt ra là lấy những sp từ 2 bảng product và category có tên 'Beverages' và mã là 1
select * from Categories
select * from Products where CategoryID =1
---> lúc này vấn đề đặt ra là nếu ở bảng Categories đổi tên tất cả ở côt CategroryName vậy thì 
--'Beverages' có thể sẽ không còn nằm ở mã 1 thì sao
---> giải quyết bằng cách dùng câu lệnh sub_query: câu lệnh con
select * 
from Products where CategoryID =(
 select CategoryID from Categories where CategoryName='Beverages'
)

--> hạn chế nữa là mún xem thêm tt về tenloai lun thi sub_query khong truy van tới đc do không lk đc
--==> giải quyết dùng lk join

select p.*, CategoryName
from Products p join Categories c on p.CategoryID = c.CategoryID
where CategoryName = 'Beverages'
--===> ưu tiên dùng join vì tính linh hoạt nhanh nhẹn và đúng tc lk 2 bảng




-->>>>>>>>>> Tìm hiểu về OUTER JOIN<<<<<<<<<<<<<<<<<<<<<<<<
-->> tạo 2 bảng ví dụ về outer hé
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

insert into sinhvien
values('sv01','Tran van A', 'L1'),
('sv02','Tran van B', 'L1'),
('sv03','Tran van C', 'L4'),
('sv04','Tran van D', 'L11'),
('sv05','Tran van E', 'L4'),
('sv06','Tran van F', 'L2'),
('sv07','Tran van G', 'L9'),
('sv08','Tran van H', 'L10')


--> dùng outer join và inner join nè
-->**** kiểm tra inner join trc
select * from lophoc
select * from sinhvien

select l.*, Masv, Hoten 
from lophoc l join sinhvien s on l.Malop = s.Malop 
--===> vớ inner join chỉ L1, L2, L4 có ở 2 bảng mới đc match thông qua inner join và hiển thị còn
-- những cái không là phần là pt chung ở 2 bên sẽ không đc hiển thị

--->****Kiểm tra outer join, vidu theo trục left
select * from lophoc
select * from sinhvien

select l.*, Masv, Hoten 
from lophoc l left outer join sinhvien s on l.Malop = s.Malop 
--===>>> với left outer join thì nó xem trục bên trái tức bảng lophoc làm khóa xét đk chính
--tất cả mã bên lop học có và bên sinh vien có sẽ đc hiển thị còn chỉ có bên lop học mà bên sinhvien
--không vó sẽ hiển thị null
---> với right outer join cũng tg tự khác chỗ nó sẽ lấy đk bên sinhvien để xét qua bên lop học mà thui.




-->>>>>>> join nhiều hơn 2 bảng dữ liệu<<<<
select * from Products
select  * from Categories
select * from Suppliers
--> bài tập join 3 bảng trên hiển thị ProductID, ProductName,CategoryID,CategoryName,SupplierID, ContactName
select ProductID,ProductName, p.CategoryID, p.SupplierID, ContactName
from Products p join Categories c on p.CategoryID = c.CategoryID
                join Suppliers s on p.SupplierID = s.SupplierID




--->> bài tập: hiển hị tất cả tt của hoa đơn mà ở uk
--OrderID, CustomerID,CompanyName, country,OrderDate

select * from Orders
select * from Customers

select OrderID, o.CustomerID, CompanyName, Country, OrderDate
from Orders o join Customers c on o.CustomerID = c.CustomerID
where Country = 'uk'
