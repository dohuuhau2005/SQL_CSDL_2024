USE MASTER
IF EXISTS(SELECT * FROM SYSDATABASES WHERE NAME='QLDA')
	DROP DATABASE QLDA

CREATE DATABASE QLDA

USE QLDA

CREATE TABLE NHANVIEN
(
  HONV CHAR (10),
  TENLOT NVARCHAR (10),
  TENNV NVARCHAR (10),
  MANV CHAR(10) PRIMARY KEY,
  NGSINH DATE,
  DCHI NVARCHAR(30),
  PHAI CHAR(3),
  LUONG FLOAT,
  MA_NQL CHAR(20),
  PHG CHAR(1),
)
CREATE TABLE PHONGBAN
(
  TENPHG NVARCHAR(20),
  MAPHG CHAR(1) PRIMARY KEY,
  TRPHG CHAR(20),
  NG_NHANCHUC DATE,
)
CREATE TABLE DIADIEM_PHG
(
  MAPHG CHAR(1) REFERENCES PHONGBAN(MAPHG),
  DIADIEM NVARCHAR(20),
  PRIMARY KEY(MAPHG, DIADIEM),
)
CREATE TABLE THANNHAN
(
  MANV CHAR(10),
  TENTN CHAR(10),
  PHAI CHAR(3),
  NGSINH DATE,
  QUANHE NVARCHAR(10),
  PRIMARY KEY(MANV, TENTN),
)
CREATE TABLE DEAN
(
  TENDA NVARCHAR(20),
  MADA CHAR(3) PRIMARY KEY,
  DDIEM_DA NVARCHAR(10),
  PHONG CHAR(1),
)
CREATE TABLE PHANCONG
(
  MANVIEN CHAR(10) REFERENCES NHANVIEN(MANV),
  SODA CHAR(3),
  THOIGIAN DECIMAL(4,2),
  PRIMARY KEY(MANVIEN, SODA),
)

INSERT INTO NHANVIEN
VALUES('Dinh','Ba','Tien','123456789','1955-01-09','731 Tran Hung Dao, Q1, TPHCM','Nam',30000,'333445555',5),
  	  ('Nguyen','Thanh','Tung','333445555','1945-12-08','638 Nguyen Van Cu, Q5, TPHCM','Nam',40000,'888665555',5),
	  ('Bui','Thuy','Vu','999887777','1958-07-19','332 Nguyen Thai Hoc, Q1, TPHCM','Nam',25000,'987654321',4),
	  ('Le','Thi','Nhan','987654321','1931-06-20','291 Ho Van Hue, QPN, TPHCM','Nu',43000,'888665555',4),
	  ('Nguyen','Manh','Hung','666884444','1952-09-15','975 Ba Tri, Vung Tau','Nam',38000,'333445555',5),
	  ('Tran','Thanh','Tam','453453453','1962-07-31','543 Mai Thi Luu, Q1, TPHCM','Nam',25000,'987654321',5),
	  ('Tran','Hong','Quan','987987987','1959-03-29','980 Le Hong Phong, Q10, TPHCM','Nam',25000,'',4),
	  ('Vuong', 'Ngoc', 'Quyen', '888665555', '1927-10-10','450 Trung Vuong, Ha Noi', 'Nu',55000,NULL,1)
INSERT INTO PHONGBAN
VALUES ('Nghien cuu',5,'333445555','1978-05-22'),
	   ('Dieu hanh',4,'987987987','1985-01-01'),
	   ('Quan ly',1,'888665555','1971-06-19')

INSERT INTO DIADIEM_PHG
VALUES(1,'TPHCM'),
	  (4,'HA NOI'),
	  (5,'VUNG TAU'),
	  (5,'NHA TRANG'),
	  (5,'TPHCM')

INSERT INTO THANNHAN
VALUES('333445555','Quang','Nu','1976-04-05','Con gai'),
	  ('333445555','Khang','Nam','1973-10-25','Con Trai'),
	  ('333445555','Duong','Nu','1948-05-03','Vo chong'),
	  ('987654321','Dang','Nam','1932-02-28','Vo chong'),
	  ('123456789','Duy','Nam','1978-01-01','Con trai'),
	  ('123456789','Chau','Nu','1978-12-31','Con gai'),
	  ('123456789','Phuong','Nu','1957-05-05','Vo chong')

INSERT INTO DEAN
VALUES('San pham X',1,'VUNG TAU',5),
	  ('San pham Y',2,'NHA TRANG',5),
	  ('San pham Z',3,'TPHCM',5),
	  ('Tin hoc hoa',10,'HA NOI',4),
	  ('Cap quang',20,'TPHCM',1),
	  ('Dao tao',30,'HA NOI',4)

