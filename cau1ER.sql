create database QuanLyDeAn
use QuanLyDeAn
CREATE TABLE Phong_Ban
(
  MaPHG char NOT NULL,
  TenPhg Nvarchar NOT NULL,
  MaNV char NOT NULL,
  PRIMARY KEY (MaPHG),
  
);

CREATE TABLE NhanVien
(
  Hoten INT NOT NULL,
  GioiTinh bit NOT NULL,
  NgaySinh Date NOT NULL,
  Luong INT NOT NULL,
  MaNV char NOT NULL,
  Diachi Nvarchar NOT NULL,
  MaPHG char NOT NULL,
  QuanLy_MaNV char,
  PRIMARY KEY (MaNV),
  constraint FK_Nhanvien_Phongban FOREIGN KEY (MaPHG) REFERENCES Phong_Ban(MaPHG),
  constraint FK_QuanLy_Nhanvien FOREIGN KEY (QuanLy_MaNV) REFERENCES NhanVien(MaNV)
);
ALTER TABLE  Phong_Ban
ADD CONSTRAINT FK_Phong_Ban_NhanVien
FOREIGN KEY (MaNV)
REFERENCES NhanVien(MaNV)



CREATE TABLE DiadiemPhg
(
  TenDD Nvarchar NOT NULL,
  MaDD char NOT NULL,
  MaPHG char NOT NULL,
  PRIMARY KEY (MaDD),
  constraint FK_diadiemPhg_PhongBan FOREIGN KEY (MaPHG) REFERENCES Phong_Ban(MaPHG)
);

CREATE TABLE Dean
(
  DiadiemDA Nvarchar NOT NULL,
  MaDa char NOT NULL,
  TenDa Nvarchar NOT NULL,
  MaPHG char NOT NULL,
  PRIMARY KEY (MaDa),
  constraint FK_Dean_PhongBan FOREIGN KEY (MaPHG) REFERENCES Phong_Ban(MaPHG)
);

CREATE TABLE ThanNhan
(
  HoTenTN Nvarchar NOT NULL,
  Ngaysinh INT NOT NULL,
  Gioitinh INT NOT NULL,
  MoiQuanHe Nvarchar NOT NULL,
  MaNV char NOT NULL,
  PRIMARY KEY (HoTenTN, MaNV),
  constraint FK_ThanNhan_NhanVien FOREIGN KEY (MaNV) REFERENCES NhanVien(MaNV)
);

CREATE TABLE phancong
(
  SoGio INT NOT NULL,
  MaDa char NOT NULL,
  MaNV char NOT NULL,
  PRIMARY KEY (MaDa, MaNV),
  constraint FK_phancong_Dean FOREIGN KEY (MaDa) REFERENCES Dean(MaDa),
  constraint FK_phancong_NhanVien FOREIGN KEY (MaNV) REFERENCES NhanVien(MaNV)
);