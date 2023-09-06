-- bài này sẽ tiềm hiểu về cách tạo khóa chính và khóa ngoại và set khóa chính và khóa ngoại cho bảng

USE dulieu02
GO

CREATE TABLE khoa_chinh(
	id INT NOT NULL,
	ten NVARCHAR(20) NOT NULL,
	lop CHAR(10) NULL,
	ngaysinh DATE UNIQUE
)
GO

--- tạo khóa chính với cách c4_2 cách tạo uy tín nhất( tham khảo các cách còn lại trong file lý thuyết)

ALTER TABLE dbo.khoa_chinh ADD CONSTRAINT ma_key PRIMARY KEY(id)


-- xoá khoá chính đã thiets lập trước đó, có thể vô hiệu hóa hay mở lại vô hiệu hóa xem trên lý thuyết
ALTER TABLE dbo.khoa_chinh DROP CONSTRAINT ma_key


-- sau khi xóa thì mình xác định lại khóa chính và tiến hành thiết lặp lại
ALTER TABLE dbo.khoa_chinh ADD PRIMARY KEY(id)