INSERT INTO PHANCONG
VALUES('123456789',1,32.5),
	  ('123456789',2,7.5),
	  ('666884444',3,40),
	  ('453453453',1,20),
	  ('453453453',2,10),
	  ('333445555',3,10),
	  ('333445555',10,10),
	  ('333445555',20,10),
	  ('999887777',30,30),
	  ('999887777',10,10),
	  ('987987987',10,35),
	  ('987987987',30,5),
	  ('987654321',30,20),
	  ('987654321',20,15),
	  ('888665555',20,0)
--1. Danh sách đề án trong công ty.
select TENDA,MADA
from DEAN
--2. Danh sách nhân viên nữ trong công ty.
select HONV+' '+TENLOT+' '+TENNV as 'Ho va Ten'
from NHANVIEN
where PHAI = 'Nu'
--3. Danh sách những đề án có người tham gia có họ ‘Đinh’.
select TENDA, MADA, HONV
from DEAN,NHANVIEN,PHANCONG
where  SODA=DEAN.MADA and PHANCONG.MANVIEN=NHANVIEN.MANV and HONV= 'Dinh'
--4. Danh sách những đề án có trưởng phòng chủ trì đề án họ ‘Đinh’.
select distinct MADA,TENDA
from DEAN,PHONGBAN,NHANVIEN,PHANCONG
where PHONGBAN.TRPHG=NHANVIEN.MANV and MANVIEN=MANV and PHANCONG.SODA=DEAN.MADA and HONV='Dinh'and dean.phong = PHONGBAN.MAPHG


--5. Danh sách những nhân viên có trưởng phòng họ ‘Phạm’.**
select  HONV + TENLOT +'   '+ TENNV as 'h? và tên',NGSINH as 'ngày sinh',DCHI as ' ??a ch?',luong as 'l??ng',ma_nql as 'ng??i qu?n lý',PHG as 'mã phòng',phai as 'phái'
from NHANVIEN
where ma_nql in (select MANV
from NHANVIEN
where HONV ='Pham')
--6. Danh sách những nhân viên thuộc phòng ‘Quản lý’.
select MANV,HONV+''+TENLOT+' '+TENNV as 'Ho va Ten'
from NHANVIEN
where PHG=1
--7. Cho biết họ tên người quản lý trực tiếp nhân viên tên ‘Hằng’.**
select  MANV,HONV+''+TENLOT+' '+TENNV as 'Ho va Ten'
from NHANVIEN
where MANV in (select MA_NQL
from NHANVIEN
where HONV='Hằng')
--8. In ra danh sách nhân viên có họ bắt đầu bằng chữ ‘N’, thông tin gồm: Mã số nhân viên, họ và tên, giới tính và tuổi.
select MANV,HONV+''+TENLOT+' '+TENNV as 'Ho va Ten',PHAI,DATEDIFF(YEAR, NGSINH, GETDATE()) AS Age
from NHANVIEN
where HONV like 'N%'
--9. Cho biết những nhân viên có cùng tên với người than làm việc trong công ty, thông tin gồm: mã số nhân viên, họ và tên, giới tính.
select nhanvien.MANV,HONV+''+TENLOT+' '+TENNV as 'Ho va Ten',nhanvien.PHAI
from NHANVIEN,THANNHAN
where NHANVIEN.TENNV=THANNHAN.TENTN
--10. Cho biết mã số nhân viên, họ tên của các nhân viên và tên các phòng ban mà họ phụ trách (nếu có).
select distinct MANV,HONV+''+TENLOT+' '+TENNV as 'Ho va Ten',TENPHG
from NHANVIEN
left join PHONGBAN on phg=MAPHG

--11. Danh sách những nhân viên có thân nhân sinh năm 1970 đến 1980, thông tin gồm mã số nhân viên và họ tên.
select nhanvien.MANV,HONV+''+TENLOT+' '+TENNV as 'Ho va Ten'
from NHANVIEN,THANNHAN
where YEAR(THANNHAN.NGSINH)  between 1970 and 1980

--12. Danh sách những nhân viên có thân nhân làm trong công ty là con và sắp xếp thân nhân theo năm sinh giảm dần.

select YEAR(THANNHAN.NGSINH) as nam,nhanvien.MANV,HONV+''+TENLOT+' '+TENNV as 'Ho va Ten'
from THANNHAN
	JOIN NHANVIEN ON THANNHAN.MANV = NHANVIEN.MANV
	
