create database ProductManagement;
use ProductManagement;

create table [Admin] (
	username varchar(30) primary key,
	[password] varchar(30)
)
insert into [Admin](username, [password]) values('admin', '123')

create table Category (
	id int not null identity(1,1) primary key, 
	name nvarchar(50) unique,
	description text,
	disable bit default 0
)

create table Brand (
	id int not null identity(1,1) primary key, 
	name nvarchar(50) unique, 
	logo varchar(50),
	manufacturer nvarchar(50),
	description text,
	disable bit default 0
)

create table Product (
	id int not null identity(1,1) primary key,
	name nvarchar(50) unique,
	description text,
	price int, 
	quantity int,
	image varchar(50),
	date_added datetime DEFAULT CURRENT_TIMESTAMP, 
	category_id int,
	brand_id int,
	disable bit default 0,
	foreign key (category_id) references Category(id),
	foreign key (brand_id) references Brand(id)
)

create table [User] (
	id int not null identity(1,1) primary key,
	username varchar(30) unique,
	[password] varchar(30),
	name nvarchar(50),
	gender bit,
	phone varchar(20),
	email varchar(50),
	[address] nvarchar(50)
)

create table [Order] (
	id int not null identity(1,1) primary key,
	created_time DateTime DEFAULT CURRENT_TIMESTAMP,
	payment_time DateTime,
	amount int,
	[user_id] int, 	
	foreign key ([user_id]) references [User](id)	
)

create table OrderDetail (
	id int not null identity(1,1) primary key,
	[status] varchar(50),
	product_id int, 
	order_id int, 
	purchased_quantity int,
	foreign key (product_id) references Product(id),
	foreign key (order_id) references [Order](id),
)

insert into Category(name, description) values('danh mục 1', 'mô tả')

insert into Brand (name, manufacturer, description) values('thương hiệu 1', 'made in china', 'mô tả')

insert into Product(name, price, quantity, description, date_added, category_id, brand_id)
values('sản phẩm 1', 100000, 50, 'sản phẩm chất lượnng', '2020/12/27 12:30:00', 1, 1)
, ('sản phẩm 2', 200000, 30, 'sản phẩm chất lượnng', '2020/12/27 12:15:00', 1, 1)					   

insert into [User](username, password, name, gender, phone, email, address)
values('customer', '123', 'John Doe', 1, '098 765 4321', 'johndoe@customer.com', 'Ha Noi')

insert into [Order](created_time, payment_time, amount, [user_id])
values ('12/26/2020 15:00:00', '01/01/2021 15:28:00', 2200000, 1)
, ('01/01/2021 17:00:00', '01/01/2021 19:28:00', 100000, 1)							 

insert into OrderDetail(status, product_id, order_id, purchased_quantity)
values('success transaction', 1, 1, 2), ('success transaction', 2, 1, 10)
, ('success transaction', 1, 2, 1)							 
