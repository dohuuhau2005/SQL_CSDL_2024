create table MONHOC

(

MaMH char(2) constraint PK_MONHOC primary key,

TenMH nVarchar(30) not null,

SoTiet Tinyint not null

)

create table KHOA

(

MaKhoa char(2) constraint PK_Khoa primary key,

TenKhoa nVarChar(20) not null

)

create table SINHVIEN

(

MaSV char(3) constraint PK_SINHVIEN primary key,

HoSV nvarchar(30),

TenSV Nvarchar(10),

Phai bit,

NgaySinh Date,

NoiSinh nvarchar(25),

MaKH char(2) constraint FK_SINHVIEN_KHOA foreign key(MaKH) references KHOA(MaKhoa),

HocBong float

)

create table KETQUA

(

MaSV char (3) constraint FK_KETQUA_SINHVIEN foreign key(MaSV) references SINHVIEN(MaSV),

MaMH char (2) constraint FK_KETQUA_MONHOC foreign key(MaMH) references MONHOC(MaMH),

LanThi Tinyint,

Diem Decimal(4,2) not null,

constraint PK_KetQua primary key (MaSV, MaMH, LanThi)
)
insert into MONHOC(MaMH,TenMH,SoTiet)
values ('01',N'Cơ sở dữ liệu',45),
	('02',N'Trí tuệ nhân tạo',45),
	('03',N'Truyền tin',45),
	('04',N'Đồ họa',60),
	('05',N'Văn phạm',60),
	('06',N'kỹ thuật lập trình',45)
insert into KHOA(MaKhoa,TenKhoa)
values ('AV',N'Anh Văn'),
('TH',N'Tin học'),
('TR',N'Triết'),
('VL',N'Vật lý')
insert into SINHVIEN(MaSV,HoSV,TenSV,Phai,NgaySinh,NoiSinh,MaKH,HocBong)
values ('A01',N'Nguyễn Thị',N'Hải',1,'1993-02-23',N'Hà Nội','TH',130000),
('A02',N'Trần Văn',N'Chính',0,'1992-12-24',N'Bình Định','VL',150000),
('A03',N'Lê Thu Bạch',N'Yến',1,'1993-02-21',N'Tp HCM','TH',170000),
('A04',N'Trần Anh',N'Tuấn',0,'1994-12-20',N'Hà Nội','AV',80000),
('B01',N'Trần Thanh',N'Mai',1,'1993-08-12',N'Hải Phòng','TR',0),
('B02',N'TRần Thị Thu',N'Thủy',1,'1994-01-02',N'Tp HCM','AV',0)
insert into KETQUA(MaSV,MaMH,LanThi,Diem)
values
('A01','01' , 1 , 3 )
insert into KETQUA(MaSV,MaMH,LanThi,Diem)
values
('A01', '01', 2 ,6),

('A01','02', 2, 6),

('A01', '03', 1, 5),

('A02','01', 1, 4.5),

('A02', '01', 2, 7),

('A02', '03', 1, 10),

('A02' ,'05', 1, 9),

('A03' ,'01' ,1, 2),

('A03' ,'01', 2, 5),

('A03', '03', 1, 2.5),

('A03' ,'03' ,2, 4),

('A04','05', 2, 10),

('B01', '01', 1, 7),

('B01', '03', 1 ,2.5),

('B01' ,'03' ,2, 5),

('B02' ,'02', 1, 6),

('B02', '04', 1, 10)
update MONHOC
set SoTiet=45
where TenMH=N'Văn phạm'
update SINHVIEN
set TenSV=N'Kỳ'
where MaSV='B01'and HoSV=N'Trần Thanh'
update SINHVIEN
set Phai=0
where MaSV='B01'and HoSV=N'Trần Thanh'and TenSV=N'Kỳ'
update SINHVIEN
set NgaySinh='1997-07-05'
where HoSV=N'TRần Thị Thu'and TenSV=N'Thủy'
update SINHVIEN
set HocBong=HocBong+100000
where MaKH='AV'
delete from KETQUA
where LanThi=2 and Diem<5
'không xóa được bởi vì liên quan tới khóa chính'