where QUANHE like 'Con%'
order by nam desc
--13. Danh sách nhân viên có tham gia thực hiện đề án, thông tin gồm mã số nhân viên, họ và tên, tên phòng làm việc và sắp xếp theo tên phòng ban tăng dần.
select distinct nhanvien.MANV,HONV+''+TENLOT+' '+TENNV as 'Ho va Ten',TENPHG,LEN(TENPHG)as so_ky_tu
from PHANCONG,DEAN,NHANVIEN,PHONGBAN
where PHANCONG.SODA=DEAN.MADA and DEAN.PHONG=NHANVIEN.PHG and PHONGBAN.MAPHG=NHANVIEN.PHG 
order by so_ky_tu asc
--14. Danh sách nhân viên tham gia đề án có địa điểm ở ‘HCM’.
select MANV,TENNV
from NHANVIEN,DEAN,PHANCONG
where NHANVIEN.MANV=PHANCONG.MANVIEN and PHANCONG.SODA=DEAN.MADA and DEAN.DDIEM_DA='TPHCM'
--15. Danh sách những nhân viên thực hiện đề án có số giờ làm trên 20 giờ và sắp xếp thứ tự số giờ làm tăng dần.
select nhanvien.MANV,HONV+''+TENLOT+' '+TENNV as 'Ho va Ten',THOIGIAN
from PHANCONG,NHANVIEN
where PHANCONG.MANVIEN=NHANVIEN.MANV and PHANCONG.THOIGIAN >20
order by THOIGIAN asc
--16. Cho biết số lượng đề án của công ty.
select COUNT(dean.MADA)
from DEAN


--17. Cho biết số lượng đề án do phòng 'Nghiên Cứu' chủ trì.
select dean.MADA,dean.TENDA,COUNT(dean.MADA) as so_luong_de_an
from DEAN,PHONGBAN
where PHONGBAN.TENPHG='Nghien cuu'and DEAN.PHONG=PHONGBAN.MAPHG
group by MADA,TENDA
--18. Cho biết mức lương trung bình của các nữ nhân viên.
select AVG(LUONG) as Luong_trung_binh
from NHANVIEN
where PHAI='Nu'
--19. Cho biết số thân nhân của nhân viên 'Đinh Bá Tiến'.
select COUNT(*) ,QUANHE
from THANNHAN
	join NHANVIEN on TENNV='Tien' and HONV='Dinh'and TENLOT='Ba'and NHANVIEN.MANV=THANNHAN.MANV
group by QUANHE
--20. Cho biết có bao nhiêu người thực hiện đề án có mã số 30.
select COUNT(*)
from NHANVIEN,DEAN
where DEAN.PHONG=NHANVIEN.PHG and MADA=30
--21. Cho biết số lượng nhân viên theo từng độ tuổi.
select count(*),DATEDIFF(YEAR, NGSINH, GETDATE()) AS Age
from NHANVIEN
Group by NGSINH
--22*. Cho biết danh sách trưởng phòng (mã số nhân viên, họ và tên, giới tính, tuổi) và số lượng nhân viên trong phòng tương ứng.

select TRPHG as tp,tp.HONV,tp.TENNV,
(select count(*)
from NHANVIEN
where NHANVIEN.PHG=MAPHG) [ Số lượng nhân viên]
from NHANVIEN tp,PHONGBAN
WHERE MANV = TRPHG






--23. Với mỗi đề án, liệt kê tên đề án và tổng số giờ làm việc của tất cả các nhân viên tham dự đề án đó.
select TENDA,MADA , sum(thoigian) AS tong_so_gio
from DEAN,PHANCONG,NHANVIEN
where DEAN.MADA=PHANCONG.SODA and PHANCONG.MANVIEN=NHANVIEN.MANV
group by TENDA,MADA
--24. Với mỗi nhân viên, cho biết họ và tên nhân viên và số lượng thân nhân của nhân viên đó (nếu có).
select nhanvien.MANV,HONV+''+TENLOT+' '+TENNV as 'Ho va Ten',COUNT(QUANHE)as so_than_nhan
from NHANVIEN
left join THANNHAN  on NHANVIEN.MANV=THANNHAN.MANV
group by nhanvien.MANV,HONV,TENLOT,TENNV
--25. Với mỗi nhân viên, cho biết họ tên của nhân viên và số lượng đề án mà nhân viên đó đã tham gia.
select nhanvien.MANV,HONV+''+TENLOT+' '+TENNV as 'Ho va Ten',COUNT(TENDA)
from NHANVIEN,PHANCONG,DEAN
where NHANVIEN.MANV=PHANCONG.MANVIEN and DEAN.MADA=PHANCONG.SODA
group by nhanvien.MANV,HONV,TENLOT,TENNV
--26. Với mỗi nhân viên, cho biết số lượng nhân viên mà nhân viên đó quản lý trực tiếp.
SELECT NV1.MANV, NV1.HONV, NV1.TENLOT, NV1.TENNV, COUNT(NV2.MANV) AS SoLuongNhanVienQuanLy
FROM NHANVIEN NV1
LEFT JOIN NHANVIEN NV2 ON NV1.MANV = NV2.MA_NQL
GROUP BY NV1.MANV, NV1.HONV, NV1.TENLOT, NV1.TENNV
ORDER BY NV1.MANV;





