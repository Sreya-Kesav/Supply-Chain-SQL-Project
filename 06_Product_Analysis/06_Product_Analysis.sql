---PRODUCT ANALYSIS

---Top 10 products by revenue
--- To see which products generate more revenue

select top 10
p.ProductName, sum(od.sales) as revenue
from OrderDetails od
join products p on od.ProductID = p.ProductID
group by p.ProductName
order by revenue desc;

---Top 10 products by profit
---Which product actually brings money

select top 10
p.ProductName, sum(od.Profit) as Profit
from OrderDetails od
join products p on od.ProductID = p.ProductID
group by p.ProductName
order by Profit desc;

---Bottom 10 products by profit
--- these products are profit drainers 

select top 10
p.ProductName, sum(od.Profit) as Profit
from OrderDetails od
join products p on od.ProductID = p.ProductID
group by p.ProductName
order by Profit asc;

---Profit Margin
select top 10
p.ProductName, sum(od.Profit) as profit,
sum(od.sales) as revenue,
coalesce(
sum(od.Profit)*100 / sum(od.sales),0) as Profitmargin
from Orderdetails od
join Products p on od.ProductID = p.ProductID
group by ProductName
order by ProfitMargin asc;

