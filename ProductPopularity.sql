/* Get the most 10 products that are purchased frequently.
   This metric shows the product popularity so that we know the best sellers of our company. */

/* Our goal is to get the top 10 purchased products */

WITH PRODUCTS_POPULARITY AS (
    SELECT DISTINCT STOCKCODE AS "Product ID", COUNT(*) OVER(PARTITION BY STOCKCODE) AS "Number of Purchasing"
    FROM TABLERETAIL
    ORDER BY "Number of Purchasing" DESC
),
BEST_10_SELLERS AS (
    SELECT RANK() OVER(ORDER BY PRODUCTS_POPULARITY."Number of Purchasing" DESC) AS "Best Seller", PRODUCTS_POPULARITY.*
    FROM PRODUCTS_POPULARITY
)
SELECT * FROM BEST_10_SELLERS
WHERE "Best Seller" <= 10;