--27. Với mỗi phòng ban, liệt kê tên phòng ban và mức lương trung bình của những nhân viên làm việc cho phòng ban đó.
select TENPHG,AVG( LUONG )as Luong_Trung_Binh
from NHANVIEN,PHONGBAN
where NHANVIEN.PHG=PHONGBAN.MAPHG
group by TENPHG
--28. Với các phòng ban có mức lương trung bình từ 30,000, liệt kê tên phòng ban và số lượng nhân viên của phòng ban đó.
select TENPHG,COUNT(NHANVIEN.MANV)as so_Luong_nhan_vien
from NHANVIEN,PHONGBAN
where PHONGBAN.MAPHG=NHANVIEN.PHG 
group by TENPHG
having   AVG( LUONG )>=30000
--29. Với mỗi phòng ban, cho biết tên phòng ban và số lượng đề án mà phòng ban đó chủ trì (nếu có).
select TENPHG,COUNT(MADA)as So_Luong_De_An
from PHONGBAN
left join DEAN on PHONGBAN.MAPHG=DEAN.PHONG
group by TENPHG
--30. Với mỗi phòng ban, cho biết tên phòng ban, họ tên người trưởng phòng và số lượng đề án mà phòng ban đó chủ trì.
select TENPHG,HONV+''+TENLOT+' '+TENNV as 'Ho va Ten',COUNT(MADA)as So_Luong_De_An
from PHONGBAN,NHANVIEN,DEAN
where PHONGBAN.MAPHG=DEAN.PHONG and NHANVIEN.MANV=PHONGBAN.TRPHG
group by TENPHG,HONV,TENLOT,TENNV
--31. Với mỗi phòng ban có mức lương trung bình lớn hơn 40,000, cho biết tên phòng ban và số lượng đề án mà phòng ban đó chủ trì.
select TENPHG,count(MADA)as So_Luong_De_An
from PHONGBAN,DEAN,NHANVIEN	
where PHONGBAN.MAPHG=DEAN.PHONG and NHANVIEN.MA_NQL=PHONGBAN.TRPHG
group by TENPHG
having AVG(luong)>40000
--32. Cho biết số đề án được thực hiện tại từng địa điểm.
select DEAN.DDIEM_DA,COUNT(MADA)as So_Luong_De_An
from DEAN
group by DEAN.DDIEM_DA
--33. Với mỗi đề án, cho biết tên đề án và có bao nhiêu người thực hiện đề án này.
select TENDA,COUNT(PHANCONG.MANVIEN)as So_Nguoi_Thuc_hien,MADA
from DEAN 
left join  PHANCONG on  DEAN.MADA=PHANCONG.SODA
group by TENDA,MADA

insert into DEAN values ('san pham k',8,'k l',5)--check
--34. Cho biết danh sách những nhân viên chưa được phân công thực hiện đề án nào.
select MANV,HONV+''+TENLOT+' '+TENNV as 'Ho va Ten'
from NHANVIEN
where MANV not in(select distinct MANV 
from NHANVIEN, PHANCONG
where NHANVIEN.MANV=PHANCONG.MANVIEN)

insert into NHANVIEN values ('k','k','k','k','1998-05-05','k','nam',3000,'k',6)
insert into NHANVIEN values ('k','k','k','n','1998-05-05','k','nam',3000,'k',6)


