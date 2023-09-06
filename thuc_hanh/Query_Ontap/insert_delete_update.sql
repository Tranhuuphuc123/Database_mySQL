USE dulieu02
GO

--tạo bảng

CREATE TABLE hocsinh(
	mahs INT NOT NULL,
	ten NVARCHAR(20) NOT NULL,
	lop CHAR(10) NULL,
	gioitinh BIT NOT NULL,
	diemthi FLOAT NOT NULL,
	tienthuong INT NOT NULL,
	ngay DATE NULL
)
GO


-- insert tạo các dòng row dữ liệu

INSERT dbo.hocsinh
(
    mahs,
    ten,
    lop,
    gioitinh,
    diemthi,
    tienthuong,
    ngay
)
VALUES
(   1400253,        -- mahs - int-> số thì ghi trực tiếp
    N'trần văn A',      -- ten - nvarchar(20)-> tên bỏ trong N''
    'A',       -- lop - char(10)-> kiểu char tg tự 
    1,     -- gioitinh - bit-> 0 và 1 the bittwise
    17.5,      -- diemthi - float
    200000,        -- tienthuong - int-> số ghi trực tiếp
    '19950922' -- ngay - date->ghi trong  theo cấu trúc'yy/mm/dd'
    )
	INSERT dbo.hocsinh
	VALUES
	(   1400253,        -- mahs - int
	    N'Trần Văn B',      -- ten - nvarchar(20)
	    'B',       -- lop - char(10)
	    1,     -- gioitinh - bit
	    20.5,      -- diemthi - float
	    300000,        -- tienthuong - int
	    ('19990522') -- ngay - date
	    )
		INSERT dbo.hocsinh
	VALUES
	(   1400253,        -- mahs - int
	    N'nguyễn thi C',      -- ten - nvarchar(20)
	    'C',       -- lop - char(10)
	    0,     -- gioitinh - bit
	    21.5,      -- diemthi - float
	    600000,        -- tienthuong - int
	    ('19970522') -- ngay - date
	    )
		INSERT dbo.hocsinh
	VALUES
	(   1400253,        -- mahs - int
	    N'nguyễn thị A',      -- ten - nvarchar(20)
	    'c',       -- lop - char(10)
	    0,     -- gioitinh - bit
	    18.5,      -- diemthi - float
	    250000,        -- tienthuong - int
	    ('19980522') -- ngay - date
	    )
		GO
        

		--- lệnh delete có điều kiện

		DELETE dbo.hocsinh WHERE gioitinh=0 AND tienthuong<300000
		GO
        
		--update dữ liệu toàn bảng với 1 trường update
		 UPDATE dbo.hocsinh SET mahs = 14001011
		 GO
         
		 --update tòan bảng với nhiều trường giá trị khác nhau
		 UPDATE dbo.hocsinh SET mahs=14001266 , tienthuong=550000
		 GO
         
		 -- update cuẢ TRƯỜNG MONG MUỐN THUI( vd update tieng luong len chi danh cho nu)
		 UPDATE dbo.hocsinh SET  tienthuong=70000 WHERE gioitinh=0
		 go