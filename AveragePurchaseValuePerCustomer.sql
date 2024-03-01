/* Get the avergae purchase value for each customer.
   This metric shows the average amount each customer spends on a single transaction. */

/* Our goal is to get the top 10 customer with respect to the Average Purchase Value */
WITH CUSTOMERS_INVOICES AS (
    SELECT DISTINCT CUSTOMER_ID AS "Customer ID", INVOICE AS "Invoice",
        SUM(PRICE * QUANTITY) OVER(PARTITION BY CUSTOMER_ID, INVOICE) AS "Total Revenue Per Invoice",
        COUNT(DISTINCT INVOICE) OVER(PARTITION BY CUSTOMER_ID) AS "Total Number of Invoices"
    FROM TABLERETAIL
),
AVERAGE_PURCHASE_VALUES AS (
    SELECT DISTINCT CUSTOMERS_INVOICES."Customer ID",
        SUM("Total Revenue Per Invoice") OVER(PARTITION BY CUSTOMERS_INVOICES."Customer ID") AS "Total Revenue",
        CUSTOMERS_INVOICES."Total Number of Invoices",
        ROUND(AVG("Total Revenue Per Invoice") OVER(PARTITION BY CUSTOMERS_INVOICES."Customer ID"), 2) AS "Average Purchase Value"
    FROM CUSTOMERS_INVOICES
    ORDER BY "Average Purchase Value" DESC
),
TOP_10_CUSTOMERS AS (
    SELECT DENSE_RANK() OVER(ORDER BY AVERAGE_PURCHASE_VALUES."Average Purchase Value" DESC) AS "Customer Rank",
        AVERAGE_PURCHASE_VALUES.*
    FROM AVERAGE_PURCHASE_VALUES
)
SELECT * FROM TOP_10_CUSTOMERS WHERE "Customer Rank" <= 10;