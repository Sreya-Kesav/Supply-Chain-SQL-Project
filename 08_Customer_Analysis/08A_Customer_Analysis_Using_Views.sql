create view vw_customerperformance as

select
c.customerid,sum(od.sales) as revenue,
concat(c.FirstName,' ' , c.LastName) as Customer_Name,
sum(od.Profit) as Profit,count(distinct o.orderid) as totalorders
from customers c
join Orders o on c.customerid = o.customerid
join OrderDetails od on o.orderid = od.OrderID
group by c.customerid , c.firstname,c.lastname;
GO

--top 10 customer by revenue
select top 10
revenue, customer_name , customerid
from vw_customerperformance
order by revenue desc;

-- Top 10 by profit
select top 10
customer_name , customerid, profit
from vw_customerperformance
order by Profit desc;

-- Customers with Highest Number of Orders
select top 10
customer_name , customerid, totalorders
from vw_customerperformance
order by totalorders desc;

-- Highest Average Order Value
select top 10
customer_name , customerid, totalorders, revenue,
revenue/nullif(totalorders,0) as AOV
from vw_customerperformance
order by AOV desc;

-- Customers Spending Above Average Revenue
select 
revenue, customer_name , customerid
from vw_customerperformance
where revenue > 
(select avg(revenue)
from vw_customerperformance)
order by revenue desc;
