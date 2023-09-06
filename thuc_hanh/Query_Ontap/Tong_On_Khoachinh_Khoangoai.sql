/*tổng ôn về kháo chính khóa ngoại*/
use Lib_Manager2

-- tiến hành tạo bảng mới ánh xạ 
/*có nhiều cách viết primary key: */



/********************************Khóa chính****************************************/
-- cách 01: 
/*
create table Main(
   id int not null primary key,
   name varchar(100) not null,
   age int not null,
   date varchar not null
 )*/

 -- cách 02:dùng cho trường hợp xác nhận nhiều id cùng lúc làm primary key
 /*
 create table Main(
   id int not null ,
   matma varchar not null,
   name varchar(100) not null,
   age int not null,
   date varchar not null,

   primary key(id, matma)
 )
 */


 -- cách số 3: dùng alter add: có thể mạnh là cứ tạo csdl trc rồi chèn primary key sau
 create table Main(
   id int not null,
   name varchar(100) not null,
   age int not null,
   date varchar not null
 )
 --==> lúc này đã taooj table mà quên tạo primary thì quay lại viết thêm để xác nhận primary key nè
 alter table Main add constraint key_01 primary key(id)

 -- có thể xóa khóa chính thông quá xóa constraints key
 alter table Main drop constraint key_01

 -- tiến hành add lại primary key
  alter table Main add constraint key_01 primary key(id)







 /********************************Khóa ngoại****************************************/
 -- cách tạo khóa ngoại
 /*Lưu ý:
 => đk để đạt khóa ngoại là table muốn tạo khóa ngoại nó phải lk với bảng muốn
 tạo thông qua một key nhật đn=ịnh mà cả ở 2 tbale đều có
 => bảng b mún lk khóa ngoại với bảng A thì key chung đó phải là khóa chính của bảng A
  vd:
   bảng child với bảng main muốn tọa khóa ngoại thông qua key id thì id này phải
   thỏa yêu cầu:
    1/ là khóa chính của table Main
	2/ cả main và child đều có key id*/
  create table child(
   child_id int not null primary key,
   id int not null,
   name varchar(100) not null,
   age int not null,
   date varchar not null
 )

 -- tiến hành xét khóa ngoại cho table child
 alter table child add constraint key_02 foreign key(id) references Main(id)