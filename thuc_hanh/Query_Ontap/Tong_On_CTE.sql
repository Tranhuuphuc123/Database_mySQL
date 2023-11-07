/**************************TIỀM HIỂU VỀ KIẾN THỨC CTE TRONG SQL**********************/
/*
 >>>kHÁI NIỆM<<<
  => CTE(COMMON TABLE EXPRESSION): 
   + CTE (Common Table Expression) là một công cụ mạnh mẽ trong SQL, cho phép bạn tạo một tập hợp tạm thời 
   (temporary result set) có thể được sử dụng trong một truy vấn chính. Và bảng CTE
   chỉ là tạm thời trong thời gian thực hiện truy vấn chính, sau đó nó sẽ mất đi.
   + CTE thường được sử dụng với câu lệnh SELECT, INSERT, UPDATE, và DELETE để tạo hoặc thao tác dữ 
   liệu một cách dễ dàng và rõ ràng hơn. 

   ***Lưu ý ***
    > tạm thời ở đấy là ý nghĩa là trong lúc thực hiện câu lệnh truy vấn
   nó sẽ sinh ra bản tạm thời CTE này, sau khi thực hiện truy vấn xong thì nó sẽ mất
   đi CTE trên
    > do CTE là bản tạm thời sinh ra trong lúc thự hiện truy vấn.. nên ta có thể thao
	tác với nó đc trong lúc nó còn tồn tại
  

  **********************************************************************
  => Dưới đây là một số điểm quan trọng về CTE:
   + Cách Sử Dụng CTE: 
    -> CTE được tạo bằng cách sử dụng câu lệnh WITH. 
	-> Câu lệnh WITH cho phép bạn đặt tên cho CTE và sau đó thực hiện truy 
	vấn đối với nó. 
	-> CTE có thể được sử dụng trong truy vấn chính hoặc trong các CTE khác
	(CTE lồng nhau).
	-> CTE nó có  2 kiểu: một phụ thuộc vào các câu truy vấn chính hai là hoàn toàn 
	độc lập.

   + Sử Dụng Trong Truy Vấn: 
    -> CTE thường được sử dụng để giải quyết các vấn đề phức tạp hoặc lặp đi
	lặp lại trong dự án SQL. 
	-> Chẳng hạn:
	   bạn có thể sử dụng CTE để tính tổng hoặc số lượng các bản ghi, 
	   sắp xếp dữ liệu, hoặc thực hiện các phép toán phức tạp trên dữ liệu.

   + Đặc Điểm Chính: 
    -> Một số đặc điểm chính của CTE bao gồm 
	 ++ tính đệ quy (recursive CTE)
	  -> Một trong những ứng dụng quan trọng của CTE là tính toán các dãy đệ quy, 
	  chẳng hạn như cây đồ thị hoặc danh sách các mục có cấu trúc.
	 ++ khả năng tái sử dụng trong cùng một truy vấn hoặc trong các truy vấn
	 khác.
*/

/*Ví dụ về CTE*/
use northwind

-- thực hiện truy vấn bình thường với các trường hiển thị sau
select ProductID, ProductName, SupplierID, CategoryID, UnitPrice
from Products
where UnitPrice>50

/* Thực hiện với CTE: 
 => có cấu trúc:

   with <CTE Name> as(..<Phần khai báo của CTE>..)
                ..<tập hợp các câu truy vấn chính>..
				
	 - trong đó:
	   + <CTE Name>: đặt tên cho CTE
	   + <Phần khai báo của CTE>:
	     -> Phần này xác định dữ liệu sẽ được trích xuất và xử lý trong CTE. 
		 -> Nó hoạt động như một tập hợp tạm thời để lựa chọn và xử lý dữ liệu trước khi bạn 
		 thực hiện truy vấn chính.
		 
		+ <tập hợp các câu truy vấn chính>:
		 -> Chính là truy vấn chính (main query), trong đó bạn truy vấn dữ liệu từ CTE Product_Temp 
		 và áp dụng một điều kiện bổ sung để lọc kết quả.
		 */
with Product_Temp as (
			  -- tập hợp tạm thời để lựa chọn và xử lý dữ liệu trước khi bạn 
		      -- thực hiện truy vấn chính.
			    select ProductID, ProductName, SupplierID, CategoryID, UnitPrice
				from Products
				where UnitPrice>50
				)
				-- thực hiện câu lệnh truy vấn chính CTE
				select * from Product_Temp
				where CategoryID = 6


-- ==> CTE giúp ta linh hoạt và gọn gàng hơn trong việc truy vấn giữa các bảng
/* giả dụ ta join nhiều bảng.. ra rồi lại thực hiện truy vấn rời rạc khiến mỗi lần kiếm bnagr truy vấn rối
-> thì với CTE nó tạo ra bảng tạm thời của truy vấn join.. trên rồi cứ từ đó thực hiện truy vấn khác lun trên
bang tạm thời đó nhanh gọn lẹ và chính xác.*/




--********trường hợp kế tiếp: trong truy vấn có nhiều bảng tạm thời cùng một lúc****************
--=> (còn gọi là Multiple CTE)
--=> Lưu ý cho có nhiều bảng CTE thì vẫn chỉ có một with 
-- cách thức thực hiện ra sao:
 with Product_Temp1 as (
			  -- tập hợp tạm thời để lựa chọn và xử lý dữ liệu trước khi bạn 
		      -- thực hiện truy vấn chính.
			    select ProductID, ProductName, SupplierID, CategoryID, UnitPrice
				from Products
				where UnitPrice>50
			  ),
      OtherProduct_Details as (
				 select * from  [Order Details]
				 where Discount > 0.2
			   )
		  -- thực hiện câu lệnh truy vấn chính CTE
		  select OrderId, p.ProductId, ProductName, p.UnitPrice, Discount
		  from Product_Temp1 p join OtherProduct_Details od 
		  on p.ProductID = od.ProductID
				



/************************************************************/
-- => dường như ưu điểm của nó vẫn chưa rõ -> cần thực nghiệm nhiều hơn
