insert into categories (categoryid,categoryname)
select distinct 
Category_Id,
Category_Name
from Raw_supplychain_data;

insert into customers
(
    CustomerID,
    FirstName,
    LastName,
    City,
    State,
    Country,
    Segment
)
select distinct
       Customer_Id,
       Customer_Fname,
       Customer_Lname,
       Customer_City,
       Customer_State,
       Customer_Country,
       Customer_Segment
from Raw_supplychain_data;

insert into products
(
    ProductID,
    ProductName,
    ProductPrice,
    CategoryID
)
select distinct
       Product_Card_Id,
       Product_Name,
       Product_Price,
       Category_Id
from Raw_supplychain_data;

insert into orders
(
    OrderID,
    CustomerID,
    OrderDate,
    OrderCity,
    OrderState,
    OrderCountry,
    Orderegion,
    Market,
    OrderStatus
)
select distinct
       Order_Id,
       Customer_Id,
       order_date_DateOrders,
       Order_City,
       Order_State,
       Order_Country,
       Order_Region,
       Market,
       Order_Status
from Raw_supplychain_data;

insert into Shipping
(
    OrderID,
    ShippingMode,
    DeliveryStatus,
    DaysForShippingReal,
    DaysForShipmentScheduled,
    LateDeliveryRisk,
    ShippingDate
)
select distinct
       Order_Id,
       Shipping_Mode,
       Delivery_Status,
       Days_for_shipping_real,
       Days_for_shipment_scheduled,
       Late_delivery_risk,
       shipping_date_DateOrders
from Raw_supplychain_data;

insert into OrderDetails
(
    OrderItemID,
    OrderID,
    ProductID,
    Quantity,
    Sales,
    Profit,
    Discount
)
select
       Order_Item_Id,
       Order_Id,
       Product_Card_Id,
       Order_Item_Quantity,
       Sales,
       Order_Profit_Per_Order,
       Order_Item_Discount
from Raw_supplychain_data;

select count(*) from customers;
select count(*) from products;
select count(*) from orders;
select count(*) from orderdetails;

-- Data validations using joins to check if relationships are working correctly

select top 10
       o.OrderID,
       c.FirstName,
       c.LastName,
       p.ProductName,
       od.Quantity,
       od.Sales
from Orders o
join Customers c
    on o.CustomerID = c.CustomerID
join OrderDetails od
    on o.OrderID = od.OrderID
join Products p
    on od.ProductID = p.ProductID;



