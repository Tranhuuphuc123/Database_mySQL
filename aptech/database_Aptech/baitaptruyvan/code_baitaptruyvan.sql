create database DVDlibary on(
 name = DVDlibary,
 filename ='G:\PRATICE_CODE\Database_mySQL\aptech\database_Aptech\baitaptruyvan\DVDlibary.mdf',
 size = 50,
 maxsize= 100,
 filegrowth = 10
)
log on(
 name = DVDlibary_log,
 filename = 'G:\PRATICE_CODE\Database_mySQL\aptech\database_Aptech\baitaptruyvan\DVDlibary_log.ldf',
  size = 50,
 maxsize= 100,
 filegrowth = 10
)

--sử dụng database
use DVDlibary
go


-- tạo bảng dữ liệu Employees
create table Employees(
 EmployeeID char(10) primary key,
 EmployeeName nvarchar(30) not null default 'user',
 Password char(15) not null default 'user'
)

-- tạo bảng orders
create table Orders(
 OrderID int primary key,
 CustomerID int not null,
 CustomerADD nvarchar(10) not null,
 EmployeeID char(10)
)
alter table Orders add foreign key(EmployeeID) references Employees(EmployeeID)
alter table Orders add foreign key(CustomerID) references Customer(CustomerID)
--> update dữ liệu
alter table Orders alter column CustomerADD nvarchar(40)

--tạo bảng Customer
create table Customer(
  CustomerID int primary key,
  CustomerName nvarchar(30) not null default 'Noname',
  Address varchar(20) not null,
  Discount int
)
-->> update
alter table Customer alter column Address nvarchar(40)

--tạo bảng Orderdetails
create table Orderdetails(
 OrderID int not null,
 DVDCodeNo numeric not null,
 Quanlity int,
 Date_r money not null
 
)
alter table Orderdetails add primary key (OrderID, DVDCodeNo)
alter table Orderdetails add foreign key(OrderID) references Orders(OrderID)
alter table Orderdetails add foreign key(DVDCodeNo) references DVDlibary(DVDCodeNo)
--> xoa cot date_r
alter table Orderdetails drop column Date_r


---> thêm đk 
alter table Orderdetails add check (Quanlity>=1 and Quanlity <=200)

--tạo bảng DVDlibary
create table DVDlibary(
 DVDCodeNo numeric primary key,
 DVDTitle char(40), 
 Language char(20) not null default 'N/A',
 Subtitles bit not null,
 Price money default '1500'

)

--> thêm điều kiện
alter table DVDlibary add check( Language in ('chinese', 'Vietnamese','USA','French'))


-- ******************************************************************************************
--Phần nhập dữ liệu các bảng

INSERT INTO Employees VALUES ('EM01', 'John', '123'),
							('EM02', 'Shara', '456'),
							('EM03', 'Mary', '789')



INSERT INTO Customer VALUES (1,'Cusc-DHCT', '1 Ly Tu Trong - Can Tho', 5),
							( 2,'TPT', '4 Ly Tu Trong - Can Tho', 0),
							(3,'Manu Life', '18 Chau Van Liem-Can Tho', 7),
							(4,'Khai Nguyên', '15 - 3/2 - Can Tho ', 8),
							(5,'Á Châu', '16 Mau Than-Can Tho', 2),
							(6,'Phong Than ', '9 Hoa Binh -Can Tho', 0),
							(7,'Pepsi Viet Nam', '15 Le Hong Phong -Can Tho', 0),
							(8,'Châu Van Liêm', '16 Ngo Quyen -Can Tho ', 0)

INSERT INTO DVDlibary VALUES    (1, 'Vinci', 'USA',1 ,15000),
								(2, 'Tazan boy', 'French', 1 ,25000),
								(3, 'The Condor Hero', 'USA', 0 ,11000),
								(4, 'Thien Long bat bo', 'Chinese ',1 ,15000),
								(5, 'Thien tam bien', 'Chinese ', 0,15000),
								(6, 'The Aviator', 'French', 0,17000),
								(7, 'Hoang Tu Ech ', 'Chinese ',0 ,34000)

