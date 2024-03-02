/* Analyze the rate of change between quarterly fiscal data.
   This metric shows the growth in revenue per quarter compared to the previous quarter. */

WITH QUARTERS_MARGIN AS (
    SELECT DISTINCT TO_CHAR(TO_TIMESTAMP(INVOICEDATE, 'mm/dd/yyyy HH24:MI'), 'Q') AS "Quarter",
        SUM(PRICE * QUANTITY) OVER(PARTITION BY TO_CHAR(TO_TIMESTAMP(INVOICEDATE, 'mm/dd/yyyy HH24:MI'), 'Q')) AS "Total Revenue"
    FROM TABLERETAIL
    ORDER BY "Quarter", "Total Revenue" DESC
)
SELECT QUARTERS_MARGIN.*,
    ROUND((("Total Revenue" - NULLIF(LAG("Total Revenue", 1, 0) OVER(ORDER BY "Total Revenue"), 0)) / NULLIF(LAG("Total Revenue", 1, 0) OVER(ORDER BY "Total Revenue"), 0)) * 100, 2) AS "Quarter on Quarter - QoQ %"
FROM QUARTERS_MARGIN;
