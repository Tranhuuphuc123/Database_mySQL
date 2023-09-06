/**************TỔNG ÔN VỀ TRUY VẤN SQL******************/
use Lib_Manager2

-- truy vấn cơ bản tổng quán
select * from Employees

--hiển thị các trường muốn hiển thị cụt hể
select id, Name from Employees

-- đặt tên cho hien thị giá trị riêng
-- thêm cột
alter table Employees add FirstName varchar, LastName varchar
--đổi kiểu dữ liệu
alter table Employees alter column LastName varchar(50)
--cập nhật một lượt
declare @Counter int set @Counter=1 while (@Counter<=3)
 begin
     update Employees set FirstName = 'Tran', LastName='Phuc'
	 where id = @Counter set @Counter+=1
  end

 select * from Employees

-- tiền hành đặt tên hiển thị với select truy vấn
select LastName + '' + FirstName as 'FullName' from Employees



-- thực hiện phép tính trong truy vấn select cơ bản
 select * from Employees

 select Quantity * UnitPrice as 'ThanhTien' from Employees

 -- hiển thị số dòng muốn hiển thị trong tổng số thui
 select top 1* from Employees

 -- Hiển thị theo kiểu phần trăm trên tổng số
 -- vd muốn hiển thị khoảng 50% trên tổng số dòng
 select top 50 percent * from Employees

 -- sắp xếp tăng giảm
 -- sắt xếp tăng theo id đi
 select * from Employees order by id
 -- sắp xếp giảm dần với id dùng thêm desc phía sau
 select * from Employees order by id desc



 -- sử dụng đk với where trong truy vấn
 select * from Employees where address ='cantho'

 -- truy vấn với đk là một ký tự mong muốn
 select * from Employees
 select * from Employees where Name like '%uc%'

 -- đếm table có bao nhiêu dòng tổng số
 select COUNT(*) from Employees

 -- truy vấn tính tổng tiền của cột UnitPrice với sum
 select sum(UnitPrice) as 'Tong Tien' from Employees

 -- tìm giá trị max/min trong cột của table 
 select MAX(UnitPrice) from Employees
 select MIN(UnitPrice) from Employees

 -- tính trung bình cột vd giá trong cột unitPrice
 select AVG(UnitPrice) from Employees

