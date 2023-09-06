--================================================================================================================\
--****************CHỨC NĂNG TRUY VẤN NÂNG CAO MERGE************************
---> LƯU Ý: ĐÂY LÀ CHỨC NĂNG THỰC THI Ở SERVER
-- Merge là gộp 2 hay nhiều table với nhau: Chức năng chính là đổ source(table nguồn muốn đổ) và gộp vào 
-- target(table đích chứa dl khi gộp) đòng thời thực thi insert, update, delete

--> ++ Insert: tiến hành insert dl từ source vào target (ở đây là dl mà ở source có mà ở target hông có)
--           vd: tble1: 1 2 3 4   tble2: 2 3 5  ở đẩy merge tble1-> tble2, thì nó tiển hành insert ~ 1 4 (tức những giá trị
--           trùg lặp thì không nói), những gtri mà ở source có mà ở target ko có thì nó sẽ insert vào-> tble2: 1 2 3 4 5      

---> ++ Update: giả dụ merge tble1-> tble2, tble1 có phần tử 2 và tble 1 cũng có pt 2.. tuy nhiên pt2 ở tble1 có 2 giá trk 2.1 
-- 2.2 còn pt2 ở tble 2 có 1 giá trị 2.3... vậy cùng là phần tử số 2 nhưng lại kahcs tp bên trong thì lúc đi Merge target sẽ dùng
-- chức năng update để cập nhật lại sao cho khi đổ dl từ tble1->tble2 thì pt 2 đó phải đc update lại đầy đủ gồm; 2.1 2.2 2.3

--> ++ delete: xóa ở target ở th 1 insert thì tble1-> tble2: đổ giá trị 1 4=> tble: 1 2 3 4 5 tuy nhiệ giá trị 5 chỉ có ở target
-- mà không có ở source nên nó sẽ tiến hành xóa đi 5==> tbale2: 1 2 3 4

--->>>tóm lại tble1 ; 1 2 3 4 , tble2: 2 3 5 khi muốn merge tble1 -> tble2 thì tble1 là source còn tble2 là targer
--->>> lúc này nó sẽ tiên hành insert, update, delele-> insert là thêm ! cái mà ở source có mà targer chưa có gộp vào cho đủ
-->> còn những cái ở cả 2 đều có mà chi tiết bên trong khác thì update cho đủ.. còn cái mà ở target có mà source không có thì
-->> nó sẽ xóa đi ==> tble2 sau khi đc merge: 1 2 3 4....
--======> Lưu ý là inserrt update hay delete đi là quyền quyết định ở lập trình viên.. nghĩa là không phải khi merge thì mặc 
-- nó sẽ thực thi 3 chức năng trên mà insert ntn, update ntn, delete ở target hay không đều do chúng ta qui định trong code

-- Cấu trúc:
--   Merge
--   Using
--   ON target.maID = source.maID
--> ++ trong đó: target: table đích chứa dữ liệu muốn gộp
-->				 source: table nguồn muốn đổ dl đi
--> vd: có table 1 và table 2, muốn đổ dl của table 1vào table 2 và gộp lại thì table 1 là source, table 2 là target
use Lib_Manager
go

select * from lophoc
select * from sinhvien		

------------------------
use Lib_Manager

-- tạo 2 table để thử thực nghiệm lệnh gộp merge
create table Product1(
  ProductID int primary key,
  ProductName varchar(100),
  Rate money
)

create table Product2(
  ProductID int primary key,
  ProductName varchar(100),
  Rate money
)

-- chèn dữ liệu
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



-- bài toán: gộp Product2 vào Product 1 -> Product1 sẽ đc xác định là target còn Product2 là source
merge Product1 as target
using product2 as source
on(target.ProductID = source.ProductID) -- xác lập mã chung liến kết như join vậy
-- khi nó khớp mã ProductID nhưng lại khác tp phụ khác sau match, ta có thể tiến hành update dl từ source lại cho target 
-- câu lệnh sau ám chỉ nó matched ProductID nhưng lại khác ProductName và Rate
when matched and target.ProductName<>source.ProductName or target.Rate <> source.Rate
-- thì ta tiến hành update lại dl theo bên source đổ qua bên target sau câu lệnh then
then update set target.ProductName = source.ProductName, target.Rate = source.Rate

-- nếu các trg hợp ProductID không match
when not matched by target
-- tiến hành chèn thêm dòng từ source vào targget luôn
then insert (ProductID, ProductName,Rate) values (source.ProductID,source.ProductName,source.rate);


-- truy vân xem lại
select * from product1
select * from Product2
---> lúc này hai bảng merge giá trị y như nhau

--==> th này liệt kê cho đủ các lệnh do câu insert đã chèn rồi nếu xóa cùng lúc sẽ lỗi
-- nếu các trh hợp ProductID không Match nghĩa là bên này có mà bên kia không có và ngc lại
when not matched by target
-- tiến hành xóa đi ProductID đó
--> lưu ý: nếu xác định là xóa bên source(cái có bên source mà bên target không có) when not matched by source
--> lưu ý: nếu xác định là xóa bên target(cái target có mà source không có) when not matched by target
then delete 
---> với th này xác định when not matched by targert là ta sẽ xóa dòng ProductID = 4 bên target đi



-- NOTE: các trường hợp update, insert và delete đều sẽ diễn ra trên tbale đc xác định là target\
--> nghĩa là khi ta gộp merge suorce vào target thì mọi thay đổi trên sẽ diễn ra ở phía target chứ không phảu source
--> Cca scaau lệnh insert, update, delete ntn là do ta quyết định nghĩa là mún xóa, thêm hay sữa có thể làm còn không vẫn
-- được nó sẽ tiền hành gộp hết. lưu ý thêm khi sourrce có mà target không có mún thêm hay không tùy
-- xóa khi sourrce có mà target không có muốn xóa hay không tuy do mình
-- nên sữa hay không khi source có target có nhưng # nhau tp phụ, sưa nnt từ bên nào do ta quyết định
--===> câu lệnh đk sau merger tùy biến không cố định