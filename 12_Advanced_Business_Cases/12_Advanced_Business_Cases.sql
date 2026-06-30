--- Business cases
---Top product in each category

with topproduct as(
select p.productname, ca.categoryname, sum(od.sales) as revenue,
row_number() over( partition by ca.categoryname order by sum(od.sales )desc) as rn
from products p
join categories ca on p.categoryid = ca.categoryid

join orderdetails od on od.productid = p.productid

group by p.productname, ca.categoryname)

select revenue,productname, categoryname,rn
from topproduct
where rn=1
order by revenue desc;

---Ranking customers based on total revenue

with customer_rank as
(
select sum(od.sales) as revenue, o.customerid,
rank() over(order by sum(od.sales) desc) as rank
from orders o
join OrderDetails od on o.orderid = od.OrderID

group by o.customerid)

select revenue , customerid, rank
from customer_rank
order by revenue desc;

--- month-over-month revenue growth

with monthlyrevenue as(
select
sum(od.sales) as revenue, month(o.orderdate) as monthnumber , year(o.orderdate) as years,
datename ( month, o.orderdate) as month_name
from orders o 
join OrderDetails od on o.orderid = od.OrderID

group by month(o.orderdate),year(o.orderdate) , datename (month, o.orderdate)
),

revenuetrend as
(
select monthnumber,years, month_name,revenue,
lag(revenue) over ( order by years,monthnumber) as previousrevenue
from monthlyrevenue
)

select
previousrevenue, monthnumber, years,month_name,
revenue-previousrevenue as revdiff ,
round((revenue-previousrevenue) *100/nullif(previousrevenue,0),6)as growthpercentage
from revenuetrend
order by years,monthnumber;

-- Cumulative revenue

with monthlyrevenue as(
select
sum(od.sales) as revenue, month(o.orderdate) as monthnumber , year(o.orderdate) as years,
datename ( month, o.orderdate) as month_name
from orders o 
join OrderDetails od on o.orderid = od.OrderID

group by month(o.orderdate),year(o.orderdate) , datename (month, o.orderdate)
)

select  monthnumber, years,month_name,revenue,
sum(revenue) over(order by years, monthnumber) as runningrev
from monthlyrevenue
order by years, monthnumber;

-- top 10% customers based on revenue

with customerrevenue as
(
select sum(od.sales) as revenue, concat(c.firstname, ' ' , c.lastname) as customer_name, c.customerid
from customers c
join orders o on c.customerid = o.customerid
join OrderDetails od on o.orderid = od.OrderID
group by c.firstname , c.lastname , c.customerid
),

customersegment as
(
select customer_name , customerid , revenue,
ntile(10) over (order by revenue desc) as top_rev_customer
from customerrevenue
)

select customer_name , customerid , revenue, top_rev_customer
from customersegment
where top_rev_customer = 1
order by revenue desc;

---The highest-revenue product for every market 

with productrevenue as(
select
sum(od.sales) as revenue, o.market , p.productname
from orders o
join OrderDetails od on o.orderid = od.OrderID
join products p on od.ProductID = p.productid
group by o.market , p.productname
),

highrevenueprod as 
(
select market, productname, revenue,
rank() over (partition by market order by revenue desc) as high_rev_prod
from productrevenue
)

select*
from highrevenueprod
where high_rev_prod =1
order by revenue desc;




