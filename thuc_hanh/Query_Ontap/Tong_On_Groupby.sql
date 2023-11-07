/*********ÔN TẬP VỀ TRUY VẤN NÂNG CAO VỚI GROUPBY**************/
use northwind


-- đếm xem có bao nhiêu mã id trong cột suplierID của bảng products

select * from Products
select SupplierID, count(*) from Products --sai cú pháp
-- => câu lệnh này sai vì counter là đếm tổng số dòng của table
-- => vì vậy để truy vấn đc tổng số id của cột SuplierID thì cần nhóm các id cùng loại lại với groupby
select SupplierID, count(*) from Products group by SupplierID
-- =>lúc này ns nhóm các id chung loại lại làm một và đếm tổng số lần xuất hiện của mỗi loại


--đếm các id cùng cột CUstomerID trong bảng Orders
select CustomerID, count(*) from Orders group by CustomerID


-- gộp các id của ProductID giống nhau lại đếm coi nó có bao nhiêu và tính tổng giá mội ProductID
--=> có sắp xếp theo thứ tự tăng dần
select ProductID from [Order Details]

select ProductID, count(*) as 'Total values', sum(UnitPrice) as 'Total' from [Order Details] group by ProductID order by ProductID

-- nhóm các cột OrderID lại tính tổng tiền và với dk là lớn hơn 200
select OrderID, count(*) as 'total values', sum(UnitPrice) as 'TotalMoney' from [Order Details] group by OrderID
having  sum(UnitPrice) > 200  order by OrderID 



/************************************************/
/****phần nâng cao với roll and cube*************/
select * from Orders

/* yêu cầu đề ra là: quản lý muốn biết trên bản orders các đơn hàng thì
 + biết nhân viên cụ thể của mình đã bán đc bao nhiêu đơn hàng
 cho bao nhiều khách hàng?
 + tổng số đơn hàng bán ra là bao nhiêu?
 + tổng số sản phẩm bán đc cho mỗi mã đơn hàng?
 + tổng số sản phẩm bán đc cho từng khách hàng 
 là bao nhiêu?
*/

-- sử dụng cube
select CustomerID , EmployeeID, count(*) as 'soluong' from Orders 
group by CustomerID, EmployeeID with cube
/*
 => với cube ta có thể quan sát dc gì:
  + nhóm mã kh lại,nhóm đc mã nhân viên lại và xem đc sl cụ thể nv bán cho từng kh và sl tổng
  => nghĩa là ta nhóm đc các mã của mõi kh lại làm một và xem đc bạn nv cụ thể đã bán đc
  cho bao nhiêu kh và sl cụ thể bán đc cho từng kh đó với với tổng sl sp bán đc
  + kéo cúi mã nhân viên thì xem đc tổng số lượng mà nv đó bán là bao nhiêu

  ==> tóm lại cube giúp ta chi tiết hoa hơn trong việc theo dõi nv đã bán đc cho ai, bao nhiêu
  và tổng số lượng đã bán đc
  ==> tuy nhien điểm yếu cube ta thấy:
   + nó không chủ đích nhóm theo mã nào trc sau
   + chi tiết nhưng  lại chỉ thấy đc nv đó bán cho bnhiu kh, mỗi kh bao nhiêu sp và tổng sp bán đc của nv đó
   => nhưng không giúp ta đếm đc kh đó đã mua bởi nv nào và sl cụ thể của
   riêng kh đó là bnhiu?
 
*/


-- rollup
select CustomerID, EmployeeID, count(*) as "sum" from Orders
group by CustomerID, EmployeeID with rollup
/*
=> rollup giai quyết cái đó nó có các điểm khắc chế cube sau:
 + nó chủ địch nhóm và xem cái tp groupby đầu tiên là chủ chốt
  => vd: ta để CustomerID ở đầu thì nó xem CustomerID là đối tượng ưu tiên 
  groupby và xem xét trc

 + nó giúp ta xem đc kh cụ thế đó dã đc bán sp bởi nv nào, và đếm đc
 sl nv đã bán cho kh cụ thể đó
 + nó giúp ta thống kê đc kh cụt hể đó đã mua đc bao nhiểu sp
*/




/*
****************NOTE****************
=> Tóm lại cube giúp ta đi tổng quan hơn với cái nhìn tổng quát.. 
+ sl bán ra, sl kh bán đc, và từng kh đã mua của nv đó là bao nhiêu
=> còn rollup thì đi chi tiết hơn với mã id đc sắp xếp ở vị trí đầu nhằm
giúp ta hiểu rõ từng mã kh(do mã kh để đầu dc rollup ưu tiên)
đã đc bán bởi bao nhiêu nv và cụ thể tổng sp mua đc của kh cụ thể đó


---> nên kết hợp cả 2 để xem xét*/