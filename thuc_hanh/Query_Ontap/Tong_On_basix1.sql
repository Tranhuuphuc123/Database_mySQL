/*tổng ôn tập đợt mới- phần basix cơ bản nhất*/
-- tạo cơ sở dữ liệu
create database Lib_Manager2
on(
  name =  Lib_Manager2,
  filename ='G:\PRATICE_CODE\Database_mySQL\thuc_hanh\MDF_Ontap\MDF_LibOntap1\Lib_Manager2.mdf',
  maxsize = 40,
  filegrowth = 5
)
log on(
  name =  Lib_Manager2_log,
  filename ='G:\PRATICE_CODE\Database_mySQL\thuc_hanh\MDF_Ontap\MDF_LibOntap1\Lib_Manager2_log.ldf',
  maxsize = 40,
  filegrowth = 5
)


-- sử dụng đc lib vừa tạo
use Lib_Manager2
go

--=============================ôn tập nội dung cơ bản========================
--I/ tạo bản, thêm, sữa, xóa..
-- create table:
/*kiến thức ôn tập khi create table:
 + identity(1,1): giá trị tự tăng bắt dầu bằng 1 mỗi lần tăng 1 đơn vị
 */
create table employees(
 id int identity(1,1) not null primary key,
 name varchar(50) not null,
 address varchar(100) not null,
 phone varchar(20) not null
)


--- insert chèn dữ liệu vào table
insert into employees
values('Tran Huu Phuc', 'cantho', '0939052119'),
('Tran Ngoc Phung', 'VinhLong', '0939052119'),
('Nguyen Lam Phuong', 'cantho', '0939052119')

-- lệnh truy vấn xem table cơ bản 
select * from employees

-- đổi tên table/ tuowg tự cho đổi tên database
sp_rename employees, Employees
go

select * from Employees


-- đổi tên cột trong table: vd name thành Name
sp_rename 'Employees.name', 'Name', 'column'
go

select * from Employees
go

-- đổi kiểu dữ liệu trong MS SQL
alter table Employees alter column phone nvarchar(10) not null
go

-- xóa table , database luôn xóa hẳn
/*drop table Employees
go

drop database Lib_Manager2
go*/


-- xóa cột trong tabble thui không xóa hết bảng, vd xóa cột phone
alter table Employees drop column phone
go

select * from Employees

-- xóa dữ liệu-> xóa các values trong table ấy
/*delete Employees
go*/



-- tiến hành thêm cột mới
alter table Employees add Phone int
go

select * from Employees


-- udpdate dữ liệu cụ thể cập nhật các số mới chho phone
/*
   update Employees set phone = 093905219 where id = 1

-> đây là cách phổ biến hay làm nhưng quá thủ công ta tiến hành 
update nhiều phone có các id liền kề một lược thay vì từng cái như sau
*/
declare @Counter int set @Counter=1 while(@Counter <=3)
  begin 
    update Employees set Phone = 0521196369 where  id = @Counter set @Counter += 1
  end

select * from Employees


/*
 => nếu giả dụ bạn có thư mục chứa hàng trăm ảnh đi thày vì ngồi viết từng dòng thì có thể 
 dùng cách trên để update một lần một, cách này giúp update tự động nhiều file trong một
 lần code
 ==> tuy nhiên ở trên tội lại gán cứng số phone nếu có nhiều ảnh khác nhau thì nên @Counter + các chỉ số image trong
 folder lưu ảnh
 ==> hãy xem demo sau để tham khảo
*/

/*
DECLARE @Counter INT
SET @Counter=1
WHILE ( @Counter <= 77)
BEGIN
    UPDATE [dbo].[Products] SET  Images = 'images/products/image'+CONVERT(VARCHAR,@Counter)+'.jpg' WHERE ProductID = @Counter
    SET @Counter  = @Counter  + 1
END
*/