/* Analyze the seasonal trending of the online retail data.
   This metric shows the seasonal trending so that we can know the highest quarter-month pairs with respect to revenue. */

/* Our goal is to show the revenue per month in each quarter */

SELECT DISTINCT TO_CHAR(TO_TIMESTAMP(INVOICEDATE, 'mm/dd/yyyy HH24:MI'), 'Q') AS "Quarter",
    TO_CHAR(TO_TIMESTAMP(INVOICEDATE, 'mm/dd/yyyy HH24:MI'), 'Month') AS "Month",
    SUM(PRICE * QUANTITY) OVER(PARTITION BY EXTRACT(MONTH FROM TO_TIMESTAMP(INVOICEDATE, 'mm/dd/yyyy HH24:MI'))) AS "Total Revenue Per Month"
FROM TABLERETAIL
ORDER BY "Quarter", "Total Revenue Per Month" DESC;