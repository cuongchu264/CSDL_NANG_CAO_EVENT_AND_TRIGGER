CREATE DATABASE ORDER_PRODUCT
GO

USE [ORDER_PRODUCT]
GO

CREATE TABLE CUSTOMER
(
	CustomerId int PRIMARY KEY,
	CustomerName nvarchar(50),
	Email nvarchar(MAX),
	Phone nvarchar(50),
	Address nvarchar(max)
)
GO

CREATE TABLE PAYMENT
(
	PaymentId int Primary key,
	PaymentName nvarchar(50),
	PaymentFee float
)
GO

CREATE TABLE ORDER_PRODUCT
(
	OrderId int primary key,
	OrderDay date,
	OrderStatus nvarchar(50),
	OrderSum float,
	CustomerId int,
	PaymentId int,
	CONSTRAINT FK_CustomerId FOREIGN KEY (CustomerId) REFERENCES CUSTOMER(CustomerId),
	CONSTRAINT FK_PaymentId FOREIGN KEY (PaymentId) REFERENCES PAYMENT(PaymentId),
)
GO
CREATE TABLE PRODUCT 
(
	ProductId int primary key,
	ProductName nvarchar(50),
	ProductDescription nvarchar(50),
	ProductPrice float,
	ProductQuantity int,
)
GO

CREATE TABLE ORDER_DETAIL
(
	OrderDetailId int primary key,
	Quantity int,
	ProductPrice float,
	Total float,
	ProductId int,
	OrderId int,
	CONSTRAINT FK_ProductId FOREIGN KEY (ProductId) REFERENCES PRODUCT(ProductId),
	CONSTRAINT FK_OrderId FOREIGN KEY (OrderId) REFERENCES ORDER_PRODUCT(OrderId),
)
GO

CREATE TABLE MESS (
    id INT identity(1,1) PRIMARY KEY,
    message VARCHAR(255) NOT NULL,
    created_at datetime DEFAULT (getdate()) NOT NULL
);

insert into CUSTOMER(CustomerId,CustomerName, Email, Phone, Address)
values(1,'Nguyen Van A', 'nguyenvana@gmail.com', '0905123456', 'Da Nang')
insert into CUSTOMER(CustomerId,CustomerName, Email, Phone, Address)
values(2,'Nguyen Van B', 'nguyenvanb@gmail.com', '0905123457', 'Ha Noi')
insert into CUSTOMER(CustomerId,CustomerName, Email, Phone, Address)
values(3,'Nguyen Van C', 'nguyenvanc@gmail.com', '0905123458', 'Ho Chi Minh')
insert into CUSTOMER(CustomerId,CustomerName, Email, Phone, Address)
values(4, 'Nguyen Van D', 'nguyenvanc@gmail.com', '0905123458', 'Ho Chi Minh')
SELECT * FROM CUSTOMER

insert into PAYMENT(PaymentId,PaymentName, PaymentFee)
values(1, 'COD', 30000)
insert into PAYMENT(PaymentId, PaymentName, PaymentFee)
values(2, 'BANK', 1000)
SELECT * FROM PAYMENT

insert into PRODUCT(ProductId, ProductName, ProductDescription, ProductPrice, ProductQuantity)
values(1, 'san pham 1', 'mo ta san pham 1', 20000, 25)
insert into PRODUCT(ProductId, ProductName, ProductDescription, ProductPrice, ProductQuantity)
values(2, 'san pham 2', 'mo ta san pham 2', 30000, 20)
insert into PRODUCT(ProductId, ProductName, ProductDescription, ProductPrice, ProductQuantity)
values(3, 'san pham 3', 'mo ta san pham 3', 40000, 15)
select * from PRODUCT

insert into ORDER_PRODUCT(OrderId ,OrderDay, OrderStatus, OrderSum, CustomerId, PaymentId)
values(1, '2022-03-07', 'Pending', 40000, 1 , 2)
insert into ORDER_PRODUCT(OrderId ,OrderDay, OrderStatus, OrderSum, CustomerId, PaymentId)
values(2, '2022-03-07', 'Pending', 60000, 2 , 1)
insert into ORDER_PRODUCT(OrderId ,OrderDay, OrderStatus, OrderSum, CustomerId, PaymentId)
values(3, '2022-03-07', 'Pending', 80000, 3 , 1)
SELECT * FROM ORDER_PRODUCT

insert into ORDER_DETAIL(OrderDetailId, Quantity, ProductPrice, Total, ProductId, OrderId)
values(1, 2, 20000, 40000, 1, 1)
insert into ORDER_DETAIL(OrderDetailId, Quantity, ProductPrice, Total, ProductId, OrderId)
values(2, 2, 30000, 60000, 2, 2)
insert into ORDER_DETAIL(OrderDetailId, Quantity, ProductPrice, Total, ProductId, OrderId)
values(3, 2, 40000, 80000, 3, 3)
insert into ORDER_DETAIL(OrderDetailId, Quantity, ProductPrice, Total, ProductId, OrderId)
values(4, 10, 40000, 80000, 1, 3)
insert into ORDER_DETAIL(OrderDetailId, Quantity, ProductPrice, Total, ProductId, OrderId)
values(5, 10, 40000, 80000, 1, 3)
select * from ORDER_DETAIL

--1)trigger insert--Chu Manh Cuong
create trigger giamsoluong_insert
on ORDER_DETAIL
for insert
as
update PRODUCT
set PRODUCT.ProductQuantity=PRODUCT.ProductQuantity
-inserted.Quantity
from PRODUCT inner join inserted
on PRODUCT.ProductId=inserted.ProductId

SELECT * FROM PRODUCT

--2)event
SET GLOBAL event_scheduler = ON;

SHOW PROCESSLIST;
--Su kien thuc thi sau 1 minute
CREATE EVENT test_event_02
ON SCHEDULE AT CURRENT_TIMESTAMP + INTERVAL 1 MINUTE
ON COMPLETION PRESERVE
DO
   INSERT INTO MESS(message)
   VALUES('Test MySQL Event 2');
