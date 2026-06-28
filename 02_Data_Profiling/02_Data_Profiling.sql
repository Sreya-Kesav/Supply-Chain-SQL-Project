--checking datatype
exec sp_help Raw_supplychain_data; --exec means execute  
                                   --sp_help is default stored procedure in sql
                                   --Raw_supplychain_data is the table name

--checking column names

select COLUMN_NAME
from INFORMATION_SCHEMA.COLUMNS
where TABLE_NAME='Raw_supplychain_data'
order by COLUMN_NAME;

--count total rows
select count(*) as TotalRows
from Raw_supplychain_data;

--Distinct count or distinct entity validation
----validate data to check if there's no loss of data and all the rows are present later when we migrate the data after creating tables

select count(distinct Customer_Id)
from Raw_supplychain_data;

select count(distinct Category_Id)
from Raw_supplychain_data;

select count(distinct Product_Card_Id)
from Raw_supplychain_data;

select count(distinct Order_Id)
from Raw_supplychain_data;

select count(distinct Order_Item_Id)
from Raw_supplychain_data;

select count(*)
from categories;

---consistency validation 

select Product_Card_Id,
       count(distinct Product_Name) as ProductNames
from Raw_supplychain_data
group by Product_Card_Id
having count(distinct Product_Name) > 1;

select Category_Id,
       count(distinct Category_Name) as CategoryNames
from Raw_supplychain_data
group by Category_Id
having count(distinct Category_Name) > 1;

select Customer_Id,
       count(distinct Customer_Fname + Customer_Lname) as Names
from Raw_supplychain_data
group by Customer_Id
having count(distinct Customer_Fname + Customer_Lname) > 1;

select Order_ID,
   count(distinct order_date_DateOrders) AS OrderDates
from Raw_supplychain_data
group by Order_ID
having count(distinct order_date_DateOrders) > 1;

---Null checks

select count(*) as nullcustomer_id
from Raw_supplychain_data
where customer_id is null;

select count(*) as nullproduct_id
from Raw_supplychain_data
where product_card_id is null;

select count(*) as nullcategory_id
from Raw_supplychain_data
where category_id is null;

select count(*) as nullorder_id
from Raw_supplychain_data
where order_id is null;

select count(*) as nullorder_item_id
from Raw_supplychain_data
where Order_Item_Id is null;

select count(*) as nullsales_id
from Raw_supplychain_data
where Sales is null;

select count(*) as nullprofit
from Raw_supplychain_data
where Order_Profit_Per_Order is null;
