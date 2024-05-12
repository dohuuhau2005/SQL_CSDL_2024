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

('VL', N'V?t L�')

INSERT INTO MONHOC

VALUES

('01', N'C? s? d? li?u', 45),

('02', N'Tr� tu? nh�n t?o', 45),

('03', N'Truy?n tin', 45),

('04', N'?? h?a', 60),

('05', N'V?n ph?m', 60),

('06', N'Ky? thu�?t l�?p tr�nh', 45),

('07', N'Ky? n?ng m?m', 30)

INSERT INTO SINHVIEN(MaSV, HoSV, TenSV, Phai, NgaySinh, NoiSinh, MaKh, HocBong)

VALUES

('A01', N'Nguy?n Th?', N'H?i', 1, '1993-02-23', N'H� N?i', 'TH', 130000),

('A02', N'Tr?n V?n', N'Ch�nh', 0, '1992-12-24', N'Ninh B�nh', 'VL', 150000),

('A03', N'L� Thu B?ch', N'Y?n', 1, '1993-02-21', N'Tp HCM', 'TH', 170000),

('A04', N'Tr?n Anh', N'Tu?n', 0, '1994-12-20', N'H� N?i', 'AV', 80000),

('A05', N'L�m Ng?c', N'H?i', 0, '1993-10-11', N'Tp HCM', 'AV', 100000),

('B01', N'Tr?n Thanh', N'Mai', 1, '1993-08-12', N'H?i Ph�ng', 'TR', 0),

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
--1. Danh s�ch c�c m�n h?c c� t�n b?t ?�?u b?ng ch?? T, g?m c�c th�ng tin: M� m�n, T�n m�n, S�? ti�?t.
select MaMH , SoTiet, TenMH
from MONHOC
where TenMH like'T%'
--2. Li?t k� danh s�ch nh??ng sinh vi�n c� ch?? c�i cu�?i c�ng trong t�n la? �i�, g?m c�c th�ng tin: H? t�n sinh vi�n, Nga?y sinh, Ph�i.
select  HoSV+' '+ TenSV as hotensv, NgaySinh, Phai
from SINHVIEN
where TenSV like '%i'

--3. Danh s�ch nh??ng khoa c� k� t? th?? hai c?a t�n khoa c� ch??a ch?? N, g?m c�c th�ng tin: M� khoa, T�n khoa.
select MaKhoa ,TenKhoa
from KHOA
where TenKhoa like '_n%'
--4. Li?t k� nh??ng sinh vi�n ma? h? c� ch??a ch?? Th?.
select * --MaSV, TenSV
from SINHVIEN
where HoSV like N'%Th?%'

--5. Cho bi�?t danh s�ch nh??ng sinh vi�n c� k� t? ?�?u ti�n c?a t�n n?m trong kho?ng t? �a� ?�?n �m�, g?m c�c th�ng tin: M� sinh vi�n, H? t�n sinh vi�n, Ph�i, H?c b�?ng.
select MaSV,  HoSV+' '+ TenSV as hotensv,Phai,HocBong
from SINHVIEN
where TenSV like N'[a-m]%'
--6. Li?t k� c�c sinh vi�n c� h?c b�?ng t? 150000 tr?? l�n va? sinh ?? Ha? N?i, g?m c�c th�ng tin: H? t�n sinh vi�n, M� khoa, N?i sinh, H?c b�?ng.
select  HoSV+' '+ TenSV as hotensv, MaKH, NoiSinh,HocBong
from SINHVIEN
where HocBong=150000 and NoiSinh like N'Ha? N?i'
--7. Danh s�ch c�c sinh vi�n c?a khoa AV va? khoa VL, g?m c�c th�ng tin: M� sinh vi�n, M� khoa, Ph�i.
select MaSV, MaKH,Phai
from SINHVIEN
where MaKH='AV' or MaKH='VL'
--8. Cho bi�?t nh??ng sinh vi�n c� nga?y sinh t? nga?y 01/01/1992 ?�?n nga?y 05/06/1993 g?m c�c th�ng tin: M� sinh vi�n, Nga?y sinh, N?i sinh, H?c b�?ng.
select MaSV,NgaySinh,NoiSinh,HocBong
from SINHVIEN
where NgaySinh>='1992-01-01'and NgaySinh<='1993-06-05'
--where NgaySinh between '1992-01-01' and '1993-06-05'
--9. Danh s�ch nh??ng sinh vi�n c� h?c b�?ng t? 80.000 ?�?n 150.000, g?m c�c th�ng tin: M� sinh vi�n, Nga?y sinh, Ph�i, M� khoa.
select MaSV,NgaySinh,Phai,MaKH
from SINHVIEN
where HocBong between 80000 and 150000
--10. Cho bi�?t nh??ng m�n h?c c� s�? ti�?t l?n h?n 30 va? nh? h?n 45, g?m c�c th�ng tin: M� m�n h?c, T�n m�n h?c, S�? ti�?t.
select MaMH,TenMH,SoTiet
from MONHOC
where SoTiet between 30 and 45
--11. Li?t k� nh??ng sinh vi�n nam c?a khoa c� m� �TH� ho?c �AV�, g?m c�c th�ng tin: M� sinh vi�n, H? t�n sinh vi�n, Ph�i.
select MaSV,  HoSV+' '+ TenSV as hotensv,Phai
from SINHVIEN
where Phai =0and (MaKH='TH' or MaKH ='AV')  
--12. Li?t k� nh??ng sinh vi�n c� ?i?m thi m�n c� m� �01� nh? h?n 5, g?m th�ng tin: M� sinh vi�n v� ?i?m.
select MaSV,Diem
from KETQUA
where MaMH='01' and Diem<5


