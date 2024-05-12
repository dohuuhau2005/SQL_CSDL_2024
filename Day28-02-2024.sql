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

('AV', N'Anh v?n'),

('TH', N'Tin H?c'),

('TR', N'Tri?t'),

('VL', N'V?t Lý')

INSERT INTO MONHOC

VALUES

('01', N'C? s? d? li?u', 45),

('02', N'Trí tu? nhân t?o', 45),

('03', N'Truy?n tin', 45),

('04', N'?? h?a', 60),

('05', N'V?n ph?m', 60),

('06', N'Ky? thuâ?t lâ?p trình', 45),

('07', N'Ky? n?ng m?m', 30)

INSERT INTO SINHVIEN(MaSV, HoSV, TenSV, Phai, NgaySinh, NoiSinh, MaKh, HocBong)

VALUES

('A01', N'Nguy?n Th?', N'H?i', 1, '1993-02-23', N'Hà N?i', 'TH', 130000),

('A02', N'Tr?n V?n', N'Chính', 0, '1992-12-24', N'Ninh Bình', 'VL', 150000),

('A03', N'Lê Thu B?ch', N'Y?n', 1, '1993-02-21', N'Tp HCM', 'TH', 170000),

('A04', N'Tr?n Anh', N'Tu?n', 0, '1994-12-20', N'Hà N?i', 'AV', 80000),

('A05', N'Lâm Ng?c', N'H?i', 0, '1993-10-11', N'Tp HCM', 'AV', 100000),

('B01', N'Tr?n Thanh', N'Mai', 1, '1993-08-12', N'H?i Phòng', 'TR', 0),

('B02', N'Tr?n Th? Thu', N'Th?y', 1, '1994-01-02', N'Tp HCM', 'AV', 0)

INSERT INTO KETQUA (MaSV, MaMH, LanThi, Diem)

VALUES

('A01', '01', 1, 3),

('A01', '01', 2, 6),

('A01', '03', 1, 5),

('A02', '01', 1, 4.5),

('A02', '01', 2, 7),

('A02', '03', 1, 10),

('A02', '05', 1, 9),

('A03', '01', 1, 2),

('A03', '01', 2, 5),

('A03', '03', 1, 2.5),

('A03', '03', 2, 4),

('A04', '05', 2, 10),

('A05', '05', 1, 8),

('A05', '07', 1, 9),

('B01', '01', 1, 7),

('B01', '03', 1, 2.5),

('B01', '03', 2, 5),

('B02', '02', 1, 6),

('B02', '04', 1, 10)
--1. Danh sách các môn h?c có tên b?t ?â?u b?ng ch?? T, g?m các thông tin: Mã môn, Tên môn, Sô? tiê?t.
select MaMH , SoTiet, TenMH
from MONHOC
where TenMH like'T%'
--2. Li?t kê danh sách nh??ng sinh viên có ch?? cái cuô?i cùng trong tên la? ‘i’, g?m các thông tin: H? tên sinh viên, Nga?y sinh, Phái.
select  HoSV+' '+ TenSV as hotensv, NgaySinh, Phai
from SINHVIEN
where TenSV like '%i'

--3. Danh sách nh??ng khoa có ký t? th?? hai c?a tên khoa có ch??a ch?? N, g?m các thông tin: Mã khoa, Tên khoa.
select MaKhoa ,TenKhoa
from KHOA
where TenKhoa like '_n%'
--4. Li?t kê nh??ng sinh viên ma? h? có ch??a ch?? Th?.
select * --MaSV, TenSV
from SINHVIEN
where HoSV like N'%Th?%'