--35. Cho biết những đề án (mã đề án, tên đề án, địa điểm đề án) chưa được phân công thực hiện
select MADA,TENDA,DEAN.DDIEM_DA
from DEAN
where MADA not in (select MADA
from DEAN,PHANCONG
where MADA=PHANCONG.SODA)
--36. Cho biết họ tên trưởng phòng chưa thực hiện đề án nào.
select HONV+''+TENLOT+' '+TENNV as 'Ho va Ten'
from	NHANVIEN,PHONGBAN
where NHANVIEN.MANV=PHONGBAN.TRPHG and MANV not in (select PHANCONG.MANVIEN
from PHANCONG)

insert into PHONGBAN values ('k',6,'n','1998-05-05')
update NHANVIEN
set TENNV='h'
where MANV='n'

--37. Cho biết những nhân viên không có thân nhân làm việc trong công ty.
select MANV, HONV+''+TENLOT+' '+TENNV as 'Ho va Ten'
from NHANVIEN
where MANV not in (select NHANVIEN.MANV
from NHANVIEN,THANNHAN
where NHANVIEN.MANV=THANNHAN.MANV)
-- Có thể làm theo cách count()=0 để nhanh
--38. Danh sách những nhân viên (họ tên nhân viên) thực hiện tất cả các đề án của công ty
select NHANVIEN.MANV, HONV+''+TENLOT+' '+TENNV as 'Ho va Ten'
from DEAN,NHANVIEN,PHANCONG
where DEAN.MADA=PHANCONG.SODA and NHANVIEN.MANV=PHANCONG.MANVIEN
group by NHANVIEN.MANV,HONV,TENLOT,TENNV
having count(DEAN.MADA)=(select COUNT(DEAN.MADA)
from DEAN)

insert into PHANCONG values ('333445555',8,10)
select * from phancong
select * from dean

--39. Danh sách những nhân viên (họ tên nhân viên) được phân công tất cả đề án do phòng số 4 chủ trì.
select NHANVIEN.MANV,HONV+''+TENLOT+' '+TENNV as 'Ho va Ten'
from DEAN,NHANVIEN,PHANCONG
where DEAN.MADA=PHANCONG.SODA and NHANVIEN.MANV=PHANCONG.MANVIEN  and MADA in (select MADA
from DEAN
where DEAN.PHONG=4)

group by NHANVIEN.MANV,HONV,TENLOT,TENNV
having count(DEAN.MADA)=(select COUNT(DEAN.MADA)
from DEAN
where DEAN.PHONG=4)





--40. Tìm những nhân viên (họ tên nhân viên) được phân công tất cả đề án mà nhân viên 'Đinh Bá Tiến' thực hiện.dean=dean(dinh)
select NHANVIEN.MANV,HONV+''+TENLOT+' '+TENNV as 'Ho va Ten'
from NHANVIEN,PHANCONG
where NHANVIEN.MANV=PHANCONG.MANVIEN and PHANCONG.SODA in  (select PHANCONG.SODA
from PHANCONG,NHANVIEN
where PHANCONG.MANVIEN=NHANVIEN.MANV and HONV='Dinh' and TENLOT='Ba' and TENNV ='Tien') 
group by NHANVIEN.MANV,HONV,TENLOT,TENNV
having count(PHANCONG.SODA)=2

insert into PHANCONG values ('k',1,2)
insert into PHANCONG values ('k',8,2)



--41. Cho biết danh sách nhân viên tham gia vào tất cả các đề án ở TP HCM (dean nv= da tphcm)
select NHANVIEN.MANV,HONV+''+TENLOT+' '+TENNV as 'Ho va Ten'
from DEAN,PHANCONG,NHANVIEN
where DEAN.MADA=PHANCONG.SODA and PHANCONG.MANVIEN=NHANVIEN.MANV  and MADA in (select MADA
from DEAN
where DEAN.DDIEM_DA='TPHCM')
group by NHANVIEN.MANV,HONV,TENLOT,TENNV
having COUNT(PHANCONG.SODA)=(select COUNT(DEAN.MADA)
from DEAN
where DEAN.DDIEM_DA='TPHCM' )

insert into PHANCONG values ('888665555',3,0)
--42. Cho biết phòng ban chủ trì tất cả các đề án ở TP HCM
select MAPHG, TENPHG
from PHONGBAN
left join DEAN on DEAN.DDIEM_DA='TPHCM'
where PHONGBAN.MAPHG=DEAN.PHONG and MADA in (select MADA
from DEAN
where DEAN.DDIEM_DA='TPHCM')
group by MAPHG, TENPHG
having COUNT(DEAN.MADA)=(select COUNT(DEAN.MADA)
from DEAN
where DEAN.DDIEM_DA='TPHCM' )
 
 update DEAN 
 set PHONG=1
 where MADA=3
