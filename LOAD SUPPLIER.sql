DECLARE
 v_query_1 VARCHAR2(2000 CHAR);
BEGIN
    v_query_1 := 'INSERT INTO P1 (SUPPLIER_NAME, SUPP_CONTACT_NAME, SUPP_ADDRESS, SUPP_CONTACT_NUMBER1, SUPP_CONTACT_NUMBER2, SUPP_EMAIL)
SELECT 
DISTINCT
  SUPPLIER_NAME, 
	SUPP_CONTACT_NAME,
	SUPP_ADDRESS,
REGEXP_SUBSTR (replace(replace(replace(replace(replace(upper(SUPP_CONTACT_NUMBER),''O'', ''0''),''S'',''5''), ''I'', ''1''),'' '',''''),''.'',''''), ''[^,]+'', 1, 1) as SUPP_CONTACT_NUMBER1,
REGEXP_SUBSTR (replace(replace(replace(replace(replace(upper(SUPP_CONTACT_NUMBER),''O'', ''0''),''S'',''5''), ''I'', ''1''),'' '',''''),''.'',''''), ''[^,]+'', 1, 2)    AS SUPP_CONTACT_NUMBER2,
	SUPP_EMAIL
  from PRACTICE_TABLE';

    EXECUTE IMMEDIATE v_query_1;

END;
/