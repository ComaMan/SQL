 select 
		to_number(regexp_replace(p3.ORDER_REF, '[^0-9]', '')) as ORDER_REFERENCE,
		TO_CHAR(p3.ORDER_DATE, 'MON-YYYY') as ORDER_PERIOD,
		INITCAP(lower(p1.SUPPLIER_NAME)) as SUPPLIER_NAME,
		TO_CHAR(p3.ORDER_TOTAL_AMOUNT,'fm999G999G999G999D00') as ORDER_TOTAL_AMOUNT,
		p3.ORDER_STATUS,
		p2.INVOICE_REFERENCE,
		p2.INVOICE_AMOUNT as INVOICE_TOTAL_AMOUNT,
		case 	when p2.invoice_reference not in (
select invoice_reference from p2
where invoice_status <> 'Paid') then 'ok'
				when p2.INVOICE_STATUS = 'Pending' then 'To follow up'
				when p2.INVOICE_STATUS = '' then 'To verify'
				when p2.INVOICE_STATUS is null then 'To verify'
        else 'To follow up'
				end as ACTION
				From p3 
				left join  P2
				ON p3.ORDER_REF =p2.ORDER_REF
				and p3.INVOICE_REFERENCE = p2.INVOICE_REFERENCE
				and p3.ORDER_DESCRIPTION = p2.ORDER_DESCRIPTION
				left join p1 
				on p3.supplier_name = p1.supplier_name
				order by Order_date desc;