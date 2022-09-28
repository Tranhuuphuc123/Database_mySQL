use northwind
go

--1. Display id, name and sum of freight of every customer who has sum of freight greater than or
--equal to 1000.
select * from Customers
select * from Orders

select O.CustomerID, CompanyName, sum(Freight)
from Customers C join Orders O on C.CustomerID = O.CustomerID
group by O.CustomerID, CompanyName
having sum(Freight)>1000

--2. Display id, full name of all employees and number of orders of every employee. Order the results
--descending.

select  O.CustomerID, CompanyName, count(OrderID)
from Customers C join Orders O on C.CustomerID = O.CustomerID
group by O.CustomerID, CompanyName


--3. Display id, name, sell-price and quantity of products which were sold in 19/7/1996
select * from Products
select * from Orders
select * from [Order Details]

--4. Descrease 30% price of all products which is supported by company named ‘Exotic Liquids’.
select * from Products
select * from Suppliers

select  ProductID, ProductName, CompanyName, UnitPrice
from Products P join Suppliers S on P.SupplierID = S.SupplierID

update Products
set UnitPrice=UnitPrice - (UnitPrice*0.3)
from Products P join Suppliers S on P.SupplierID = S.SupplierID
where CompanyName ='Exotic Liquids'
select * from Products


--

