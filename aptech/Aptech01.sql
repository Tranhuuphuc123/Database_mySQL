--tạo database
CREATE DATABASE phuc
GO

-- xóa database
DROP DATABASE phuc
GO


--tạo database với dg dẫn lưu
CREATE DATABASE phuc 
ON(
	 NAME=phuc,
	 FILENAME ='D:\vidu\phuc.mdf',
	 SIZE=100MB,
	 MAXSIZE=UNLIMITED,
	 FILEGROWTH=100MB
)
LOG ON(
     NAME=phuc_log,
	 FILENAME ='D:\vidu\phuc_log.ldf',
	 SIZE=100MB,
	 MAXSIZE=UNLIMITED,
	 FILEGROWTH=100mb
)
GO


-- tạo file .ndf để mở rộng cho database trên file .mdf
ALTER DATABASE phuc ADD FILEGROUP nhom01


ALTER DATABASE phuc 
ADD FILE(
	 NAME=phuc_recor,
	 FILENAME ='D:\vidu\phuc_recor.ndf'
) TO FILEGROUP nhom01
GO


-- tạo file backup sao lưu với Snapshot

CREATE DATABASE phuc_Snapshot ON
(
  NAME = phuc,
  FILENAME = 'D:\vidu\phuc.ss'
),(
	 NAME=phuc_recor,
	 FILENAME ='D:\vidu\phuc_recor.ss'
)
AS SNAPSHOT OF phuc
----------------> lưu ý khi sao lưu thì có bao nhiêu file đã tạo trc đó bắt buộc file cho vào backup với Snapshot hết


