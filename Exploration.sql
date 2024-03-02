/* Our goal is to explore our dataset and gather some information before digging deeper into the insights and KPIs */

SELECT * FROM tableRetail;

SELECT COUNT(*) FROM TABLERETAIL;

SELECT COUNT(DISTINCT CUSTOMER_ID) FROM TABLERETAIL;

SELECT COUNT(DISTINCT STOCKCODE) FROM TABLERETAIL;

SELECT DISTINCT COUNTRY FROM TABLERETAIL;

SELECT TO_CHAR(MIN(TO_TIMESTAMP(INVOICEDATE, 'mm/dd/yyyy HH24:MI')), 'mm-dd-yyyy') AS "First Day", TO_CHAR(MAX(TO_TIMESTAMP(INVOICEDATE, 'mm/dd/yyyy HH24:MI')), 'mm/dd/yyyy') AS "Last Day" FROM TABLERETAIL;

SELECT COUNT(DISTINCT INVOICE) FROM TABLERETAIL;