--5. Cho biê?t danh sách nh??ng sinh viên có ký t? ?â?u tiên c?a tên n?m trong kho?ng t? ‘a’ ?ê?n ‘m’, g?m các thông tin: Mã sinh viên, H? tên sinh viên, Phái, H?c bô?ng.
select MaSV,  HoSV+' '+ TenSV as hotensv,Phai,HocBong
from SINHVIEN
where TenSV like N'[a-m]%'
--6. Li?t kê các sinh viên có h?c bô?ng t? 150000 tr?? lên va? sinh ?? Ha? N?i, g?m các thông tin: H? tên sinh viên, Mã khoa, N?i sinh, H?c bô?ng.
select  HoSV+' '+ TenSV as hotensv, MaKH, NoiSinh,HocBong
from SINHVIEN
where HocBong=150000 and NoiSinh like N'Ha? N?i'
--7. Danh sách các sinh viên c?a khoa AV va? khoa VL, g?m các thông tin: Mã sinh viên, Mã khoa, Phái.
select MaSV, MaKH,Phai
from SINHVIEN
where MaKH='AV' or MaKH='VL'
--8. Cho biê?t nh??ng sinh viên có nga?y sinh t? nga?y 01/01/1992 ?ê?n nga?y 05/06/1993 g?m các thông tin: Mã sinh viên, Nga?y sinh, N?i sinh, H?c bô?ng.
select MaSV,NgaySinh,NoiSinh,HocBong
from SINHVIEN
where NgaySinh>='1992-01-01'and NgaySinh<='1993-06-05'
--where NgaySinh between '1992-01-01' and '1993-06-05'
--9. Danh sách nh??ng sinh viên có h?c bô?ng t? 80.000 ?ê?n 150.000, g?m các thông tin: Mã sinh viên, Nga?y sinh, Phái, Mã khoa.
select MaSV,NgaySinh,Phai,MaKH
from SINHVIEN
where HocBong between 80000 and 150000
--10. Cho biê?t nh??ng môn h?c có sô? tiê?t l?n h?n 30 va? nh? h?n 45, g?m các thông tin: Mã môn h?c, Tên môn h?c, Sô? tiê?t.
select MaMH,TenMH,SoTiet
from MONHOC
where SoTiet between 30 and 45
--11. Li?t kê nh??ng sinh viên nam c?a khoa có mã ‘TH’ ho?c ‘AV’, g?m các thông tin: Mã sinh viên, H? tên sinh viên, Phái.
select MaSV,  HoSV+' '+ TenSV as hotensv,Phai
from SINHVIEN
where Phai =0and (MaKH='TH' or MaKH ='AV')  
--12. Li?t kê nh??ng sinh viên có ?i?m thi môn có mã ‘01’ nh? h?n 5, g?m thông tin: Mã sinh viên và ?i?m.
select MaSV,Diem
from KETQUA
where MaMH='01' and Diem<5


--13. Li?t kê nh??ng sinh viên h?c khoa có mã ‘AV’ ma? không có h?c bô?ng, g?m thông tin: Mã sinh viên, H? va? tên, N?i sinh.
select MaSV,  HoSV+' '+ TenSV as hotensv,NoiSinh
from SINHVIEN
where MaKH='AV' and HocBong=0
--14. In ra b?ng ?i?m c?a sinh viên có mã ‘A02’, g?m thông tin: Mã môn h?c, l?n thi và ?i?m.
select MaMH,LanThi,Diem
from KETQUA
where MaSV='A02'
--15. Cho biê?t danh sách nh??ng sinh viên ma? tên có ch??a ký t? n?m trong kho?ng t? a ?ê?n m, g?m các thông tin: H? tên sinh viên, Nga?y sinh, N?i sinh. Danh sách ???c s?p xê?p t?ng dâ?n theo tên sinh viên.
select   HoSV+' '+ TenSV as hotensv,NgaySinh,NoiSinh,TenSV
from SINHVIEN
where TenSV like N'[a-m]%'
order by TenSV asc
--16. Li?t kê danh sách sinh viên, g?m các thông tin sau: Mã sinh viên, H? sinh viên, Tên sinh viên, H?c bô?ng. Danh sách s? ???c s?p xê?p theo th?? t? Mã sinh viên t?ng dâ?n.
select  MaSV,HoSV,TenSV,HocBong
from SINHVIEN
order by MaSV asc
--17. Thông tin các sinh viên g?m: H? tên sinh viên, Nga?y sinh, H?c bô?ng. Thông tin s? ???c s?p xê?p theo th?? t? Nga?y sinh t?ng dâ?n, n?u trùng ngày sinh thì s?p H?c bô?ng gi?m dâ?n.
select HoSV,TenSV,NgaySinh,HocBong
from SINHVIEN
order by NgaySinh desc,HocBong
--18. Cho biê?t danh sách các sinh viên có h?c bô?ng l?n h?n 100,000, g?m các thông tin: Mã sinh viên, H? tên sinh viên, Mã khoa, H?c bô?ng. Danh sách s? ???c s?p xê?p theo th?? t? Mã khoa gi?m dâ?n.
select MaSV,HoSV,TenSV,MaKH,HocBong
from SINHVIEN
where HocBong > 10000
order by MaKH desc
--19. In ra danh sách sinh viên thu?c khoa có mã ‘AV’, thông tin g?m: Mã s? sinh viên, h? và tên, gi?i tính, ngày tháng n?m sinh. Danh sách ???c s?p x?p theo th? t? t?ng d?n c?a tên sinh viên, n?u trùng tên thì s?p t?ng d?n theo h? sinh viên.
select MaSV,HoSV,TenSV,NgaySinh
from SINHVIEN
where MaKH like N'AV'
order by TenSV desc,HoSV

/*KHOA(MaKhoa,TenKhoa)
SinhVien(MaSV HoSV TenSV Phai NgaySinh NoiSinh MaKH HocBong)
MonHoc(MaMH,TenMH,SoTiet)
KetQua(MaSV,MaMH,LanThi,Diem)
/*
