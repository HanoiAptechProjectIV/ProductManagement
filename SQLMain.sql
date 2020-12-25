create database ProductManagement;
use ProductManagement;


create table Category (
	id int not null identity(1,1) primary key, 
	name nvarchar(50),
	description text
)

create table Brand (
	id int not null identity(1,1) primary key, 
	name nvarchar(50), 
	logo varchar(50),
	manufacturer nvarchar(50),
	description text
)

create table Product (
	id int not null identity(1,1) primary key,
	name nvarchar(50),
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
	username varchar(30),
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
	amount int,
	[user_id] int, 	
	foreign key ([user_id]) references [User](id)	
)

create table OrderDetail (
	id int not null identity(1,1) primary key,
	product_id int, 
	order_id int, 
	purchased_quantity int,
	[status] varchar(50),
	foreign key (product_id) references Product(id),
	foreign key (order_id) references [Order](id),
)
