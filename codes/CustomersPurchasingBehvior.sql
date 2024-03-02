/* Our goal is to get the maximum number of consecutive days a customer made purchases */

WITH CALENDER_INFO AS (
    /* This query retrieves each customer and its purchasing dates with 2 extra dates:
        1. Previous purchasing date for that customer
        2. Previous calender date for the purchasing date */
    SELECT CUST_ID AS "Customer ID", TO_DATE(CALENDAR_DT, 'yyyy-mm-dd') AS "Date",
        LAG(TO_DATE(CALENDAR_DT, 'yyyy-mm-dd')) OVER(PARTITION BY CUST_ID ORDER BY TO_DATE(CALENDAR_DT, 'yyyy-mm-dd')) AS "Previous Purchasing Day",
        TO_DATE(CALENDAR_DT, 'yyyy-mm-dd') -1 AS "Previous Calender Day"
    FROM DAILYPURCHASING
    ORDER BY "Date"
),
DETECT_CONSECUTIVE_DAYS AS (
    /* Then this query compares the previous purchasing date and the previous calender date */
    SELECT CALENDER_INFO.*,
        CASE WHEN "Previous Purchasing Day" = "Previous Calender Day" THEN 0 ELSE 1 END AS "Non-Consecutive Flag"
    FROM CALENDER_INFO
),
GROUPING_CONSECUTIVE_DAYS AS (
    /* This query marks each group of consecutive days with a number.
        For example: first group of consecutive days is marked with 1, second group is marked as 2 ... etc */
    SELECT DETECT_CONSECUTIVE_DAYS.*,
        SUM("Non-Consecutive Flag") OVER(PARTITION BY "Customer ID" ORDER BY "Date") AS "Sum Changed"
    FROM DETECT_CONSECUTIVE_DAYS
),
COUNTING_CONSECUTIVE_DAYS AS (
    /* Then, this query counts the number of days in each group */
    SELECT DISTINCT GROUPING_CONSECUTIVE_DAYS.*, COUNT(*) OVER(PARTITION BY "Customer ID", "Sum Changed") AS "Consecutive Days"
    FROM GROUPING_CONSECUTIVE_DAYS
    ORDER BY "Date"
)
/* Finally, get the maximum number of consecutive days of each customer */
SELECT DISTINCT "Customer ID" , MAX("Consecutive Days") OVER(PARTITION BY "Customer ID") AS "Max Number of Consecutive Days"
FROM COUNTING_CONSECUTIVE_DAYS
ORDER BY "Customer ID";