INSERT INTO Orders VALUES	(1,2, '42 Tran Viet Chau-Can Tho', 'EM01'),
							(2,3, '78 Mau Than- Can Tho', 'EM02'),
							(3,8, '89/2 Pham Ngu Lao-Can Tho', 'EM01'),
							(4,1, '4 Tran Van Kheo-Can Tho ', 'EM03'),
							(5,8, '55 Hung Vuong-Can Tho', 'EM01'),
							(6,2, '7 Duong 3/2-Can Tho', 'EM01'),
							(7,1, '32 Nguyen Trai-Can Tho ', 'EM01'),
							(8,4, '21 Cho Binh Thuy-Can Tho', 'EM02'),
							(9,5, '46 Quoc Lo 91B-Can Tho', 'EM02')

INSERT INTO Orderdetails VALUES (1, 1, 5),
								(1, 2, 3),
								(1,4,7),
								(2,3,8),
								(3,7,10),
								(4,2,8),
								(5,1,1),
								(6,3,1),
								(7,2,8),
								(8,6,8)

						
--************************************************************************************
--Phần truy vấn
--01/ hiển thị toan bộ ds của bảng Customer
select * from Customer
--02/ Tìm mã nhân viên (CustomerID) có tên là Shara.
select * from Employees
select * from Employees where EmployeeName = 'Shara'

--03/Hiển thị thong tin chi tiết của các DVD có ngôn ngữ là English
select * from DVDlibary
select * from DVDlibary where Language in ('USA')

--04/hiển thị 2 DVD có đơn giá thấp nhất
select * from DVDlibary
select top 2 * from DVDlibary order by Price

--05/Hiển thị tổng lượng đặt hàng cho tất cả các DVD
select * from Orderdetails
select sum(Quanlity) from Orderdetails

--06/Tính số lượng đơn hàng mà mỗI nhân viên bán được

select * from Orderdetails
select * from Orders
select * from Employees
select * from DVDlibary
---> tiến hành tính tổng
select OrderID,sum(Quanlity)from Orderdetails group by OrderID
select EmployeeID, count(*) from Orders group by EmployeeID

--manv, tennv, tổng số hóa đơn
select * from Orders
select * from Employees

select O.EmployeeID, EmployeeName, count(*) as tonghd from Orders O join Employees e on O.EmployeeID = e.EmployeeID
                                                                   group by O.EmployeeID, EmployeeName
--Hien thi Ma hoa don, Ma khach hang, tong tien cua moi hoa don       
       select * from Orders 
	   select * from Orderdetails
	   select * from DVDlibary

select O.OrderID, CustomerID, sum(O.Quanlity*D.Price) as tongtien
from Orderdetails O join DVDlibary D on O.DVDCodeNo = D.DVDCodeNo
					join Orders r on O.OrderID = r.OrderID group by O.OrderID, CustomerID



															     
--07/Hiển thị số lượng nhân viên bán hàng trong công ty
select * from Employees
select count(*) from Employees
select EmployeeID, count(*) from Employees group by EmployeeID with cube


--08/Đếm số mặt hàng đặt trên từng hóa đơn.(nghĩa là mỗi hóa đơn bán đc nhiêu loại mặt hàng và mã từng loại)
select * from Orderdetails
select OrderID, count(DVDCodeNo) from Orderdetails group by OrderID
--> nâng cao chi tiết hơn biết rõ tên mã hàng luôn
--+ biết rõ hóa đơn 1 bán đc nhiêu hàng và đó là mặt hàng nào cụ thể
select OrderID, DVDCodeNo, count(DVDCodeNo) from Orderdetails group by OrderID, DVDCodeNo with rollup
--+biết đc chi tiết tổng quát cụ thể hiwn là tên mặt hàng đó bán đc bởi những loại mã hóa đơn nào
select OrderID, DVDCodeNo, count(DVDCodeNo) from Orderdetails group by OrderID, DVDCodeNo with cube


