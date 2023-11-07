/*********************KỸ THUẬT COMBITING TRONG SQL*********************/
/*
 >>>>KHÁI NIỆM<<<<
  => Trong SQL, "combining" (kết hợp) thường ám chỉ việc kết hợp hoặc liên kết dữ liệu từ hai hoặc 
  nhiều bảng để truy vấn thông tin từ cơ sở dữ liệu. 
  => Kết hợp dữ liệu giữa các bảng là một phần quan trọng của SQL, và nó cho phép bạn truy vấn và
  trích xuất thông tin phức tạp từ nhiều nguồn dữ liệu khác nhau


 ============================CÁC TOÁN TỬ CỦA COMBITING==================================================
  => Có nhiều cách để kết hợp combiting với các lệnh như:
   # JOIN: lệnh Join đã đc học qua và thực hiện rất nhiều (có thể xem lại bài về Join)
    -> Syntax:
	    select <value1>, <value2> from <table1> a join <table2> b on a.<key chung> = b.<key chung>
		<=> key chung là cái value mà cả 2 bảng đều có
		==> ở bài này ta không bàn đến truy vấn Join vì join chỉ là lệnh truy vấn hiển thị thui không
		thể hiện tính toán tử tròng kỹ thuật gọi là combiting

   # UNION: toán tử hợp nhau giữa các tập hợp
     
		****Combiting thể hiện phép hợp nhau trong toán học******
			 tập hợp1 =  A: 1 3 4 5  6  9
			 tập hợp2 =  B: 3 4 6 10 15 
			  -> combiting là chính là việc hợp A với B lại với nhau(gom nó lại với nhau)
			  -> A hợp B => C: 1 3 4 5 6 9 10 15
			   + trong đó:
				++ những giá trị chung sẽ hợp lại thành một
				++ nhưng giá trị khác nhau thì gom lại 
				==> vậy việc hợp là gôm hết những cải của nhau lại làm một trong đó các
				giá trị trùng nhau thì xem là 1 thui
				==> vậy trong code sql tính chất hợp nhau combiting nó sẽ dùng toán tử UNION


   # INTERSECT: toán tử giao nhau giữa các tập hợp

       ****Combiting thể hiện phép giau nhau trong toán học******		 
		  tập hợp1 =  A: 1 3 4 5  6  9
		  tập hợp2 =  B: 3 4 6 10 15 
		  -> combiting thể hiện tính nhau giau tức là lấy phần chung mà cả tập hợp1&2 đều có
		  cái mà tập hợp 1 có mà tập hợp 2 không có hoặc ngc lại thì nó không lấy
		  -> A giao với B => C: 3 4 6
		   + trong đó
		     ++ những giá trị trùng nhau của 2 tập hợp sẽ đc nhận còn khác nhau nó không lấy
           ===> vậy trong combiting thì toán tử giao nhau đc thể hiện trong code sql là toán tử 
		   INTERSECT


   # EXCEPT

     ****Combiting thể hiện phép trừ trong toán học******		 
		  tập hợp1 =  A: 1 3 4 5  6  9
		  tập hợp2 =  B: 3 4 6 10 15 
		  -> combiting thể hiện tính trừ trong tập hợp tức là lấy phần mà nó có ở tập hợp này mà không
		  có ở tập hợp kia.
		  -> A - B (thì nó sẽ xét xem value nào có ở A mà không có ở B thì nó lấy) => C: 1 5 9
		  -> B - A (thì nó sẽ xét xem value nào có ở B mà khồng có ở A thì nó lấy) => C:  10 15
           ===> vậy trong combiting thì toán tử trừ nhau trong tập hợp đc thể hiện trong code sql
		   là toán tử EXCEPT

===> Tóm lại combiting chính là khái niệm về sự kết hợp dữ liệu từ nhiều bảng khác nhau 
, nó cho phép bạn trích xuất thông tin từ nhiều bảng hoặc nguồn dữ liệu khác nhau để tạo 
ra thông tin tổng hợp hoặc báo cáo phù hợp với nhu cầu của bạn => yêu câu đây là các toán 
tử Union. intersect except... để thực hiện xuất kết quả từ các tập hợp đó.
*/


use ontap
-- tạo 2 table 3&4
create table Product3(
 productID int primary key,
 productName varchar(100) not null,
 Rate money
)
create table Product4(
 productID int primary key,
 productName varchar(100) not null,
 Rate money
)

-- chèn dữ liệu
insert into Product3
values (1, 'Tea', 10.00),
   (2, 'Coffee', 20.00),
   (3, 'Muffin', 30.00),
   (4, 'Biscuit', 40.00)


insert into Product4
values (1, 'Tea', 10.00),
   (2, 'Coffee', 25.00),
   (3, 'Muffin2', 35.00),
   (5, 'Pizza', 60.00)

select * from Product3
select * from Product4

--*********** code thực nghiệm UNION************
-- # th1: xét giao nhau của productId giữa 2 table product3 & 4 thui nha
  select productID from Product3
  union
  select productID from Product4
 -- # th2 dùng UNION ALL: nghĩa là nó xem key trùng là 2 cái lun chứ không gộp lại làm 1, vd: 2 củ table1 & 2 là 2 cái luôn
  select productID from Product3
  union all
  select productID from Product4

  -- #th3: Union vơi nhiều trường value hơn => rõ ràng kw bạn thấy là key 3 của table3&4 trùng nhau nhưng tên # nên nó xem là 2
   select productID, productName from Product3
   union
   select productID, productName from Product4



--************ code thực nghiệm INTERSECT************
 -- #th1: lấy các giá trị trùng nhau ỏ 2 bên table
  select * from Product3
  select * from Product4

  select productID from Product3
  intersect
  select productID from Product4

 -- #th2: nhiều giá trị hơn thì sao => mặc dù key 3 của table3&4 là giống nhau nhưng name khác thì vẫn xem là không trùng
  select productID, productName from Product3
  intersect 
  select productID, productName from Product4



--************ code thực nghiệm EXCEPT***************
 -- #th1: dùng except lấy cái có trong table3 mà không có table4
  select productID from Product3
  except
  select productID from Product4

  -- #th2: nhiều trg dữ liệu hơn nè
  select productID, productName from Product3
  except
  select productID, productName from Product4

  --<=> tự thử ngc lại