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
	description text
)

create table Brand (
	id int not null identity(1,1) primary key, 
	name nvarchar(50) unique, 
	logo varchar(50),
	manufacturer nvarchar(50),
	description text
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
	created_day DateTime DEFAULT CURRENT_TIMESTAMP,
	payment_day DateTime,
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
