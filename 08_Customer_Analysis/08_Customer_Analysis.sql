---CUSTOMER ANALYSIS
--- top 10 by rev
select top 10 
c.customerid,sum(od.sales) as revenue,
concat(c.FirstName,' ' , c.LastName) as Customer_Name 
from customers c
join Orders o on c.customerid = o.customerid
join OrderDetails od on o.orderid = od.OrderID
group by c.customerid , c.firstname,c.lastname
order by revenue desc;

---top 10 by profit
select top 10 
c.customerid,sum(od.Profit) as Profit,
concat(c.FirstName,' ' , c.LastName) as Customer_Name 
from customers c
join Orders o on c.customerid = o.customerid
join OrderDetails od on o.orderid = od.OrderID
group by c.customerid , c.firstname,c.lastname
order by Profit desc;

---Which customers place the highest number of orders?

select top 10
c.customerid , concat(c.FirstName,' ' , c.LastName) as Customer_Name , count(o.orderid) as totalorders
from orders o
join customers c on c.customerid = o.customerid
group by c.customerid , c.firstname , c.lastname
order by totalorders desc;

---How much does each customer spend on average per order?

select top 10
c.customerid,concat(c.FirstName,' ' , c.LastName) as Customer_Name , sum(od.sales) as revenue , count(distinct o.orderid) as orders,
sum(od.sales)/count(distinct o.orderid) as AOV	
from customers c
join orders o on c.customerid = o.customerid
join OrderDetails od on od.OrderID = o.orderid
group by c.customerid, c.firstname, c.lastname
order by AOV desc;

---Which customers spend more than the average customer?

With customerrev as 
(select 
c.customerid,sum(od.sales) as revenue,
concat(c.FirstName,' ' , c.LastName) as Customer_Name 
from customers c
join Orders o on c.customerid = o.customerid
join OrderDetails od on o.orderid = od.OrderID
group by c.customerid , c.firstname,c.lastname)

select customerid, revenue, Customer_Name
from customerrev
where revenue > ( select avg(revenue)
from customerrev)
order by revenue desc;



