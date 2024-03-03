/* Our goal is to get the number of days/transactions each customer takes to spend threshold of 250 */

WITH TOTAL_AMOUNT_SPENT AS (
    /* This query retrieves each customer with its total amount spent over all transactions,
        and the cummulative amount spent over each day */
    SELECT CUST_ID, CALENDAR_DT, AMT_LE, SUM(AMT_LE) OVER(PARTITION BY CUST_ID) AS "TotalAmountSpent",
        SUM(AMT_LE) OVER(PARTITION BY CUST_ID ORDER BY TO_DATE(CALENDAR_DT, 'yyyy-mm-dd')) AS "CummulativeAmount"
    FROM DAILYPURCHASING
),
FILTERING_CUSTOMERS AS (
    /* Then this query just filters the targeted customers. Those customers should:
        1. Have total amount spent >= 250
        2. Their cummulative amount <= 250 --> To filter out the remaining results */
    SELECT TOTAL_AMOUNT_SPENT.*,
        COUNT(*) OVER(PARTITION BY CUST_ID ORDER BY "CummulativeAmount" RANGE BETWEEN 250 PRECEDING AND CURRENT ROW) AS "Number of Days"
    FROM TOTAL_AMOUNT_SPENT
    -- To filter people who didn't achieve this threshold for their all transactions
    WHERE "TotalAmountSpent" >= 250 AND "CummulativeAmount" < 250
),
NUMBER_OF_DAYS AS (
    /* Then this query gets the maximum number of days for each customer as the previous query returns a series of number of days */
    SELECT DISTINCT CUST_ID, MAX("Number of Days") OVER(PARTITION BY CUST_ID) + 1 AS "Number of Days to Threshold"
    FROM FILTERING_CUSTOMERS
)
/* Finally, get the average over all customers */
SELECT TRUNC(AVG("Number of Days to Threshold")) AS "Average Number of Days"
FROM NUMBER_OF_DAYS;