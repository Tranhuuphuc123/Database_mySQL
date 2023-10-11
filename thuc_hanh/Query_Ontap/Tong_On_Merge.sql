/*****ÔN TẬP KIẾN THỨC VỀ MERGE TRONG SQL*********************/
--================================================================================================================\
--****************CHỨC NĂNG TRUY VẤN NÂNG CAO MERGE************************
/*
---> LƯU Ý: ĐÂY LÀ CHỨC NĂNG THỰC THI Ở SERVER
-- Merge là gộp 2 hay nhiều table với nhau: Chức năng chính là đổ 
source(table nguồn muốn đổ) và gộp vào target(table đích chứa dl khi gộp) 
đòng thời thực thi các chức năng chính:
  + insert
  + update
  + delete

  ==============CHỨC NĂNG==========
  ##Insert: 
  => tiến hành insert dl từ source vào target (ở đây là dl mà ở source có
  mà ở target hông có)    
      vd: table1: 1 2 3 4   table2: 2 3 5  
	  -> ở đẩy merge table1(source)-> table2(target), thì nó tiển hành 
	  insert ~ 1 4 (những giá trị trùg lặp thì không nói), những gtri mà 
	  ở source có mà ở target ko có thì nó sẽ insert vào-> tble2: 1 2 3 4 5      

  ##Update: 
   => giả dụ merge tble1-> tble2, tble1 có phần tử 2 và tble2 cũng có pt 2.. 
   tuy nhiên pt2 ở tble1 có 2 giá trk 2.1, 2.2 còn pt2 ở tble2 có 1 giá trị 2.3... 
   vậy cùng là phần tử số 2 nhưng lại khác tp bên trong thì lúc đi Merge target 
   sẽ dùng chức năng update để cập nhật lại sao cho khi đổ dl từ tble1->tble2 thì
   phần tử thứ 2 đó phải đc update lại đầy đủ gồm; 2.1, 2.2, 2.3


  ##Delete: 
   => xóa ở target:
    ở th 1 insert thì tble1-> tble2: đổ giá trị 1 4 => tble2: 1 2 3 4 5
   tuy nhiên giá trị 5 chỉ có ở target(tức chỗ đích đổ dl mà source đổ qua) mà không 
   có ở source nên nó sẽ tiến hành xóa đi 5==> tbale2: 1 2 3 4


================TỔNG KẾT=================
   => tóm lại tble1 ; 1 2 3 4 , tble2: 2 3 5 khi muốn merge tble1 -> tble2 thì tble1
   là source còn tble2 là target
   => lúc này nó sẽ tiên hành insert, update, delele:
    + insert là thêm 1 cái mà ở source có mà target chưa có gộp vào cho đủ 
	+ còn những cái ở cả 2 đều có mà chi tiết bên trong khác thì update cho đủ.. 
	+ còn cái mà ở target có mà source không có thì nó sẽ xóa đi 
	
	=====> tble2 sau khi đc merge: 1 2 3 4....Thì Lưu ý là inserrt update hay delete
	đi là quyền quyết định ở lập trình viên.. nghĩa là không phải khi merge thì mặc 
	định nó sẽ thực thi 3 chức năng trên mà insert ntn, update ntn, delete ở target
	hay không đều do chúng ta qui định trong code


 =========CẤU TRÚC MẪU=================
-- Cấu trúc:
     Merge <tableName> as target
	 Using <tablename> as source
	 ON target.maID = source.maID
	
	+ trong đó: 
	    ++ target: table đích chứa dữ liệu muốn gộp
		++ source: table nguồn muốn đổ dl đi

      vd: 
	    có table 1 và table 2, muốn đổ dl của table1 vào table 2 và gộp lại thì
		table 1 là source, table 2 là target
*/

use ontap

-- tạo 2 table để thử nghiệm lệnh merge
create table Product1(
 productID int primary key,
 productName varchar(100) not null,
 Rate money
)
create table Product2(
 productID int primary key,
 productName varchar(100) not null,
 Rate money
)

-- chèn dữ liệu vào 2 bảng mới tạo
insert into Product1
values (1, 'Tea', 10.00),
   (2, 'Coffee', 20.00),
   (3, 'Muffin', 30.00),
   (4, 'Biscuit', 40.00)


insert into Product2
values (1, 'Tea', 10.00),
   (2, 'Coffee', 25.00),
   (3, 'Muffin2', 35.00),
   (5, 'Pizza', 60.00)


   -- truy vấn xem trc
select * from Product1
select * from Product2



/*Bài toán đặt ra:
 => merge product 2 vào product 1
 => product 2 source(thực hiện đổ dl), product 1 là target(nơi đổ dl)*/

 -- tiến hành  giải bài toán


 merge Product1 as target
 using Product2 as source
 -- xác lập mã chung liến kết như join vậy
 on(target.productID =  source.productID)
 /*khi nó khớp mã ProductID nhưng lại khác tp phụ khác sau match, 
 ta có thể tiến hành update dl từ source lại cho target (khác ProductName và Rate) 
   => ta có thể dùng các chức năng insert update, delete để xử lý như bên dưới
   => lưu ý matched là kết nối đc nhưng khác tp phụ thì update
   => not matched là không khớp gì lun có thể thêm mới insert, delete đi
 */
 -- khớp mã nhưng tên productName và Rate khác nhau thì update
 when matched and target.productName<>source.productName or target.Rate<>source.Rate
 then update set target.productName = source.productName, target.Rate = source.Rate

 -- nếu trường nó không khớp đc cái productID ban đầu thì insert nó vào luôn
 -- xác định là source không khớp target(by target) nên insert là insert cái từ source vào target 
 when not matched by target
 then insert (productID, productName, Rate) values(source.productID, source.productName, source.Rate);

 -- có thể tiến hành xóa nếu muôn(th này tôi đéo muốn)
 ---> với th này xác định when not matched by targert là ta sẽ xóa dòng ProductID = 4 bên target đi
 /*
  when not matched by target
  then delete

--> lưu ý: nếu xác định là xóa bên source (cái có bên source mà bên target không có) 
      when not matched by source

--> lưu ý: nếu xác định là xóa bên target(cái target có mà source không có) 
      when not matched by target

 */



 -- xem lại kết quả
 select * from Product1
 select * from Product2