-- dự án bài tập lớn
USE baitaplon
GO


-- **************tạo bảng  khách hàng****************
CREATE TABLE khach_hang(
	Makh INT NOT NULL,
	Ussername NVARCHAR(20),
	Password NVARCHAR(20),
	Tenkhachhang NVARCHAR(15),
	Diachi NVARCHAR(50),
	Dienthoai INT NULL,
	Email CHAR(20)
)
GO
-- Primary key của bảng khách hàng
ALTER TABLE dbo.khach_hang ADD CONSTRAINT key_01 PRIMARY KEY(Makh)




--******* bảng đơn hàng ****

CREATE TABLE Don_hang(
	Madh INT NOT NULL,
	Makh INT NOT NULL,
	Ngaydat DATE,
	Ngaygiao DATE,
	Diachi NVARCHAR(30)
)
GO

-- primary key của bảng đơn hàng
ALTER TABLE dbo.Don_hang ADD CONSTRAINT key_02 PRIMARY KEY(Madh)
-- foreign key cho bảng đơn hàng
ALTER TABLE dbo.Don_hang ADD CONSTRAINT fkey_02 FOREIGN KEY(Makh) REFERENCES dbo.khach_hang(Makh)





--**************tạo Bảng chi tiết đơn hàng******************
CREATE TABLE Chitietdonhang(
	Masp INT NOT NULL,
	Madh INT NOT NULL,
	Dongia INT,
	Soluong INT
)
GO
-- primary key của bảng  chi tiết đơn hàng
ALTER TABLE dbo.Chitietdonhang ADD CONSTRAINT key_03 PRIMARY KEY(Masp,Madh)
-- foreign key cho bảng chi tiết đơn hàng
 --FK01
   ALTER TABLE dbo.Chitietdonhang ADD CONSTRAINT fkey_03 FOREIGN KEY(Masp) REFERENCES dbo.San_pham(Masp)
 --FK02
 ALTER TABLE dbo.Chitietdonhang ADD CONSTRAINT fkey_03_01 FOREIGN KEY(Madh) REFERENCES dbo.Don_hang(Madh)





--************** tạo bảng sản phẩm***********************

CREATE TABLE San_pham(
	Masp INT NOT NULL,
	Tensp NVARCHAR(20),
	Soluong INT,
	Dongia INT
)
GO
-- Primary key cho bảng sản phẩm
ALTER TABLE dbo.San_pham ADD CONSTRAINT key_04 PRIMARY KEY(Masp)




-- *************tạo bản chi tiết sản phẩm*********************
CREATE TABLE Chitietsanpham(
	Masp INT NOT NULL,
	Maloaisp INT NOT NULL,
	Xuatxu CHAR(10) NULL,
	Size CHAR(5) NULL,
	Mota NVARCHAR(30),
	Chatlieu NVARCHAR(20) null
)
GO
-- primary key cho bảng chi tiết sản phẩm
ALTER TABLE dbo.Chitietsanpham ADD CONSTRAINT key_05 PRIMARY KEY(Masp, Maloaisp)
-- foreign key cho bảng chi tiết sản phẩm
 --fkey01
   ALTER TABLE dbo.Chitietsanpham ADD CONSTRAINT fkey_05 FOREIGN KEY(Masp) REFERENCES dbo.San_pham(Masp)
--fkey02
  ALTER TABLE dbo.Chitietsanpham ADD CONSTRAINT fkey_05_01 FOREIGN KEY(Maloaisp) REFERENCES dbo.Loaisanpham(Ma_loaisp)




--**************tạo bảng loại sản phẩm****************
CREATE TABLE Loaisanpham(
	Ma_loaisp INT NOT NULL,
	Masp INT NOT NULL,
	Tenloaisanpham NVARCHAR(20)
)
GO
-- tạo primary key cho bảng Loại sản phẩm
ALTER TABLE dbo.Loaisanpham ADD CONSTRAINT key_06 PRIMARY KEY(Ma_loaisp)
--foreign key cho bảng loại sản phẩm
ALTER TABLE dbo.Loaisanpham ADD CONSTRAINT fkey_06 FOREIGN KEY(Masp) REFERENCES dbo.San_pham(Masp)




