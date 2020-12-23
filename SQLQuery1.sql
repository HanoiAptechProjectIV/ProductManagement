create database ProductManagement;
use ProductManagement;


create table Employee (
	id int not null identity(1,1) primary key,
	username varchar(30),
	[password] varchar(50),
	name nvarchar(30),
	gender bit,
	phone varchar(20),
	email varchar(50),
	[address] nvarchar(50),
	[role] int
)

create table Category (
	id int not null identity(1,1) primary key, 
	name nvarchar(30),
	employee_id int,
	[description] text,
	foreign key (employee_id) references Employee(id)
)

create table Brand (
	id int not null identity(1,1) primary key, 
	name nvarchar(30), 
	logo varchar(50),
	manufacturer nvarchar(30),
	[description] text,
	employee_id int,
	foreign key (employee_id) references Employee(id)
)

create table Product (
	id int not null identity(1,1) primary key,
	name nvarchar(50),
	[description] text,
	price float, 
	quantity int,
	[image] varchar(50),
	date_added datetime DEFAULT CURRENT_TIMESTAMP, 
	category_id int,
	brand_id int,
	foreign key (category_id) references Category(id),
	foreign key (brand_id) references Brand(id)
)

create table [User] (
	id int not null identity(1,1) primary key,
	username varchar(30),
	[password] varchar(50),
	name nvarchar(30),
	gender bit,
	phone varchar(20),
	email varchar(50),
	[address] nvarchar(50)	
)

create table [Order] (
	id int not null identity(1,1) primary key,
	created_day DateTime DEFAULT CURRENT_TIMESTAMP,
	payment_day DateTime,
	[user_id] int,
	amount float,
	[status] varchar(50),
	foreign key ([user_id]) references [User](id)
)

create table OrderDetail (
	id int not null identity(1,1) primary key, 
	product_id int, 
	order_id int,
	purchased_quantity int,
	[status] varchar(50),
	foreign key (product_id) references Product(id),
	foreign key (order_id) references [Order](id)
)

create table EmployeeProduct (
	id int not null identity(1,1) primary key,
	employee_id int,
	product_id int,
	foreign key (product_id) references Product(id),
	foreign key (employee_id) references Employee(id)	
)

create table EmployeeOrder (
	id int not null identity(1,1) primary key,
	employee_id int,
	order_id int,
	foreign key (order_id) references [Order](id),
	foreign key (employee_id) references Employee(id)
)
