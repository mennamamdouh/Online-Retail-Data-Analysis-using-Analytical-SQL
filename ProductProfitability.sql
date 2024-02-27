/* Get the most 10 products that cause the largest revenue.
   This metric shows the product profitability so that we know the products which cause the revenue to increase. */

/* Our goal is to get the top 10 products with respect to revenue */

WITH PRODUCT_PROFITABILITY AS (
    SELECT DISTINCT STOCKCODE AS "Product ID",
        SUM(QUANTITY * PRICE) OVER(PARTITION BY STOCKCODE) AS "Total Revenue of the Product"
    FROM TABLERETAIL
    ORDER BY "Total Revenue of the Product" DESC
),
TOP_10_PRODUCTS AS (
    SELECT RANK() OVER(ORDER BY PRODUCT_PROFITABILITY."Total Revenue of the Product" DESC) AS "Product Rank",
        PRODUCT_PROFITABILITY.*
    FROM PRODUCT_PROFITABILITY
)
SELECT * FROM TOP_10_PRODUCTS
WHERE "Product Rank" <= 10;