--09/Khách hàng hủy đơn hàng có số hóa đơn (OrderID) =1. Đề nghị xóa dữ liệu
--trên các bảng lien quan
use DVDlibary
select * from Orders
select * from Orderdetails
delete from dbo.Orders where CustomerID = 2


--10.Khách hàng ‘Khai Nguyên’ thay đổi địa chỉ thành ‘Soc Trang’. Đề nghị cập
--nhật lạI dữ liệu
select * from Customer
update dbo.Customer set Address = '15 - 3/2 -Tp. soc Trang' where CustomerName='Khai Nguyên'

--11/ Hiển thị số lượng nhân viên của cửa hàng
select * from Employees
select count(*) from Employees
select EmployeeID, count(*) from Employees group by EmployeeID
select EmployeeID, count(*) from Employees group by EmployeeID with rollup

--12/Hiển thị số lượng khách hàng có discount từ 5 trở lên
select * from Customer
select * from Customer where Discount >=5

--13/Tìm giá lớn nhất của các DVD
select * from DVDlibary
select top 1 * from DVDlibary order by Price desc
select max(Price) from DVDlibary


--14/Đếm số lượng các DVD có subtitles
select * from DVDlibary
select count(*) from DVDlibary where  Subtitles = 1
select * from DVDlibary where Subtitles = 1

--15.Hiển thị tổng số lượng các DVD đã bán.
select * from Orderdetails
select sum(Quanlity) from Orderdetails
select DVDCodeNo , sum(Quanlity) from Orderdetails group by DVDCodeNo with rollup

--16.Hiển thị tổng số lượng DVD đã bán của mỗi hóa đơn
select * from Orderdetails
select OrderID , sum(Quanlity) from Orderdetails group by OrderID with rollup

--17.Hiển thị tổng số lượng đã bán đối với mỗi DVD
select * from Orderdetails
select DVDCodeNo , sum(Quanlity) from Orderdetails group by DVDCodeNo with rollup

--18.Hiển thị số lượng khách hàng theo các mức discount.
select * from Customer
select Discount,count(CustomerID)from Customer group by  Discount


--19.Hiển thị thông tin mua hàng của tất cả các khách hàng gồm: Mã hóa đơn, Mã
--khách hàng, Tên khách hàng
select * from Customer
select * from Orders
select OrderID, C.CustomerID, CustomerName from Orders O join Customer C on O.CustomerID = C.CustomerID

--20.Hiển thị danh sách các sản phẩm đã bán trong các hóa đơn, bao gồm: Mã hóa
--đơn, Mã DVD, Tiêu đề DVD, Giá bán, Số lượng bán
select * from Orderdetails
select * from DVDlibary

select OrderID, O.DVDCodeNo, DVDtitle, price, Quanlity
from Orderdetails O join DVDlibary D on O.DVDCodeNo = D.DVDCodeNo

--21.Hiển thị thông tin các hóa đơn: Mã hóa đơn, Mã khách hàng, Tên khách hàng,
--Mã nhân viên lập, Tên nhân viên lập

--22.Cập nhật tên của nhân viên EM01 thành 'Mary'
select * from Employees
update dbo.Employees set EmployeeName ='Mary' where EmployeeID='EM01'

--23.Cập nhật thông tin của nhân viên EM02 có tên là 'Jack' và có password là 'abc'
update dbo.Employees set EmployeeName = 'Jack' ,Password = 'abc' where EmployeeID='EM02'
select * from Employees

--24.Xóa chi tiết hóa đơn của hóa đơn có id = 8
select * from Orderdetails
select * from Orders
delete from Orders where OrderID = 8

--27.Xóa các hóa đơn chi tiết có sản phẩm bán có tiêu đề là 'Hoang Tu Ech'
select * from DVDlibary
select * from Orderdetails
delete from DVDlibary where DVDTitle = 'Hoang Tu Ech'


--28.Sửa số lượng bán = 1 đối với các DVD có tiêu đề là 'Vinci'
select * from DVDlibary