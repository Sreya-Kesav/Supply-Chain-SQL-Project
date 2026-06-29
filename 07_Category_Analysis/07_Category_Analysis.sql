---CATEGORY ANALYSIS
--Top categories by revenue

select top 10
ca.categoryname, sum(od.sales) as revenue
from categories ca
join products p on ca.categoryid = p.categoryid
join OrderDetails od on p.productid = od.productid
group by ca.categoryname
order by revenue desc;

--Top category by profit

select top 10
ca.categoryname, sum(od.Profit) as profit
from categories ca
join products p on ca.categoryid = p.categoryid
join OrderDetails od on p.productid = od.productid
group by ca.categoryname
order by profit desc;

-- profit margin

select top 10
ca.categoryname, sum(od.Profit) as profit, sum(od.Sales) as revenue,
coalesce (round(sum(od.Profit)*100.0/ nullif(sum(od.sales),0),2),0) as profit_margin
from categories ca
join products p on ca.categoryid = p.categoryid
join OrderDetails od on p.productid = od.productid
group by ca.categoryname
order by profit_margin desc;

---revenue contribution
---percentage of total company revenue that each category contributes

select top 10
ca.categoryname, sum(od.sales) as revenue , 
sum(od.sales)*100/(select sum(sales) from OrderDetails od) as revenue_contribution            ---- revenue contribution = (category rev/ total rev )*100
from categories ca
join products p on ca.categoryid = p.categoryid
join OrderDetails od on p.productid = od.productid
group by categoryname
order by revenue_contribution desc; 

