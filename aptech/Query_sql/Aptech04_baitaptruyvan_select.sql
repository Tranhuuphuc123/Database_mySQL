--1. Display CustomerID and CompanyName of customers from Customers table.
--(Hiển thị CustomerID, CompanyName từ bảng Customer.)
SELECT [CustomerID], [CompanyName] FROM dbo.Customers


--2. Display details of the products which belongs the category 1, 2 or 6.
--(Hiển thị tất cả các trường từ bảng Products với CategoryID bằng 1 hoặc 2 hoặc 6.)
SELECT * FROM dbo.Products WHERE CategoryID IN (1,2,6) ORDER BY CategoryID

--3. Display all of products which has the price from 40 to 50. Sort the resultset by product name.
--(Hiển thị các sản phẩm (products) có giá từ 40 đến 50 và sắp xếp theo tên sản phẩm (ProductName))
SELECT * FROM dbo.Products
SELECT * FROM dbo.Products WHERE UnitPrice BETWEEN 40 AND 50 ORDER BY ProductName


--4. Display 4 first rows in the Employees table.
--(Hiển thị 4 mẫu tin đầu tiên trong bảng EMPLOYEES.)
SELECT TOP 4 * FROM dbo.Employees

--5. Display the information about order details. The resultset should contain
--(Hiển thị tất cả các cột từ bảng Order Details và Amount (thành tiền) =UnitPrice*Quantity)
SELECT *, UnitPrice*Quantity AS 'Amount' FROM dbo.[Order Details]


--6. Display all customers whose names start with ‘A’.
--(Hiển thị tên tất cả các khách hàng (Customers) bắt đầu bằng ký tự ‘A’)
SELECT * FROM dbo.Customers
SELECT * FROM dbo.Customers WHERE CustomerID LIKE 'A%'


--7. Display the list of categories whose names do not end by ‘s’ character.
--(Hiển thị danh sách loại sản phẩm (Categories) có tên loại (CategoryName) không kết thúc bằng ký tự ‘s’)
SELECT * FROM dbo.Categories
SELECT * FROM dbo.Categories WHERE CategoryName NOT LIKE '%s'

--8. Displays the countries of their customers . Make sure that duplicate data ar removed from the list.
--(Hiển thị tên quốc gia từ bảng Customers. Đảm bảo rằng các dòng dữ liệu trùng nhau  được loại khỏi danh sách)
SELECT * FROM dbo.Customers
SELECT  DISTINCT ContactTitle, Country, City FROM dbo.Customers



--9. Display 3 products which have the highest price.
--(Hiển thị 3 sản phẩm (products) có giá cao nhất  )
SELECT * FROM dbo.Products

SELECT TOP 3 * FROM dbo.Products ORDER BY UnitPrice DESC


--10.Display all the orders which were created in December 1997.
--(Hiển thị tất cả các hóa đơn (Orders) đặt vào tháng 12/1997.)
SELECT * FROM dbo.Orders

SELECT * FROM dbo.Orders WHERE OrderDate BETWEEN '1997-12-01' AND '1997-12-31' ORDER BY OrderDate



--11.Increase by 10% for the price of products belonging the supplier 1.
--(update dữ liệu cho cột đơn giá UnitPrice có SupplierID = 1 tăng thêm 10% )
SELECT * FROM dbo.Products

UPDATE dbo.Products
SET UnitPrice=UnitPrice*1.1 WHERE SupplierID=1


--12.Add 2 new customers who lives in Vietnam.

SELECT * FROM dbo.Customers

INSERT dbo.Customers
(
    CustomerID,
    CompanyName,
    Country
)
VALUES
(  
	'A111',
	'ABC',
	'VietNam'
    ),
	(  
	'A112',
	'ABC',
	'VietNam'
    )
--13.Delete all customers who lives in Vietnam.
--14.Delete all of orders which were created by the employee ‘8’ in 1997.
--15.Display all customers who live in ‘USA’, ‘UK’, ‘Mexico’, ‘Brazil’ or
--‘France’. Their region fields are not null and their customer ids contain the character ‘A’



