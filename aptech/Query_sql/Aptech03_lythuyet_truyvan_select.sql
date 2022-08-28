-- tìm hiểu kiến thức cơ bản về lệnh truy vấn
-- trong phân cơ bản này ta sẽ sử dụng data_mau northwind

USE northwind
go

-- truy vấn select ra tất cả thông tin
SELECT * FROM dbo.Employees

-- ta có thể hiển thị từng cột và kết hợp theo ý như sau
SELECT EmployeeID, lastName, Firstname FROM dbo.Employees
GO

   --// kêt hợp họ và tên lại thông qua dấu '+'
SELECT EmployeeID, lastName + ' ' + Firstname FROM dbo.Employees
GO


-- cách đặt tên hiển thị ch o cột--> lưu ý đây là cách đặt tên khi hiển thị với select không thay thế tên trên create table.
SELECT EmployeeID, lastName + ' ' + Firstname AS 'ho va ten' FROM dbo.Employees
GO


-- phép tính trong select
SELECT * FROM dbo.Products

SELECT ProductID, UnitPrice, UnitsInStock, UnitPrice * UnitsInStock AS 'thanh tien tu tinh'
FROM dbo.Products
GO


--khái báo giá trị tránh lặp lại distinct

SELECT * FROM dbo.Employees

SELECT City FROM dbo.Employees
------> khai báo với ditinct tránh lặp lại từ khóa trùng  nhau
SELECT DISTINCT City FROM dbo.Employees


--using top lấy số dòng hiển thị mong muốn
  SELECT TOP 10 * FROM dbo.Customers

  ---> dùng persent
  SELECT * FROM dbo.Products

  SELECT TOP 10 PERCENT * FROM dbo.Products

  ---thuât ngữ oder by và order by desk sắp xếp atwng và giảm
  SELECT * FROM dbo.Products ORDER BY UnitPrice
  --> chiều giảm dần
   SELECT * FROM dbo.Products ORDER BY UnitPrice DESC


   -- tránh mất dữ liệu với người có chung giá trị với with ties

   SELECT TOP 11 * FROM dbo.Products  ORDER BY UnitPrice DESC

   ---> có 2 giá trị UnitPrice trùng 49.30 nhưng top 10 chỉ lấy 10 nên đã bỏ mất -> khắc phục
   SELECT TOP 11  WITH TIES* FROM dbo.Products ORDER BY UnitPrice DESC




   -- sao chep dữ liệu với lệnh truy vấn select into

   SELECT TOP 11 * FROM dbo.Products
   ----> sao chep và tạo mới bảng phúc 1 chứa toàn bộ thông tin 11 dòng từ Products

   SELECT TOP 11 * INTO phuc01 FROM dbo.Products
   -->kiểm tra bảng phúc 01
   SELECT * FROM dbo.phuc01
   DROP TABLE dbo.phuc01




   -- LỆNH TRUY VẤN VỚI ĐIỀU KIỆN WHERE
   ---> TRONG BẢNG Products ta muốn hiển thị giá từ 10 tới 50-> nghĩa là dùng điều kiện để hiển thị ra nd mong muốn

   SELECT * FROM dbo.Products

   --> hiển thị giá từ 10 tới 50,, lúc này chỉ những dòng có giá 10 tới 50 mới đc hiển thị ra

   SELECT * FROM dbo.Products WHERE UnitPrice BETWEEN 10 AND 50

   ---> kết hợp order by để xem rọn ràng thứ tự

   SELECT * FROM dbo.Products WHERE UnitPrice BETWEEN 10 AND 50 ORDER BY UnitPrice



   -- Điều kiện với IN (trong khoảng liệt kê muốn lấy)
   ---> ví dụ muốn tìm khách hàng mà họ nằm ở những quốc gia cụ thể như UK, France,Spain, USA

   SELECT * FROM dbo.Customers

   SELECT * FROM dbo.Customers WHERE Country IN  ('UK', 'Spain', 'France', 'USA') ORDER BY  Country


   ---> kết hợp điều kiện and đó là vừa nằm trong khoảng các quốc gia của đk với Int mà còn phải là Owner(chủ) trong mục ContactTitle

   SELECT * FROM dbo.Customers WHERE Country IN ('UK', 'Spain', 'France', 'USA') AND ContactTitle = 'Owner'
   ORDER BY Country









   --BÀI TẬP CĂN BẢN VỚI LỆNH TRUY VẤN


   --01 và 02 tìm hóa đơn được xuất vào  năm 1966 và ngày giao cụ thể từ 01/07/1996 tới 20/08/1996
   SELECT * FROM dbo.Orders

   SELECT * FROM dbo.Orders WHERE ShippedDate BETWEEN '1996-01-01' AND '1996-12-31' ORDER BY ShippedDate

   --> or có thể viết gọn

   SELECT * FROM dbo.Orders WHERE YEAR(ShippedDate) = 1996 ORDER BY ShippedDate

   --> tìm hóa đơn có ngày giao cụ thể từ 01/07/1996 tới 20/08/1996

   SELECT * FROM dbo.Orders WHERE ShippedDate BETWEEN '1996-07-01' AND '1996-08-20' ORDER BY ShippedDate


   --03/ tìm hóa đơn được giao ở mỹ trong năm 1996
   SELECT * FROM dbo.Orders

   SELECT TOP 10 * FROM dbo.Orders WHERE ShipCountry ='USA' AND YEAR (ShippedDate) =1996 ORDER BY  ShippedDate

   --04/ tim hóa đơn được lập bởi nhân viên có ID = 1 và khách hàng có ID ERNSH

   SELECT * FROM dbo.Orders WHERE EmployeeID = 1 AND CustomerID = 'ERNSH'
