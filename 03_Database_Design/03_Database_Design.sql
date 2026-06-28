create table categories 
(categoryid int primary key, 

categoryname varchar(100));


create table customers 
(customerid int primary key,

firstname varchar(100), 
lastname varchar(100),
city varchar(100), 
state varchar(100), 
country varchar(100), 
segment varchar(100));


create table products
(productid int primary key, 

productname varchar(100), 
productprice decimal (10,2), 
categoryid int, 
foreign key (categoryid) references categories(categoryid));


create table orders 
(orderid int primary key, 
customerid int, 
orderdate datetime, 
ordercity varchar(100), 
orderstate varchar(100), 
ordercountry varchar(100),
orderegion varchar(100),
market varchar(100), 
orderstatus varchar(100), 
foreign key (customerid) references customers(customerid));


create table Shipping
(
    OrderID int primary key,

    ShippingMode varchar(100),
    DeliveryStatus varchar(100),
    DaysForShippingReal int,
    DaysForShipmentScheduled int,
    LateDeliveryRisk int,
    ShippingDate datetime,

    foreign key(OrderID) references Orders(OrderID));

create table OrderDetails
(
    OrderItemID int primary key,

    OrderID int,
    ProductID int,

    Quantity int,
    Sales decimal(12,2),
    Profit decimal(12,2),
    Discount decimal(10,2),

    foreign key(OrderID) references Orders(OrderID),

    foreign key(ProductID) references Products(ProductID)
);

select TABLE_NAME                    ---shows the names of the tables created
from INFORMATION_SCHEMA.TABLES       ---view provided by sql server to view info abt database objects
where TABLE_TYPE='BASE TABLE';       --base table means asking sql only to show physical tables without this filter sql shows views as well
