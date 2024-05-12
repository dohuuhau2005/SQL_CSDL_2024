use master

if exists(select * from sysdatabases where name='QLDiem')

drop database QLDiem

go

create database QLDiem

go

use QLDiem

create table KHOA(

MaKhoa char(2) constraint PK_KHOA primary key,

TenKhoa nVarChar(20)

)

create table MONHOC(

MaMH char(2) constraint PK_MONHOC primary key,

TenMH nVarchar(30),

SoTiet Tinyint

)

create table SINHVIEN(

MaSV char(3) constraint PK_SINHVIEN primary key,

HoSV nvarchar(30) not null,

TenSV Nvarchar(10) not null,

Phai bit not null,

NgaySinh Date not null,

NoiSinh nvarchar(25),

MaKH char(2) constraint FK_SINHVIEN_KHOA foreign key references KHOA(MaKhoa),

HocBong int default (0)

)

create table KETQUA(

MaSV char (3) constraint FK_KETQUA_SINHVIEN foreign key(masv) references SINHVIEN(MaSV),

MaMH char (2) constraint FK_KETQUA_MONHOC foreign key(MaMH) references MONHOC(MaMH),

LanThi Tinyint,

Diem Decimal(4,2),

constraint PK_KETQUA primary key (MaSV,MaMH,LanThi)

)

INSERT INTO KHOA

VALUES

('AV', N'Anh văn'),

('TH', N'Tin Học'),

('TR', N'Triết'),

('VL', N'Vật Lý')

INSERT INTO MONHOC

VALUES

('01', N'Cơ sở dữ liệu', 45),

('02', N'Trí tuệ nhân tạo', 45),

('03', N'Truyền tin', 45),

('04', N'Đồ họa', 60),

('05', N'Văn phạm', 60),

('06', N'Kỹ thuật lập trình', 45),

('07', N'Kỹ năng mềm', 30)

set dateformat dmy

INSERT INTO SINHVIEN(MaSV, HoSV, TenSV, Phai, NgaySinh, NoiSinh, MaKh, HocBong)

VALUES

('A01', N'Nguyễn Thị', N'Hải', 1, '23/2/2001', N'Hà Nội', 'TH', 130000),

('A02', N'Trần Văn', N'Chính', 0, '20021224', N'Ninh Bình', 'VL', 150000),

('A03', N'Lê Thu Bạch', N'Yến', 1, '20000221', N'Tp HCM', 'TH', 170000),

('A04', N'Trần Anh', N'Tuấn', 0, '20031220', N'Hà Nội', 'AV', 80000),

('A05', N'Lâm Ngọc', N'Hải', 0, '20021011', N'Tp HCM', 'AV', 100000),

('A06', N'Phạm Văn', N'Hải', 0, '20041005', N'Nha Trang', 'TR', 190000),

('B01', N'Trần Thanh', N'Mai', 1, '20030812', N'Hải Phòng', 'TR', 0),

('B02', N'Trần Thị Thu', N'Thủy', 1, '20010102', N'Tp HCM', 'AV', 0)

INSERT INTO KETQUA (MaSV, MaMH, LanThi, Diem)

VALUES

('A01', '01', 1, 3),

('A01', '01', 2, 6),

('A01', '03', 1, 5),

('A01', '07', 1, 8),

('A02', '01', 1, 4.5),

('A02', '01', 2, 7),

('A02', '03', 1, 10),

('A02', '05', 1, 9),

('A02', '07', 1, 7),

('A03', '01', 1, 2),

('A03', '01', 2, 5),

('A03', '03', 1, 2.5),

('A03', '03', 2, 4),

('A03', '07', 1, 10),

('A04', '05', 2, 10),

('A04', '07', 1, 9),

('A05', '05', 1, 3),

('A05', '07', 1, 9),

('A06', '07', 1, 10),

('B01', '01', 1, 7),

('B01', '03', 1, 2.5),

('B01', '03', 2, 5),

('B01', '07', 1, 4),

('B02', '02', 1, 6),

('B02', '04', 1, 10),