--13. Li?t k� nh??ng sinh vi�n h?c khoa c� m� �AV� ma? kh�ng c� h?c b�?ng, g?m th�ng tin: M� sinh vi�n, H? va? t�n, N?i sinh.
select MaSV,  HoSV+' '+ TenSV as hotensv,NoiSinh
from SINHVIEN
where MaKH='AV' and HocBong=0
--14. In ra b?ng ?i?m c?a sinh vi�n c� m� �A02�, g?m th�ng tin: M� m�n h?c, l?n thi v� ?i?m.
select MaMH,LanThi,Diem
from KETQUA
where MaSV='A02'
--15. Cho bi�?t danh s�ch nh??ng sinh vi�n ma? t�n c� ch??a k� t? n?m trong kho?ng t? a ?�?n m, g?m c�c th�ng tin: H? t�n sinh vi�n, Nga?y sinh, N?i sinh. Danh s�ch ???c s?p x�?p t?ng d�?n theo t�n sinh vi�n.
select   HoSV+' '+ TenSV as hotensv,NgaySinh,NoiSinh,TenSV
from SINHVIEN
where TenSV like N'[a-m]%'
order by TenSV asc
--16. Li?t k� danh s�ch sinh vi�n, g?m c�c th�ng tin sau: M� sinh vi�n, H? sinh vi�n, T�n sinh vi�n, H?c b�?ng. Danh s�ch s? ???c s?p x�?p theo th?? t? M� sinh vi�n t?ng d�?n.
select  MaSV,HoSV,TenSV,HocBong
from SINHVIEN
order by MaSV asc
--17. Th�ng tin c�c sinh vi�n g?m: H? t�n sinh vi�n, Nga?y sinh, H?c b�?ng. Th�ng tin s? ???c s?p x�?p theo th?? t? Nga?y sinh t?ng d�?n, n?u tr�ng ng�y sinh th� s?p H?c b�?ng gi?m d�?n.
select HoSV,TenSV,NgaySinh,HocBong
from SINHVIEN
order by NgaySinh desc,HocBong
--18. Cho bi�?t danh s�ch c�c sinh vi�n c� h?c b�?ng l?n h?n 100,000, g?m c�c th�ng tin: M� sinh vi�n, H? t�n sinh vi�n, M� khoa, H?c b�?ng. Danh s�ch s? ???c s?p x�?p theo th?? t? M� khoa gi?m d�?n.
select MaSV,HoSV,TenSV,MaKH,HocBong
from SINHVIEN
where HocBong > 10000
order by MaKH desc
--19. In ra danh s�ch sinh vi�n thu?c khoa c� m� �AV�, th�ng tin g?m: M� s? sinh vi�n, h? v� t�n, gi?i t�nh, ng�y th�ng n?m sinh. Danh s�ch ???c s?p x?p theo th? t? t?ng d?n c?a t�n sinh vi�n, n?u tr�ng t�n th� s?p t?ng d?n theo h? sinh vi�n.
select MaSV,HoSV,TenSV,NgaySinh
from SINHVIEN
where MaKH like N'AV'
order by TenSV desc,HoSV

/*KHOA(MaKhoa,TenKhoa)
SinhVien(MaSV HoSV TenSV Phai NgaySinh NoiSinh MaKH HocBong)
MonHoc(MaMH,TenMH,SoTiet)
KetQua(MaSV,MaMH,LanThi,Diem)
/*
