--- Total Revenue

select sum(sales) as total_rev
from orderdetails

-- total profit
select sum(profit) as tot_profit
from OrderDetails

--Total orders
select count(*) as order_count
from orders


--Total customers
select count(*) as customer_count
from customers

--Total products
select count(*)
from products

--Avg orde value                                   ---- avg orde value = sum of sales / total orders  or total rev/ orders (how much money is a customer spending per order)
select sum(sales) *1.0/
count(distinct OrderID) as avgorder_value
from OrderDetails

--project margin                                  ---- profit margin =(total profit ÷ total revenue) × 100
select
round(
sum(Profit) * 100.0 /
sum(Sales)
,2) as ProfitMargin
from OrderDetails;

select distinct DeliveryStatus
from Shipping;

select distinct ShippingMode
from Shipping;

select distinct Latedeliveryrisk
from Shipping;

SELECT
min(Daysforshippingreal),
max(Daysforshippingreal),
avg(Daysforshippingreal)
FROM Shipping;
