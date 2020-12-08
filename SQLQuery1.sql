create database ProductManagement
use ProductManagement

drop database productmanagement

create table Category (
	id int not null identity(1,1) primary key, 
	name nvarchar(30)
)

create table Brand (
	id int not null identity(1,1) primary key, 
	name nvarchar(30), 
	logo varchar(50),
	manufacturer nvarchar(30)
)

create table Product (
	id int not null identity(1,1) primary key,
	name nvarchar(30),
	description nvarchar(255),
	price float, quantity int,
	image varchar(50), 
	category_id int,
	brand_id int,
	foreign key (category_id) references Category(id),
	foreign key (brand_id) references Brand(id)
)

create table [Order] (
	id int not null identity(1,1) primary key,
	created_day DateTime,
	total_price float
)

create table [User] (
	id int not null identity(1,1) primary key,
	username varchar(20),
	[password] varchar(20),
	name nvarchar(20),
	phone varchar(20),
	email varchar(20),
	[address] nvarchar(50),
	role int
)

create table OrderDetail (
	id int not null identity(1,1) primary key,
	[user_id] int, 
	product_id int, 
	order_id int, 
	purchased_quantity int,
	foreign key (product_id) references Product(id),
	foreign key (order_id) references [Order](id),
	foreign key ([user_id]) references [User](id)
)

alter table Brand add primary key (id)

drop table [User]

select * from [User]