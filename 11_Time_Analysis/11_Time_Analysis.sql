-- TIME ANALYSIS
--How does revenue change month by month

select
year(o.orderdate) as orderyear , month(o.orderdate) as month , 
datename(month,o.orderdate) as month_name,
sum(od.sales) as revenue
from orders o
join orderdetails od on o.orderid = od.orderid
group by year(o.orderdate),month(o.orderdate),datename(month,o.orderdate)
order by orderyear, month;

---How does profit change month by month
select
year(o.orderdate) as orderyear , month(o.orderdate) as month , 
datename(month,o.orderdate) as month_name,
sum(od.Profit) as profit
from orders o
join orderdetails od on o.orderid = od.orderid
group by year(o.orderdate),month(o.orderdate),datename(month,o.orderdate)
order by orderyear, month;

---Which months receive the most orders

select
count(*) as orders,year(orderdate) as orderyear , month(orderdate) as month , 
datename(month,orderdate) as month_name
from orders
group by year(orderdate)  , month(orderdate), 
datename(month,orderdate) 
order by count(*) desc;

--- best sales by month
select top 1
    year(o.orderDate) AS orderyear,
    datename(month,o.orderDate) AS month,
    sum(od.Sales) as revenue
from orders o
join orderDetails od
on o.orderID = od.orderID
group by
    year(o.orderdate),
    month(o.orderdate),
    datename(month,o.orderdate)
order by revenue desc;

-- best profit by month

select top 1
sum(od.profit) as profit, 
year(o.orderdate) as orderyear , 
datename(month,o.orderdate) as month_name,
month(o.orderdate) as month
from orders o
join OrderDetails od 
on o.orderid = od.OrderID
group by 
year(o.orderdate),
datename(month,o.orderdate),
month(o.orderdate)
order by profit desc;

--Average order value by month

select 
year(o.orderdate) as orderyear , 
datename(month,o.orderdate) as month,
count(distinct o.orderid) order_count, sum(od.sales) as revenue,

sum(od.sales)/count(distinct o.orderid) as AOV
from orders o 
join orderdetails od on o.orderid = od.orderid
group by datename(month,o.orderdate),year(o.orderdate)
order by orderyear, month desc;
