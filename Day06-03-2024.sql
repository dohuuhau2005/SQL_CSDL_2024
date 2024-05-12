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

INSERT INTO SINHVIEN(MaSV, HoSV, TenSV, Phai, NgaySinh, NoiSinh, MaKh, HocBong)

VALUES

('A01', N'Nguyễn Thị', N'Hải', 1, '1993-02-23', N'Hà Nội', 'TH', 130000),

('A02', N'Trần Văn', N'Chính', 0, '1992-12-24', N'Ninh Bình', 'VL', 150000),

('A03', N'Lê Thu Bạch', N'Yến', 1, '1993-02-21', N'Tp HCM', 'TH', 170000),

('A04', N'Trần Anh', N'Tuấn', 0, '1994-12-20', N'Hà Nội', 'AV', 80000),

('A05', N'Lâm Ngọc', N'Hải', 0, '1993-10-11', N'Tp HCM', 'AV', 100000),

('B01', N'Trần Thanh', N'Mai', 1, '1993-08-12', N'Hải Phòng', 'TR', 0),

('B02', N'Trần Thị Thu', N'Thủy', 1, '1994-01-02', N'Tp HCM', 'AV', 0)

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
select * from  KHOA
select * from  MONHOC
select * from  SINHVIEN
select * from  KETQUA
--1. Danh sách sinh viên có n?i sinh ?? Ha? N?i va? sinh va?o tháng 02, g?m các thông tin: H? và tên c?a sinh viên, N?i sinh và Nga?y sinh.
select HoSV+' '+TenSV as hoten,NoiSinh,NgaySinh
from SINHVIEN
where NoiSinh=N'Hà Nội'and month(NgaySinh)=02
--2. Danh sách sinh viên có tuô?i l?n h?n 20, thông tin g?m: H? tên sinh viên, Tuô?i, H?c bô?ng (dùng hàm getdate() ?? l?y ngày tháng n?m hi?n t?i). G?i ý: Tuoi = YEAR(GETDATE()) – YEAR(NgaySinh)
select HoSV+' '+TenSV as hoten, YEAR(GETDATE()) - YEAR(NgaySinh) AS Tuoi,HocBong
from SINHVIEN 
where YEAR(GETDATE()) - YEAR(NgaySinh) >20
--3. Danh sách sinh viên có tuô?i t? 20 ?ê?n 25, thông tin g?m: H? tên sinh viên, Tuô?i, Tên khoa.
select ,YEAR(GETDATE()) - YEAR(NgaySinh) AS Tuoi,TenKhoa
from SINHVIEN,KHOA
where YEAR(GETDATE()) - YEAR(NgaySinh) between 20 and 25
--4. Danh sách sinh viên ??n ngày sinh nh?t (trùng ngày và tháng sinh v?i hi?n t?i)
select HoSV+' '+TenSV as hoten
from SINHVIEN
where month(NgaySinh)=month(GETDATE()) and day(NgaySinh)=day(GETDATE())
--5. Cho biê?t thông tin v? m??c h?c bô?ng c?a các sinh viên, g?m: Mã sinh viên, Phái, Mã khoa, M??c h?c bô?ng. Trong ?ó, m??c h?c bô?ng s? hi?n th? la? ‘H?c bô?ng cao’ nê?u giá tr? c?a h?c bô?ng l?n h?n 150,000 va? ng??c l?i hi?n th? la? ‘M??c trung bình.
select MaSV,HoSV,TenSV,Phai,MaKh,'Muc hoc bong'=
Case
when HocBong >150000 then N'muc hoc bong cao'
else N'muc hoc bong trung binh'
end
from SinhVien
--6. Danh sách sinh viên sinh va?o mùa xuân n?m 1990, g?m các thông tin: H? tên sinh viên, Phái (ghi rõ “Nam” ho?c “N?”), Nga?y sinh. G?i ý: Dùng hàm datepart(q, ngaysinh)
select HoSV+' '+TenSV as hoten,NgaySinh,Phai=
case 
when Phai <1 then N'Nam'
else N'Nu'
end
from SINHVIEN
where  datepart(q, NgaySinh)=1 and YEAR(NgaySinh)=1990
--7. Cho biê?t kê?t qu? ?i?m thi c?a các sinh viên, g?m các thông tin: H? tên sinh viên, Mã môn h?c, lâ?n thi, ?i?m, kê?t qu? (nê?u ?i?m nh? h?n 5 thì r?t ng??c l?i ?â?u).
select HoSV+' '+TenSV as hoten,MaMH,LanThi,Diem,'ketqua'=
case 
when Diem<5 then'ROT'
else 'DAU'
end
from SINHVIEN,KETQUA
--8. Cho bi?t s? l??ng sinh viên.
select COUNT(*) as sl_sinhvien
from SINHVIEN
--9. Cho bi?t s? l??ng sinh viên n?.
select COUNT(*) as sl_SinhVienNu
from SINHVIEN
where Phai = 1
--10. S? l??ng sinh viên c?a t?ng khoa.
select TenKhoa,COUNT(*) as sl_sinhvien
from SINHVIEN, KHOA
where MaKH=MaKhoa
group by TenKhoa
--11. Sô? l??ng sinh viên h?c t?ng môn.
select TenMH,COUNT(*) as sl_sinhvien
from MONHOC,SINHVIEN,KETQUA
where SINHVIEN.MaSV=KETQUA.MaSV and KETQUA.MaMH=MONHOC.MaMH
group by TenMH
--12. Sô? l??ng môn h?c ma? m?i sinh viên ?ã h?c.
select SINHVIEN.MaSV,HoSV,TenSV ,COUNT(*)as sl_monhoc
from SINHVIEN,KETQUA,MONHOC
where SINHVIEN.MaSV=KETQUA.MaSV and KETQUA.MaMH=MONHOC.MaMH
group by  HoSV,TenSV,SINHVIEN.MaSV
--13. H?c bô?ng cao nh?t c?a m?i khoa.
select MaKH,max(HocBong)
from SINHVIEN
group by MaKH
--14. Sô? l??ng sinh viên nam va? sinh viên n?? c?a m?i khoa.

