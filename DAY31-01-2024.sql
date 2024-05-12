create database salemanager
use salemanager
create table CUSTOMER
(
	CustomerID int constraint PK_CUSTOMER primary key,
	firstname nvarchar(10),
	lastname nvarchar(20),
	city nvarchar(40),
	phone char(10)
)
create table CUSTOMERORDER
(
	OrderId int constraint PK_CUSTOMERORDER primary key,
	CustomerId int,
	OrderDate date,
	TotalAmount int,
)
create table ORDERITEM
(
	OderItemId int constraint PK_ORDERITEM primary key,
	OrderId int,
	ProductId int,
	UnitPrice decimal(12),
	Quantity int,
)
create table PRODUCT
(
	ProductId int constraint PK_PRODUCT primary key,
	ProductName nvarchar,
	SupplierId int,
	UnitPrice int,
	Unit nvarchar,
	IsDiscontinued bit
)
create table SUPPLIER
(
	SupplierId int constraint PK_SUPPLIER primary key,
	CompanyName nvarchar(40),
	ContactFirstName nvarchar(10),
	ContactLastName nvarchar(20),
	CompanyAddress nvarchar(40),
	Phone char(10)
)


alter table CUSTOMER ADD Female bit

alter table CUSTOMERORDER add 
	constraint FK__CUSTOMERORDER_CUSTOMER foreign key (CustomerId) references CUSTOMER(CustomerId)
alter table ORDERITEM add
	constraint FK_ORDERITEM_CUSTOMERORDER foreign key (OrderId) references CUSTOMERORDER (OrderId)
alter table ORDERITEM add	
	constraint FK_ORDERITEM_PRODUCT foreign key (ProductId) references PRODUCT (ProductId)
alter table PRODUCT  add
	constraint FK_PRODUCT_SUPPLIER foreign key (SupplierId) references SUPPLIER (SupplierId)
alter table CUSTOMER alter COLUMN CustomerID char(5)
alter table CUSTOMERORDER alter column OrderId char(5)
alter table  ORDERITEM alter column OderItemId char(5)
alter table PRODUCT alter column ProductId char(5) 
alter table SUPPLIER alter column SupplierId char(5)






	

	


