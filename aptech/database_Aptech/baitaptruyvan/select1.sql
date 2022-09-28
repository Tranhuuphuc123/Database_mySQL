use northwind
go


--1. Display CustomerID and CompanyName of customers from Customers table.

select CustomerID, CompanyName  from Customers

--2. Display details of the products which belongs the category 1, 2 or 6.
--(details: thông tin chi tiết)
select * from Products
select * from Products where CategoryID in(1,2,6)

--3. Display all of products which has the price from 40 to 50. Sort the resultset
--by product name.

select * from Products
select * from Products where UnitPrice between  40 and 50 order by UnitPrice desc

--4. Display 4 first rows in the Employees table.
select top 4 * from Employees

--5. Display the information about order details. The resultset should contain
--Amount column which stores the total value of selling products.
--Amount = UnitPrice * Quantity

select * from [Order Details]
select * ,Quantity * UnitPrice as Amount from [Order Details]

--6. Display all customers whose names start with ‘A’.
select * from Customers
select * from Customers where CompanyName like 'A%'

--7. Display the list of categories whose names do not end by ‘s’ character.
select * from Categories
select * from Categories where CategoryName like '%S'

--8. Displays the countries of their customers . Make sure that duplicate data are
--removed from the list.
select * from Customers

select distinct Country,*  from Customers

--9. Display 3 products which have the highest price.
select * from Products
select top 3 * from Products Order by UnitPrice desc

--10.Display all the orders which were created in December 1997.
select * from Orders

select * from Orders where OrderDate between '1997-12-01' and '1997-12-31'

--11.Increase by 10% for the price of products belonging the supplier 1.
select * from Products
update Products
set UnitPrice=UnitPrice*0.1 where SupplierID = 1

--12.Add 2 new customers who lives in Vietnam.
select * from Customers

insert into Customers( CustomerID, CompanyName, Country)
values('APHK', 'ThPhuc','VietNam'),
      ('AHKK','Thphuc2', 'VietNam')

	  select * from Customers

--13.Delete all customers who lives in Vietnam.
delete from Customers where Country = 'Vietnam'
select * from Customers


--14.Delete all of orders which were created by the employee ‘8’ in 1997.


--15.Display all customers who live in ‘USA’, ‘UK’, ‘Mexico’, ‘Brazil’ or
--‘France’. Their region fields are not null and their customer ids contain the
--character ‘A’
select * from Customers

select *
from Customers where Country in ('USA','UK','Mexico','Brazil', 'France') and CompanyName like 'A%'