--15. Sô? l??ng sinh viên theo t?ng ?? tuô?i.

--16. Sô? l??ng sinh viên ?â?u va? sô? l??ng sinh viên r?t c?a t?ng môn trong lâ?n thi 1.

--17. Cho biê?t n?m sinh na?o có t? 2 sinh viên ?ang theo h?c t?i tr???ng.

--18. Cho biê?t n?i na?o có h?n 2 sinh viên ?ang theo h?c t?i tr???ng.

--19. Cho biê?t môn na?o có trên 3 sinh viên d? thi.

--20. Cho biê?t sinh viên thi l?i trên 2 lâ?n.

--21. Cho biê?t sinh viên nam có ?i?m trung bình lâ?n 1 trên 7.0.

--22. Cho biê?t danh sách sinh viên r?t trên 2 môn ?? lâ?n thi 1.

--23. Cho biê?t khoa na?o có nhi?u h?n 2 sinh viên nam.

--24. Cho biê?t khoa có 2 sinh ??t h?c bô?ng t? 100.000 ?ê?n 200.000.

--25. Cho biê?t sinh viên nam h?c trên t? 3 môn tr?? lên.

--26. Cho biê?t sinh viên có ?i?m trung bình lâ?n 1 t? 7 tr?? lên nh?ng không có môn na?o d??i 5.

--27. Cho biê?t môn không có sinh viên r?t ?? lâ?n 1 (r??t là ?i?m <5).

--28. Cho biê?t sinh viên ??ng ký h?c h?n 3 môn ma? thi lâ?n 1 không b? r?t môn na?o.

--29. Cho biê?t sinh viên có n?i sinh cùng v?i H?i.

--30. Cho biê?t nh??ng sinh viên có h?c bô?ng l?n h?n t?t c? h?c bô?ng c?a sinh viên thu?c khoa anh v?n.

--31. Cho biê?t nh??ng sinh viên có h?c bô?ng l?n h?n b?t k? h?c bô?ng c?a sinh viên h?c khóa anh v?n.

--32. Cho biê?t sinh viên có ?i?m thi môn c? s?? d?? li?u lâ?n 2 l?n h?n t?t c? ?i?m thi lâ?n 1 môn c? s?? d?? li?u c?a nh??ng sinh viên khác.

--33. V?i m?i sinh viên cho biê?t ?i?m thi cao nh?t c?a môn t??ng ??ng.

--34. Cho biê?t môn na?o có nhi?u sinh viên h?c nh?t.

--35. Cho biê?t nh??ng khoa có ?ông sinh viên nam h?c nh?t.

--36. Cho biê?t khoa na?o có ?ông sinh viên nhâ?n h?c bô?ng nh?t va? khoa na?o khoa na?o có ít sinh viên nhâ?n h?c bô?ng nh?t.

--37. Cho biê?t môn na?o có nhi?u sinh viên r?t lâ?n 1 nhi?u nh?t.

--38. Cho biê?t 3 sinh viên có h?c nhi?u môn nh?t.