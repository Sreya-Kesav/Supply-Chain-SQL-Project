----REGIONAL ANALYSIS
---Which markets generate the highest revenue

select o.market, sum(od.sales) as revenue
from orders o
join OrderDetails od on o.orderid = od.OrderID
group by o.market
order by revenue desc;

--- Revenue by country

select top 10
o.ordercountry, sum(od.sales) as revenue
from orders o
join OrderDetails od on o.orderid = od.OrderID
group by o.ordercountry
order by revenue desc;

-- Profit by region

select o.orderegion, sum(od.Profit) as profit
from orders o
join OrderDetails od on o.orderid = od.OrderID
group by o.orderegion
order by profit desc;

--Profit margin by regiom

select
o.orderegion, sum(od.sales) as revenue, sum(od.profit) as profit,
sum(od.profit)*100/sum(od.sales) as profit_margin
from orders o
join OrderDetails od on o.orderid = od.OrderID
group by o.orderegion
order by profit_margin desc;

--late delivery rate by country
--Identifies regions where logistics performance needs
--improvement.

 select o.ordercountry,count(*) as  totorders,
 sum(case 
 when s.latedeliveryrisk =1 then 1
 else 0
 end) ,
 sum( case 
 when s.latedeliveryrisk =1 then 1
 else 0
 end) *100/ count(*) as latedeliveryrate
 from orders o 
 join shipping s on o.orderid = s.orderid
 group by o.ordercountry
 order by latedeliveryrate desc;

 --Average order value by market

 select o.market ,sum(od.sales) as rev, count(o.orderid) as totorder,
 sum(od.sales)/count(o.orderid) as AOV
 from orders o
 join orderdetails od on o.orderid = od.orderid
 group by o.market
 order by AOV desc;