('B02', '07', 1, 8)
select * from KHOA
select * from SINHVIEN
select * from KETQUA
select * from MONHOC
--1. Cho biết sinh viên chưa thi môn cơ sở dữ liệu. Thông tin gồm Mã số sinh viên, Họ và tên
select masv as 'ma so sinh vien', HoSV+' '+TenSV as 'Ho va Ten'
from SINHVIEN
where masv <> all (select masv
from MONHOC mh,KETQUA kq
where  mh.MaMH=kq.MaMH
and TenMH=N'Cơ sở dữ liệu')
--cach 2
select MaSV as 'ma sinh vien',HoSV+' '+TenSV as 'Ho va Ten'
from SINHVIEN
where MaSV not in (select MaSV 
from MONHOC mh, KETQUA kq
where mh.MaMH=kq.MaMH 
and TenMH=N'Cơ sở dữ liệu')
--2. Cho biết những sinh viên chưa bao giờ rớt (Giả sử rớt là điểm của môn học <5). Thông tin gồm: Mã số sinh viên, Họ tên và mã khoa.
select	sinhvien.MaSV as 'ma sinh vien',HoSV+' '+TenSV as 'Ho va Ten',MaKH as 'ma khoa'
from SINHVIEN
where 
sinhvien.MaSV not in (select MaSV
from KETQUA
where Diem<5)
--3. Cho biết những sinh viên: Học khoa anh văn có học bổng hoặc Chưa bao giờ rớt (điểm dưới 5).
select MaSV , HoSV+' '+TenSV as 'Ho va Ten',HocBong
from SINHVIEN
where HocBong>0 and MaKH='AV'
union
select sinhvien.MaSV , HoSV+' '+TenSV as 'Ho va Ten',HocBong
from SINHVIEN,KETQUA
where SINHVIEN.MaSV=KETQUA.MaSV
and sinhvien.MaSV not in (select MaSV
from KETQUA
where diem <5)
--4. Cho biết những sinh viên chưa bao giờ rớt (Giả sử rớt là điểm của môn học <5). Thông tin gồm: Mã số sinh viên, Họ tên, phái (thể hiện ‘Nam’ hoặc ‘Nữ’) và tên khoa.
select sv.MaSV as 'Mã số sinh viên',  HoSV+' '+TenSV as 'Ho va Ten',TenKhoa,'phai'= case when phai=1then 'nu'else 'nam' end 
from SINHVIEN sv,KHOA k
WHERE  sv.MaKH=k.MaKhoa and sv.MaSV not in (select masv
from KETQUA
where Diem<5)
--5. Cho biết sinh viên nào không thi lần 1 mà có dự thi lần 2. Thông tin gồm: Mã số sinh viên, Họ tên, phái (thể hiện ‘Nam’ hoặc ‘Nữ’) và tên khoa.
select sv.MaSV as 'Mã số sinh viên',  HoSV+' '+TenSV as 'Ho va Ten',TenKhoa,'phai'= case when phai=1then 'nu'else 'nam' end ,LanThi
from SINHVIEN sv, KHOA k,KETQUA kq
where sv.MaKH=k.MaKhoa and kq.MaSV=sv.MaSV
 and sv.MaSV not in (select MaSV
from KETQUA
where LanThi=1 and LanThi!=2)
--6. Cho biết tên môn nào không có sinh viên khoa anh văn học.
select TenMH
from MONHOC
where  
MaMH not in ( select MaMH
from KETQUA,SINHVIEN
where KETQUA.MaSV=SINHVIEN.MaSV and MaKH='AV')
--7. Cho biết họ tên và phái (thể hiện ‘Nam’ hoặc ‘Nữ’) của những sinh viên khoa anh văn chưa học môn văn phạm.
select HoSV + ' '+TenSV as 'ho va ten' , sinhvien.MaSV, phai=case when phai=1 then 'nu' else 'nam' end
from SINHVIEN
where  sinhvien.MaKH='AV'and
sinhvien.MaSV not in (select MaSV
from KETQUA
where  ketqua.MaMH ='05')
--8. Cho biết tên những môn không có sinh viên rớt ở lần 1.
select TenMH
from MONHOC
where MaMH not in (select mamh
from  KETQUA
where lanthi=1 and Diem<5)
































