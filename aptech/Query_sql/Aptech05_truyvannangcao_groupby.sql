USE northwind
GO

-- đếm số lượng cột nào đó nhưng đếm theo nhóm chứ không đếm đại trà hết bảng
SELECT * FROM dbo.Products
--ví dụ đầy là đếm các mã ID trong cột SupplierID xem mỗi giá trị có bao nhiêu
SELECT SupplierID, COUNT(*) FROM dbo.Products GROUP BY SupplierID
--đặt tên cột để tiện theo dõi
SELECT SupplierID, COUNT(*) AS cot_moi FROM dbo.Products GROUP BY SupplierID


-- đếm với cột khác
SELECT * FROM dbo.Orders

SELECT CustomerID, COUNT(*) FROM dbo.Orders GROUP BY CustomerID

-- thay vì đếm ta tính tổng customerID có giá trị tổng EmployeeID là nhiêu
SELECT * FROM dbo.Orders WHERE CustomerID ='ALFKI'
SELECT CustomerID, SUM(EmployeeID) FROM  dbo.Orders GROUP BY CustomerID 


-- tính tổng giá trị từ bảng odder details xem cột oderID có [đơngiá] x [sl] = ?
-->  và tính tổng các giá trị đó lại theo nhóm  của mỗi odderID, (thay vì đếm thì ta nhóm lại rồi tính tổng)
 SELECT * FROM dbo.[Order Details]

 SELECT OrderID, SUM(UnitPrice*Quantity) AS tong FROM dbo.[Order Details] GROUP BY OrderID



 --********** điều kiện với having*************

 SELECT * FROM dbo.Orders
 --nhóm lại đếm theo group by
 SELECT  CustomerID, COUNT(*) FROM dbo.Orders GROUP BY CustomerID
 --dùng đk với havving
 SELECT  CustomerID, COUNT(*) FROM dbo.Orders GROUP BY CustomerID HAVING COUNT(*) >=10


 --dùng đk với bảng customer theo country chỉ hiển thị những quốc gia có số lượng kh >=10
 SELECT * FROM dbo.Customers

 SELECT Country, COUNT(*) FROM dbo.Customers GROUP BY Country HAVING COUNT(*) >=10

 --- kiểm tra thử 1 quốc gia vcos đủ đk trên 10 người
 
 SELECT * FROM dbo.Customers WHERE Country = 'France'
 ---> có đúng 11 kh, >10 từ phép đếm như lệnh đếm theo đk having từ hàm  group by



 -->>> bài tập: tính trung bình giá mỗi loại sản phẩm  giá trung bình theo từng loại
 SELECT * FROM dbo.Products
 SELECT CategoryID, UnitPrice FROM dbo.Products
  SELECT CategoryID, UnitPrice FROM dbo.Products WHERE CategoryID =1

 --> nhóm theo loại trc
 SELECT CategoryID, COUNT(*) FROM dbo.Products GROUP BY CategoryID

 --> tính trung bình theo mã loại
SELECT CategoryID, AVG(UnitPrice) FROM dbo.Products GROUP BY CategoryID


 ---> phân biệt đk where với having theo 2 bài tập sau
 --++ bài 01/ hiển thị tt bảng trên với các các giá trị trung bình các loại mà có  CategoryID <=5. do đụng đến cột nên sẽ dùng where
  SELECT CategoryID, AVG(UnitPrice) FROM dbo.Products WHERE CategoryID<=5 GROUP BY CategoryID
