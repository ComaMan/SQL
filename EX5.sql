select 
	regexp_replace(p3.ORDER_REF, '[^0-9]', '') as ORDER_REFERENCE,
	TO_CHAR(p3.ORDER_DATE, 'Month DD,YYYY'), 
	Upper(p1.SUPPLIER_NAME),
	TO_CHAR(p3.ORDER_TOTAL_AMOUNT,'fm999G999G999G999D00') as ORDER_TOTAL_AMOUNT,
	p3.ORDER_STATUS,
	(select 
  listagg(p2.invoice_reference, '|') within group (order by p3.ORDER_TOTAL_AMOUNT)
  from p3 left join p2 ON p3.ORDER_REF =p2.ORDER_REF
				and p3.INVOICE_REFERENCE = p2.INVOICE_REFERENCE
				and p3.ORDER_DESCRIPTION = p2.ORDER_DESCRIPTION
        WHERE p3.ORDER_TOTAL_AMOUNT = ( SELECT MAX( p3.ORDER_TOTAL_AMOUNT )
FROM P3 where p3.ORDER_TOTAL_AMOUNT not in ( select max (p3.ORDER_TOTAL_AMOUNT) from  p3 ))) as INVOICE_REFERENCE
From p3 
				left join  P2
				ON p3.ORDER_REF =p2.ORDER_REF
				and p3.INVOICE_REFERENCE = p2.INVOICE_REFERENCE
				and p3.ORDER_DESCRIPTION = p2.ORDER_DESCRIPTION
				left join p1 
				on p3.supplier_name = p1.supplier_name
WHERE p3.ORDER_TOTAL_AMOUNT = ( SELECT MAX( p3.ORDER_TOTAL_AMOUNT )
FROM P3 where p3.ORDER_TOTAL_AMOUNT not in ( select max (p3.ORDER_TOTAL_AMOUNT) from  p3 ))
                 ;