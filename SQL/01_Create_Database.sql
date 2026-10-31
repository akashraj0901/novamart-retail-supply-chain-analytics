create database NovaMart;
use NovaMart;

create table Customers(
						Customer_id int primary key,
                        Customer_name varchar(100) not null,
                        Email varchar(250) unique,
                        Phone varchar(16) unique,
                        City varchar(100),
                        State varchar(100),
                        Registration_Date date
                        );
create table Categories(
						 Category_ID int primary key,
                         Category_Name varchar(100) 
                         );
create table Suppliers(
						Supplier_ID int primary key,
                        Supplier_Name varchar(100) not null,
                        City varchar(100),
                        Contact_No varchar(16) unique,
                        Rating decimal(3,2)
                        );
create table Products(
						Product_ID int primary key,
                        Product_Name varchar(100) not null,
                        Category_ID int,
                        Supplier_ID int,
                        Cost_Price decimal(10,2),
                        Current_price decimal(10,2),
                        Brand varchar(100),
                        Is_Active boolean default true,
                        foreign key(Category_ID) references Categories(Category_ID),
                        foreign key(Supplier_ID) references Suppliers(Supplier_ID)
                        );
create table WareHouses(
						WareHouse_ID int primary key,
                        WareHouse_Name varchar(100),
                        City varchar(100),
                        capacity int
                        );
create table Inventroy(
						Inventory_ID int primary key,
                        Product_ID int,
                        WareHouse_ID int,
                        Stock_Quantity int not null,
                        Recorder_Level int,
                        foreign key(Product_ID) references Products(Product_ID),
                        foreign key(WareHouse_ID) references WareHouses(wareHouse_ID),
                        unique(Product_ID, Warehouse_ID)
                        );
create table Orders(
					 Order_ID int primary key,
                     Customer_ID int,
                     Order_Date date,
                     Payment_Method varchar(32),
                     Order_Status varchar(50),
                     foreign key(Customer_ID) references Customers(Customer_ID)
                     );
create table Order_Details(
							Order_Details_ID int Primary key,
                            Order_ID int,
                            Product_ID int,
                            Quantity int not null,
                            Selling_Price decimal(10,2),
                            foreign key(Order_ID) references Orders(Order_ID),
                            foreign key(Product_ID) references Products(Product_ID)
                            );
create table Shipment(
						Shipment_ID int primary key,
                        Order_ID int,
                        WareHouse_ID int,
                        Shipment_Date date,
                        Delivery_Date date,
                        Delivery_Status varchar(50),
                        foreign key(order_id) references orders(order_id),
                        foreign key(warehouse_id) references warehouses(warehouse_id)
                        );
create table Returns(
					 Return_ID int primary key,
                     Order_Detail_ID int,
                     Return_Date date,
                     Return_Reason varchar(255),
                     Return_amount decimal(10,2),
                     foreign key(order_detail_id) references order_details(order_details_id));








CREATE TABLE Brands (
    Brand_ID INT PRIMARY KEY,
    Brand_Name VARCHAR(100) NOT NULL UNIQUE
);

alter table products
rename column Brand to Brand_ID;
alter table products
modify Brand_ID int,
add foreign key(Brand_ID) references Brands(Brand_ID);

ALTER TABLE Products
ADD COLUMN SKU VARCHAR(20) NOT NULL UNIQUE
AFTER Product_ID;

desc products;


alter table orders
add column Discount decimal(10,2) default 0;

ALTER TABLE Orders
MODIFY Order_Date DATETIME;

ALTER TABLE Order_Details
ADD Cost_Price DECIMAL(10,2) AFTER Selling_Price;