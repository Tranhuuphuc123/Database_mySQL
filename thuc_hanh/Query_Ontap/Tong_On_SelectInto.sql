/*Học về cau lệnh select into sao chép dữ liệu*/
/*
=> select into là cacchs thức sử dụng để sao chép dữ liệu từ một bảng 
hoặc truy vấn kết quả vào một bảng mới hoặc bảng đã tồn tại*/

use Lib_Manager2

select * from Main
select * from child

-- chèn dl 
insert into Main
values(1, 'A', 25, '22/09/1996'),
      (2, 'B', 23, '22/09/1997'),
	  (3, 'C', 27, '22/09/1990')

-- tiến hành sao chép values sang từ bảng Mian sang bảng child
select *
into new_main
from Main

select * from new_main
--=> lúc này ta đã hoàn toàn sao chéo đc cớ sở value của bảng tbale Main sang bảng mới tên là new_main
--=> ta cũng có thể sao chép chỉ một cột nào đó cụ thể thui cũng đc