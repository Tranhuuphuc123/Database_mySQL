create database TestDB
on(
    name = TestDB,
	filename ='G:\PRATICE_CODE\Database_mySQL\aptech\database_Aptech\Data_merge_combitting\TestDB.mdf',
	size = 100,
	maxsize = 200,
	filegrowth = 50
)
log on(
	name = TestDB_log,
	filename ='G:\PRATICE_CODE\Database_mySQL\aptech\database_Aptech\Data_merge_combitting\TestDB_log.ldf',
	size = 100,
	maxsize = 200,
	filegrowth = 50
)

use TestDB
go





--MERGE

CREATE TABLE Products1
(
   ProductID INT PRIMARY KEY,
   ProductName VARCHAR(100),
   Rate MONEY
) 
GO

CREATE TABLE Products2
(
   ProductID INT PRIMARY KEY,
   ProductName VARCHAR(100),
   Rate MONEY
) 
GO

--Insert records into target table
INSERT INTO Products1
VALUES
   (1, 'Tea', 10.00),
   (2, 'Coffee', 20.00),
   (3, 'Muffin', 30.00),
   (4, 'Biscuit', 40.00)

--Insert records into source table
INSERT INTO Products2
VALUES
   (1, 'Tea', 10.00),
   (2, 'Coffee', 25.00),
   (3, 'Muffin2', 35.00),
   (5, 'Pizza', 60.00)
GO


select * from Products1
select * from Products2


-- tiến hành Merge
merge Products1 as target
using Products2 as source
on (target.ProductID = source.ProductID)
-- tiến hành kèm theo điều kiện để thể hiện rõ chức năng insertt update delete của merge
-- tiến hành update (id khớp nhưng tp name và rate không khớp nên ta update lại từ source qua target)
when matched and target.ProductName <> source.ProductName or target.Rate <> source.Rate
then update set target.ProductName = source.ProductName, target.Rate = source.Rate
-- tiến hành delete (không khớp ở phía source nghĩa là id 4 có ở target mà không có ở source)
when not matched by source
then delete

--tiến hành insert (id 5 có ở source mà không có ở target ta không xóa mà mún thềm nguyên id name rate 
--qua target )
when not matched by target
then insert (ProductID, ProductName, rate) values (source.ProductID, source.ProductName, source.rate);



---->Note: lưu ý khi kết thúc câu lệnh với merge cần chú ý có dâu ';'