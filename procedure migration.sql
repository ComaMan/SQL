create or replace procedure LOAD_TEST_TABLES
IS
BEGIN

INSERT INTO P1 (SUPPLIER_NAME, SUPP_CONTACT_NAME, SUPP_ADDRESS, SUPP_CONTACT_NUMBER1, SUPP_CONTACT_NUMBER2, SUPP_EMAIL)
SELECT 
DISTINCT
  SUPPLIER_NAME, 
	SUPP_CONTACT_NAME,
	SUPP_ADDRESS,
REGEXP_SUBSTR (replace(replace(replace(replace(replace(upper(SUPP_CONTACT_NUMBER),'O', '0'),'S','5'), 'I', '1'),' ',''),'.',''), '[^,]+', 1, 1) as SUPP_CONTACT_NUMBER1,
REGEXP_SUBSTR (replace(replace(replace(replace(replace(upper(SUPP_CONTACT_NUMBER),'O', '0'),'S','5'), 'I', '1'),' ',''),'.',''), '[^,]+', 1, 2)    AS SUPP_CONTACT_NUMBER2,
	SUPP_EMAIL
  from PRACTICE_TABLE;
  
  INSERT INTO P2 (ORDER_REF, INVOICE_REFERENCE, ORDER_DESCRIPTION, INVOICE_DATE, INVOICE_STATUS, INVOICE_AMOUNT, INVOICE_HOLD_REASON, INVOICE_DESCRIPTION)
select 
ORDER_REF,
	INVOICE_REFERENCE 	,
  REPLACE(ORDER_DESCRIPTION, '"', ' inches') AS ORDER_DESCRIPTION,
	to_date(INVOICE_DATE,'DD-MM-YYYY') as INVOICE_DATE, 
	INVOICE_STATUS,
	TO_NUMBER(replace(replace(replace(replace(upper(INVOICE_AMOUNT),'O', '0'),'S','5'), 'I', '1'), ',', '')) as INVOICE_AMOUNT,
  INVOICE_HOLD_REASON,
  REPLACE(INVOICE_DESCRIPTION, '#', '')
  from practice_table
  where UPPER(ORDER_STATUS) in ('RECEIVED');
 
  INSERT INTO P3 (ORDER_REF, INVOICE_REFERENCE,SUPPLIER_NAME, ORDER_DESCRIPTION, ORDER_DATE, ORDER_TOTAL_AMOUNT, ORDER_STATUS, ORDER_LINE_AMOUNT)
select distinct
	ORDER_REF,
  NVL(INVOICE_REFERENCE,'-'),
  SUPPLIER_NAME,
  REPLACE(ORDER_DESCRIPTION, '"', ' inches'),
	to_date(ORDER_DATE,'DD-MM-YYYY') as ORDER_DATE,
	TO_NUMBER(REPLACE(ORDER_TOTAL_AMOUNT,',',''||'' )) as ORDER_TOTAL_AMOUNT,
 ORDER_STATUS,
  TO_NUMBER(replace(replace(replace(replace(upper(ORDER_LINE_AMOUNT),'O', '0'),'S','5'), 'I', '1'), ',', '')) as ORDER_LINE_AMOUNT
  from PRACTICE_TABLE;
 commit;
end;