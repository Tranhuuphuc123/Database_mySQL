/*TIỀM HIỂU VỀ CÂU LỆNH SUB QUERY(CÂU LỆNH TRUY VẤN TRONG MỘT CÂU LỆNH TRUY VẤN KHÁC)*/

/*>> Kiến thức:
 - sub-query đơn là là truy vấn trong một lệnh truy vấn khác
==>hya còn gọi là câu lệnh lồng nhau */

--truy vấn tất cả thong tin từ bảng Order Details

use northwind

select * from [Order Details]

-- tiếp tục yêu cầu muốn xem giá lớn nhất của cột Unit Price
select max(UnitPrice) from [Order Details]
/*=> như ta thấy điểm yếu của câu lệnh truy vấn trên là:
 + chỉ thấy đc mỗi giá trị lớn nhất ngoài ra không có thông tin gì cả
 */

 --=> vậy dùng hiển thị kiểu sắp xếp giảm dần order by desc thì sao
 select top 1* from [Order Details] order by UnitPrice desc

 /*rõ rảng với cách này ta xem đc thông tin chi tiêt hơn, tuy nhiên
  + để làm đc điều này khá mất thời gian vào nhiều câu lệnh lòng vòng 
  => vậy còn một cách nhanh hơn là xử lý 1 lần một với subquery
  => tức kết hợp nhiều cách trong 1 lần code không cần dùng nhiều hàm thuộc tính*/

  select * from [Order Details] 
  where UnitPrice = (select max(UnitPrice) from [Order Details])


  /*==> câu lệnh trong câu lệnh, cs thể vận dùng nhiều cách viết khác nhau 
  tuy nhiên cư bản là kết hợp nhiều câu truy vấn giải quyết trong một lần code ở đk
sau đk where để giải quyết cùng lúc các vấn đề*/

