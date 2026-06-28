---PRODUCT ANALYSIS WITH VIEWS

create view vw_prodcutperformance as
select 
p.ProductName, sum(od.sales) as revenue,sum(od.Profit) as Profit
from OrderDetails od
join products p on od.ProductID = p.ProductID
group by p.ProductName
go

---Top 10 products by revenue

select top 10
ProductName,revenue
from vw_prodcutperformance
order by revenue desc;

---Top 10 products by profit
select top 10
ProductName,Profit
from vw_prodcutperformance
order by Profit desc;

---Bottom 10 products by profit
select top 10
ProductName,Profit
from vw_prodcutperformance
order by Profit asc;

---Profit Margin
select top 10
ProductName,Profit, revenue,
coalesce(
(Profit) *100 / revenue,0) as Profitmargin
from vw_prodcutperformance
order by Profitmargin desc;
