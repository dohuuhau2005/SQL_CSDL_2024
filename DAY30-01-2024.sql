create database QLDiem
use QLDiem
create table KETQUA
(
	MASV CHAR(3),
	MAMH CHAR(2),
	LANTHI Tinyint,
	DIEM decimal(4,2),
	constraint PK_KETQUA PRIMARY KEY(MASV,MAMH,LANTHI)
)
create table DMKHOA
(
	MAKHOA CHAR(2) CONSTRAINT PK_DMKHOA PRIMARY KEY,
	TENKHOA NVARCHAR(20),
)
CREATE TABLE DMMH
(
	MAMH CHAR(2) CONSTRAINT PK_DMMH PRIMARY KEY,
	TENMH nVARCHAR(30),
	SOTIET Tinyint,
)
create table DMSV
(
	MASV char(3) constraint PK_DMSV primary key,
	HOSV nVARCHAR(30),
	TENSV nVarchar(10),
	PHAI BIT,
	NGAYSINH datetime,
	NOISINH nVarchar(25),
	MAKH Char(2),
	HOCBONG float,
)
INSERT INTO DMMH
VALUES ('01',N'CƠ SỞ DỮ LIỆU',45),
		('02',N'TRÍ TUỆ NHÂN TẠO',45),
		('03',N'TRUYỀN TIN',45),
		('04',N'ĐỒ HỌA',60),
		('05',N'VĂN PHẠM',60),
		('06',N'KỸ THUẬT LẬP TRÌNH',45)
INSERT INTO DMKHOA
VALUES ('AV',N'ANH VĂN'),
		('TH',N'TIN HỌC'),
		('TR',N'TRIẾT'),
		('VL','VẬT LÝ')
INSERT INTO DMSV
VALUES	('A01',N'Nguyễn thị',N'Hải',1,23/02/1993,N'Hà Nội','TH',130000),
		('A02',N'Trần văn',N'Chính',0,24/12/1992,N'Bình Định','VL',150000),
		('A03',N'Lê thu bạch',N'Yến',1,21/02/1993,N'Tp HCM','TH',170000),
		('A04',N'Trần anh',N'Tuấn',0,20/12/1994,N'Hà Nội','AV',80000),
		('B01',N'Trần thanh',N'Mai',1,12/08/1993,N'Hải Phòng','TR',0),
		('B02',N'Trần thị thu',N'Thủy',1,02/01/1994,N'Tp HCM','AV',0)
INSERT INTO KETQUA
VALUES ('A01','01','1','3'),
	('A01','01','2','6'),
	('A01','02','2','6'),
	('A01','03','1','5'),
	('A02','01','1','4.5'),
	('A02','01','2','7'),
	('A02','03','1','10'),
	('A02','05','1','9'),
	('A03','01','1','2'),
	('A03','01','2','5'),
	('A03','03','1','2.5'),
	('A03','03','2','4'),
	('A04','05','2','10'),
	('B01','01','1','7'),
	('B01','03','1','2.5'),
	('B01','03','2','5'),
	('B02','02','1','6'),
	('B02','04','1','10')
UPDATE DMMH
SET SOTIET=45
WHERE TENMH = N'VăN phạm'
update DMSV
SET TENSV = N'Kỳ'
WHERE TENSV = N'Mai'
UPDATE DMSV
SET PHAI = 0
WHERE TENSV = N'Kỳ'
AND HOSV = N'Trần thanh'
UPDATE DMSV
SET NGAYSINH = 05/07/1997
WHERE HOSV= 'Trần thị thu'
AND TENSV = 'Thủy'
UPDATE DMSV	
SET HOCBONG = HOCBONG + 100000
WHERE MAKH= 'AV'
DELETE FROM KETQUA
WHERE LANTHI = 2 AND DIEM <5
'4.8) KHÔNG THỂ XÓA ĐƯỢC VÌ SỐ 0 LÀ KIỂU NULL KHÔNG ĐÁNG TIN CẬY CÒN KIỂU FLOAT KHÔNG ĐÚNG'





