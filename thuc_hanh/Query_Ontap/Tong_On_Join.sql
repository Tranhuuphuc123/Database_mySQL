/*Ôn tập truy vấn Join*/
use northwind
/*Join có 3 loại
 1/ Inner Join
  => Join cho phép bạn lấy dữ liệu từ nhiều bảng và kết hợp chúng thành 
  một tập dữ liệu lớn, chứa thông tin từ tất cả các bảng tham gia thông 
  qua một đk cụ thể mà các bảng đều có
  => Inner Join là join các thuộc tính chung của các bên

 2/ Left Join: 
  => a và b join với nhau thì xem a là bảng gốc
  => cái mà bảng a và b đều có thì match, còn a có mà b không thì giá trị null

 3/ Right Join:
  => nc lai với left join xem b là bảng gốc
  => a và b đều có thì match, còn nếu b có mà a không thì giá trị null
*/


--1/ Inner Join
--bài toán: lấy tt: masp, maloai, tenloai, đơn giá tử 2 bảng Products và Categories
select * from Products
select * from Categories

select ProductID, p.CategoryID, CategoryName, ProductName, UnitPrice 
from Products p  join Categories c on p.CategoryID = c.CategoryID


-- bài toán 2: lấy tt sp tử 2 bảng categories và Products có tên là 'Beverages' và mã là 1
select *, CategoryName from Products p join Categories c on p.CategoryID = c.CategoryID
where CategoryName = 'Beverages' and p.CategoryID = 1







/********************************************************************************/
/***********KIẾN THỨC TỔNG QUAN VỀ INNER JOIN VÀ OUTER JOIN*********/
/*
 
*/
-- tạo cơ sở dữ liệu mới
create database ontap
on(
 name = ontap,
 filename='G:\PRATICE_CODE\Database_mySQL_MDF_Lib\MDF_Ontap\MDF_Ontap\ontap.mdf',
 maxsize = 40,
 filegrowth = 5
)
log on(
  name = ontap_log,
 filename='G:\PRATICE_CODE\Database_mySQL_MDF_Lib\MDF_Ontap\MDF_Ontap\ontap_log.ldf',
 maxsize = 40,
 filegrowth = 5
)

-- sử dụng database ontap
use ontap


create table lophoc(
	malop varchar(10) primary key,
	tenlop varchar(20) not null
)

create table sinhvien(
  masv varchar(10) primary key,
  hoten varchar(30) not null,
  malop varchar(10) not null
)

insert into lophoc
values('L1', 'Lop 1'),
	  ('L2', 'Lop 2'),
	  ('L3', 'Lop 3'),
	  ('L4', 'Lop 4')

insert into sinhvien
values('SV01', 'Tran Van A', 'L1'),
	  ('SV02', 'Tran Van B', 'L4'),
	  ('SV03', 'Tran Van C', 'L10'),
	  ('SV04', 'Nguyen Thi A', 'L1'),
	  ('SV05', 'Nguyen Thi B', 'L9'),
	  ('SV06', 'Nguyen Thi C', 'L3')


-- => với inner join diễn gì diễn ra
select l.malop, tenlop, masv, hoten from lophoc l join sinhvien s on l.malop = s.malop
/*
 Tổng kết:
  => qua đoạn code trên ta thấy rõ ràng với Inner join nó chỉ lấy ra đc các thông tin
  mà cả bảng lophoc và sinhvien có còn nhưng cái mà lophop hoc co mà sinh vien khong
  có thì nó không có hiện ra và ngc lại
  => như vậy inner join: thì chỉ nhưng values mà có chung ở 2 bảng thì nó mới match
  con lại thì ẩn đi
*/



/*********TIỀM HIỂU VỀ OUTER JOIN: LEFT - RIGHT**********/
/*
 >>>> outer join: có 2 loại là left outer join hay còn gọi left join
 và right outer join hay còn gọi là right join
  
  1/ left outer join:
   => nó xem bản phía bên trai khi join làm bản gốc
   => vậy lấy bản gốc bên trái đối chiều với bảng còn lại cái nào có
   thì match không thì null

   2/ right outer join:
    => ngc lại nó xem bản bên phải khi join làm bản gốc đối chiếu

*/

select l.malop, masv, hoten from lophoc l left outer join sinhvien s on l.malop = s.malop
select s.malop, masv, hoten from lophoc l right outer join sinhvien s on l.malop = s.malop


/************truy vấn join với nhiều bảng một lượt****************/
-- => như vậy join không giới hạn truy vấn chỉ 1 dến 2 bảng
--=> mà nó có thể join rất nhiều bảng table một lúc
use northwind

-- hiển thị các trường mong muốn từ 3 bảng trở lên
select ProductID, p.CategoryID, p.SupplierID, ProductName, CategoryName, CompanyName
from Products p join Categories c on p.CategoryID = c.CategoryID
                join Suppliers s on p.SupplierID = s.SupplierID
