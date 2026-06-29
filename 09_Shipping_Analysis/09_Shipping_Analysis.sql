--- Late delivery rate 
---Measures overall logistics performance and customer service.

select*
from Shipping


select count(*) as totalorders,
sum ( case
when latedeliveryrisk = 1 then 1
else 0
end) as lateorders,

sum ( case                                            ---- late delivery rate =  (no.late orders/total orders) * 100
when latedeliveryrisk = 1 then 1
else 0
end) * 100.0 / count(*) as late_delivery_rate
from Shipping;

--- On-time delivery rate

select count(*) as totalorders,
sum ( case
when latedeliveryrisk = 0 then 1
else 0
end) as timelyorders,

sum ( case                                            ---- on time delivery rate =  (no.on-time orders/total orders) * 100
when latedeliveryrisk = 0 then 1
else 0
end) * 100.0 / count(*) as ontime_delivery_rate
from Shipping;

---How are deliveries distributed across delivery statuses

select DeliveryStatus, count(*) as statcount
from Shipping
group by DeliveryStatus
order by statcount desc;

---Which shipping mode is used the most

select ShippingMode, count(*)  as Modecount
from Shipping
group by ShippingMode
order by Modecount;

---What is the average actual delivery time

select avg(DaysForShippingReal) as avg_del_time
from Shipping;

---How many days, on average, are deliveries delayed

select avg(DaysForShippingReal - daysforshipmentscheduled)       ---days for shipping real (when it was delivered)
from shipping;                                                   --- days for shipment scheduled (when the delivery should have happened)
                                                                 --- delay = (days for shipping real) - (days for shipment scheduled)

--Which shipping mode has the lowest average delay?

select shippingmode, avg(DaysForShippingReal - daysforshipmentscheduled) as avgdelay     
from shipping
group by ShippingMode
order by avgdelay;

--Which shipping mode has the highest late delivery rate

select shippingmode,count(*) as totorder,
sum(
case when latedeliveryrisk = 1 then 1
else 0
end) as latedel,

sum(
case when latedeliveryrisk = 1 then 1
else 0
end)*100/count(*) as latedelrate
from shipping
group by shippingmode
order by latedelrate desc;


