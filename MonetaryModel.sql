/* Get the recency of each customer which is the difference in days between the most recent purchase date of this customer and the most recent purchase date of all customers */
WITH RECENCY AS (
    SELECT DISTINCT CUSTOMER_ID AS "Customer ID",
        TRUNC(MAX(TO_TIMESTAMP(INVOICEDATE, 'mm/dd/yyyy HH24:MI')) OVER()) - TRUNC(MAX(TO_TIMESTAMP(INVOICEDATE, 'mm/dd/yyyy HH24:MI')) OVER(PARTITION BY CUSTOMER_ID)) AS "Recency"
    FROM TABLERETAIL
),
/* Get the frequency of each customer which is the number of purchases each customer orders */
FREQUENCY AS (
    SELECT DISTINCT CUSTOMER_ID AS "Customer ID",
        COUNT(DISTINCT INVOICE) OVER(PARTITION BY CUSTOMER_ID) AS "Frequency"
    FROM TABLERETAIL
),
/* Get the monetary value which is the total amount of money spent by each customer on his purchases */
MONETARY AS (
    SELECT DISTINCT CUSTOMER_ID AS "Customer ID",
        SUM(QUANTITY * PRICE) OVER(PARTITION BY CUSTOMER_ID) AS "Monetary"
    FROM TABLERETAIL
),
/* Prepare the RFM model.
    Get the R_Score, F_Score, and M_Score by dividing the Recency, Frequency, and Monetary into 5 groups */
RFM_MODEL AS (
    SELECT RECENCY."Customer ID", "Recency", "Frequency", "Monetary",
        NTILE(5) OVER(ORDER BY "Recency" DESC) AS "R_Score",
        NTILE(5) OVER(ORDER BY "Frequency") AS "F_Score",
        NTILE(5) OVER(ORDER BY "Monetary") AS "M_Score"
    FROM RECENCY, FREQUENCY, MONETARY
    WHERE RECENCY."Customer ID" = FREQUENCY."Customer ID" AND FREQUENCY."Customer ID" = MONETARY."Customer ID"
),
/* Then get the average in scores between the F_Score and M_Score to reduce the possible combinations */
RFM_SCORES AS (
    SELECT "Customer ID", "Recency", "Frequency", "Monetary",
        "R_Score", NTILE(5) OVER(ORDER BY (("F_Score" + "M_Score") / 2)) AS "FM_Score"
    FROM RFM_MODEL
)
/* Now, time for Customer Segmentation */
SELECT RFM_SCORES.*,
    CASE
        WHEN ("R_Score" = 5 AND "FM_Score" = 5)
            OR ("R_Score" = 5 AND "FM_Score" = 4)
            OR ("R_Score" = 4 AND "FM_Score" = 5) THEN 'Champions'

        WHEN ("R_Score" = 5 AND "FM_Score" = 2)
            OR ("R_Score" = 4 AND "FM_Score" = 2)
            OR ("R_Score" = 3 AND "FM_Score" = 3)
            OR ("R_Score" = 4 AND "FM_Score" = 3) THEN 'Potential Loyalists'

        WHEN ("R_Score" = 5 AND "FM_Score" = 3)
            OR ("R_Score" = 4 AND "FM_Score" = 4)
            OR ("R_Score" = 3 AND "FM_Score" = 5)
            OR ("R_Score" = 3 AND "FM_Score" = 4) THEN 'Loyal Customers'

        WHEN ("R_Score" = 5 AND "FM_Score" = 1) THEN 'Recent Customers'

        WHEN ("R_Score" = 4 AND "FM_Score" = 1)
            OR ("R_Score" = 3 AND "FM_Score" = 1) THEN 'Promising'

        WHEN ("R_Score" = 3 AND "FM_Score" = 2)
            OR ("R_Score" = 2 AND "FM_Score" = 3)
            OR ("R_Score" = 2 AND "FM_Score" = 2) THEN 'Customers Needing Attention'

        WHEN ("R_Score" = 2 AND "FM_Score" = 1) THEN 'About to Sleep'

        WHEN ("R_Score" = 2 AND "FM_Score" = 5)
            OR ("R_Score" = 2 AND "FM_Score" = 4)
            OR ("R_Score" = 1 AND "FM_Score" = 3) THEN 'At Risk'
        
        WHEN ("R_Score" = 1 AND "FM_Score" = 5)
            OR ("R_Score" = 1 AND "FM_Score" = 4) THEN 'Can''t Lose Them'

        WHEN ("R_Score" = 1 AND "FM_Score" = 2) THEN 'Hibernating'

        WHEN ("R_Score" = 1 AND "FM_Score" = 1) THEN 'Lost'
    END AS "Customer Segment"
FROM RFM_SCORES
ORDER BY "Customer ID";