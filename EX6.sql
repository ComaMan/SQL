select SUPPLIER_NAME,
SUPP_CONTACT_NAME, SUPP_CONTACT_No1,
SUPP_CONTACT_No2,
count(SUPPLIER_NAME) as TOTAL_NUMBER_OF_ORDERS,
sum(ORDER_LINE_AMOUNT) as ORDER_TOTAL_AMOUNT
from(
select 
p1.SUPPLIER_NAME,
p1.SUPP_CONTACT_NAME,
case when (length(p1.SUPP_CONTACT_NUMBER1) = 8) then
substr(p1.SUPP_CONTACT_NUMBER1,1,4) || '-' || substr(p1.SUPP_CONTACT_NUMBER1,5,4) 
when (length(p1.SUPP_CONTACT_NUMBER1) = 7) then
substr(p1.SUPP_CONTACT_NUMBER1,1,3) || '-' || substr(p1.SUPP_CONTACT_NUMBER1,4,4) end as SUPP_CONTACT_No1,
case when (length(p1.SUPP_CONTACT_NUMBER2) = 8) then
substr(p1.SUPP_CONTACT_NUMBER2,1,4) || '-' || substr(p1.SUPP_CONTACT_NUMBER2,5,4) 
when (length(p1.SUPP_CONTACT_NUMBER2) = 7) then
substr(p1.SUPP_CONTACT_NUMBER2,1,3) || '-' || substr(p1.SUPP_CONTACT_NUMBER2,4,4) end as SUPP_CONTACT_No2,
p3.ORDER_LINE_AMOUNT
from p1
left join p3
on p3.supplier_name = p1.supplier_name
where length(p3.order_ref) <> 5
)src
group by SUPPLIER_NAME, SUPP_CONTACT_NAME, SUPP_CONTACT_No1, SUPP_CONTACT_No2;