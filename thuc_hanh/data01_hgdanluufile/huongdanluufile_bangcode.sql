CREATE DATABASE huuphuc
ON
( NAME = huuphuc,
   FILENAME = 'G:\program file\DUONGAN_DATABASE_SQL\huuphuc.mdf',
   SIZE =20,
   MAXSIZE = 60,
   FILEGROWTH = 10)

   LOG ON(
      NAME =  huuphuc_log,
	  FILENAME = 'G:\program file\DUONGAN_DATABASE_SQL\huuphuc_log.ldf',
	  SIZE = 10,
	  MAXSIZE = 40,
	  FILEGROWTH = 10
   )
   GO
   