--++02/ xem giá trung bình của các loai mã categoryID mà có giá trung bình trên 30
  SELECT CategoryID, AVG(UnitPrice) FROM dbo.Products  GROUP BY CategoryID HAVING AVG(UnitPrice) >=30
  --> kết hợp đk để cho giá giao động từ 25 tới 40
   SELECT CategoryID, AVG(UnitPrice) FROM dbo.Products  GROUP BY CategoryID HAVING AVG(UnitPrice) BETWEEN 25 AND 40





   --******************BÀI TẬP LÀM THÊM*******************
   --01/ HIỂN THỊ GIÁ LỚN NHẤT CỦA CÁC SẢN PHẨM TRONG BẢN PRODUCTS theo loại sản phẩm
   SELECT * FROM dbo.Products
   SELECT TOP 1 * FROM dbo.Products ORDER BY UnitPrice DESC

   --> truy vấn với group by
   SELECT CategoryID , COUNT(*) FROM dbo.Products GROUP BY CategoryID
   -->Hiển thị giá lớn nhất trong group by theo loại sp
   SELECT CategoryID, MAX(UnitPrice) FROM dbo.Products GROUP BY CategoryID
   --> ss kiểm tra thử phần trên(ktr CategoryID = 1 thui vd tg trung 1 loai kiểm thử coi đúng hông)
   SELECT CategoryID, UnitPrice FROM dbo.Products  WHERE CategoryID = 1 ORDER BY UnitPrice DESc
  


  --02/ Hiển thị trung bình giá các sản phẩm theo nhà cung cấp
  SELECT * FROM dbo.Products
  SELECT SupplierID, AVG(UnitPrice) FROM dbo.Products GROUP BY SupplierID

  --03/ tính tổng hóa đơn theo loại mà tính luôn giảm giá discount
  SELECT * FROM dbo.[Order Details]

  SELECT ProductID , SUM((UnitPrice*Quantity)-Discount) AS tongtien FROM dbo.[Order Details] GROUP BY ProductID









  -- **********************CUBE VÀ ROLLUP************************************

  --+ select group by với cube: cube hàm tính tổng từng thành phần group by và tổng cho cả 2 group by( chi tiết)

  select * from Orders
  --thử nhóm theo EmployeeID để xem nv bán đc cho bao nhiêu kh
  select EmployeeID, count(*) from Orders group by EmployeeID
  ----> rõ ràng tới đây ta chỉ biết đc mã nv và biết đc đến nv đã bán đc cho bao nhiêu kh mà thui



  -- yêu cầu cao hơn mún biết nv đó bán cho kh cụ thể nào và mỗi kh đc bao nhiêu sp ( nên dùng với cube)
  select CustomerID, EmployeeID, count(*) as sum_cube from Orders group by CustomerID, EmployeeID with cube
  ----> với cube ta có thể tổng hợp đc nhiều hơn 1 nhóm với group by và biết đc ngoài bán đc tổng bao sản phẩm
  -- cho bnhiêu kh thì còn biết cụ thể từng kh theo group by và mỗi kh là bao nhiêu sản phẩm, tổng từng chi tiết 
  -- đến tổng hết số lượng khách hàng một cách cụ thể.( lưu ý là nó sẽ tính tổng theo từng nhóm và tất cả)


  --++ select with rollup
  select * from Orders

  select CustomerID, EmployeeID, count(*) as Num_rollup from Orders group by CustomerID, EmployeeID
  with rollup
  ---> rõ ràng khi chạy lệnh ta sẽ thấy nó nhóm theo manv và mã kh, ta vẫn biết đc sl mà mỗi nv bán đc
  --là bao nhiêu nhưng cs sự khác biệt là với rollup nó sẽ tính sum theo đối tượng group by đầu tiên trong 
  -- câu lệnh nghĩa là cụ thể btap này thì nó sẽ tính theo nhóm maKH vì CustomerID xuất hiện đầu tiên
  -- nó sẽ xem coi kh đó mua đc tổng nhiêu sp và đc bán bởi nv nào, và mối nv bán cho mình nhiêu sp
  --===> vì vầy điểm khác nhau giữa rollup và cube là ở chổ cube thì chi tiết hơn tổng quát hơn
  --====> còn với rollup nó sẽ tính dựa trên mã groupby nào xuất hiện đầu tiền khi nhóm và đếm dựa trên đó.


  --=====> như vậy tổng kết là cube đi chi tiết hơn roll up nhưng với cube ta biết đc dễ dàng một nv bán 
  -- đc nhiêu sp và cho bao nhiêu kh, mỗi kh là bao nhiêu sp. nhưng tuy vẫn biết đc kh mua đc nhiêu
  --sản phẩm lại gặp khó trong việc mún biết kh mua bnhieu sp đó đc bán bởi ai nên ta dùng rollup
  -- xét maxkh làm mã đầu tiên để biết cụ thể kh đó mua đc nhiêu và đc bán bởi ai, rollup và cube phải kết hợp như vậy.


  -- kết hợp 2 cách để xem cặn kẽ hơn
  --> xem chi tiết, gặp khó trong việc mún biết nv bán cho bao nhiêu kh cụ thể sp cho từng kh
  select EmployeeID, CustomerID, count(*) from Orders group by EmployeeID,CustomerID with cube
  --> dùng roll up nhóm theo mã nv trc để xem đơn cực từ mã nv
  select EmployeeID, CustomerID, count(*) from Orders group by EmployeeID, CustomerID with rollup




  --*************************************SUB_QUERY**************************
  -- câu lệnh truy vấn con
   select * from [Order Details]
   -- muốn xem giá cao nhất
   select  max(UnitPrice) from Products
   -- vấn đề đặt ra là với lệnh trên chỉ xem đc kq lớn nhất mà hông thấy các thông tin còn lại của dòng
   -- cao nhất muốn xem, tức mún xem không chỉ là kết quả cao nhất mà xem hết thông tin khác của dòng đó
   select top 1 * from Products order by UnitPrice desc

   ---> tuy nhiên thay vì dùng cách sắp xếp giảm dần rồi hiện ra dòng đầu cao nhất,
   --==>  ta dùng câu lệnh con lòng trong câu lệnh lớn 
   select * from Products where UnitPrice=(select max(UnitPrice) from Products)

   --->>>> đây là cậu lệnh con( câu lệnh lòng trong một câu lệnh khác)
