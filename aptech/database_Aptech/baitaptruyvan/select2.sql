use northwind

--01/ Hiển thị tên các sản phẩm thuộc loại ‘seafood’
select * from Categories
select * from Categories where CategoryName = 'Seafood'

--02/Hiển thị danh sách các sản phẩm do nhà cung cấp ‘Pavlova, Ltd.’ cung cấp,
--sắp xếp theo tên sản phẩm.
select * from Products
select * from Suppliers

select P.*, S.CompanyName from Products P join Suppliers S on P.SupplierID = S.SupplierID
where CompanyName = 'Pavlova, Ltd.'

--3. Hiển thị danh sách các loại sản phẩm do nhà cung cấp ‘Exotic Liquids’
--cung cấp.
select * from Categories
select * from Products
select * from Suppliers

select C.CategoryID, CategoryName, CompanyName
from Categories C join Products P on  C.CategoryID = P.CategoryID
                    join Suppliers S on P.SupplierID = S.SupplierID
where CompanyName = 'Exotic Liquids'

--4. Hiển thị thông tin chi tiết các hóa đơn như:CustomerID, CompanyName,
--OrderID, OrderDate, ProductName, UnitPrice, Quantity của khách hàng
--'Richter Supermarkt’
select  * from Customers
select * from Orders
select * from Products
select * from [Order Details]

select O.OrderID, OrderDate, ProductName, r.UnitPrice, Quantity, CompanyName
from Customers C join Orders O on C.CustomerID = O.CustomerID
                 join  [Order Details] r on O.OrderID = r.OrderID
				 join  Products P on r.ProductID = P.ProductID
where CompanyName = 'Richter Supermarkt'


--5. Lấy tên các sản phẩm đã được bán trên các hóa đơn (sử dụng join)
select * from Products
select * from [Order Details]

select  distinct  OrderID,  O.ProductID, ProductName
from Products P join [Order Details] O on P.ProductID = O.ProductID


--6. Lấy ra tên các sản phẩm chưa từng được bán (sử dụng outer join)
select * from Products
select * from [Order Details]
--> nghãi là sp ở bảng P có mà ở Order d. cũng có thì loại còn có ở P mà không có ở Order D. thì 
-- tức là null là chưa bán thì hiên thị ra
--c1
select P.*, r.*
from Products P left outer join [Order Details] r on P.ProductID = r.ProductID
where r.ProductID is null 

--c2
select ProductID
from Products where ProductID not in (select distinct ProductID from [Order Details])



--7. Lấy tên các sản phẩm đã được bán trên các hóa đơn với tổng lượng bán lơn
--hơn 1000
select * from Products
select * from [Order Details]

select O.ProductID, ProductName, sum(Quantity) as Tong
from Products P join [Order Details] O on P.ProductID = O.ProductID
group by O.ProductID, ProductName
having sum(Quantity) >=1000
order by ProductID 

--8. Hiển thị mã khách hang, tên khách hàng và số lượng các hóa đơn do các
--khách hàng đó đã đặt.
select * from Customers
select * from Orders

select C.CustomerID, CompanyName, count(OrderID)
from Customers C join  Orders O on C.CustomerID = O.CustomerID
group by C.CustomerID, CompanyName


--9. Hiển thị 4 khách hàng có tổng trị giá mua hàng lớn nhất
select * from Customers
select * from Orders
select * from [Order Details]



select top 4 O.CustomerID, CompanyName, sum(UnitPrice*Quantity) as total
from Customers C join Orders O on C.CustomerID = O.CustomerID
                 join [Order Details] r on O.OrderID = r.OrderID
group by O.CustomerID, CompanyName
order by total desc



--10.Hiển thị 10 sản phẩm có đơn giá cao nhất.
select * from Products
select top 10 *
from Products order by UnitPrice desc