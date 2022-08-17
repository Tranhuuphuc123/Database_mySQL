CREATE DATABASE khoa_ngoai
GO
-- sử dụng đến giá trị dữ liệu chính xác tránh nhầm
USE khoa_ngoai
go



-- tạo bảng bộ môn
CREATE TABLE bo_mon(
	mamon INT  NOT NULL PRIMARY KEY,
	tenmon NVARCHAR(20)
)
GO


-- tạo bảng lớp
CREATE TABLE lop(
	malop INT  NOT NULL,
	tenlop NVARCHAR(20)
)
ALTER TABLE dbo.lop ADD CONSTRAINT ma_key01 PRIMARY KEY(malop)
GO


-- tạo bảng giáo viên
CREATE TABLE giaovien(
	 magv INT NOT NULL,
     tengv NVARCHAR(20) DEFAULT N'tên giáo viên',
	 nam_sinh date,
	 diachi NVARCHAR(20) DEFAULT N'địa chỉ nhà',
	 gioitinh BIT,
	 mamon INT NOT null

	 CONSTRAINT ma_key02 PRIMARY KEY(magv) 
)
GO


--tạo bảng học sinh
CREATE TABLE hoc_sinh(
	mahs INT NOT NULL,
	tenhs NVARCHAR(20),

)
ALTER TABLE dbo.hoc_sinh ADD CONSTRAINT ma_key03 PRIMARY KEY(mahs)
GO


-- tạo khóa ngoại lk 2 bảng

ALTER TABLE dbo.giaovien ADD CONSTRAINT ma_key FOREIGN KEY(mamon) REFERENCES dbo.bo_mon(mamon)


-- xóa khóa ngoại
   ALTER TABLE dbo.giaovien DROP CONSTRAINT ma_key

-- set lại khó ngoại
ALTER TABLE dbo.giaovien ADD CONSTRAINT ma_dinh_danh FOREIGN KEY(mamon) REFERENCES dbo.bo_mon(mamon)