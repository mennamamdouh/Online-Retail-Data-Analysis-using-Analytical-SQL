# Online-Retail-Data-Analysis-using-Analytical-SQL
This project aims to analyze the data of an Online Retail to gather some insights and make decisions based on Products Popularity, Products and Customers Profitability, Customer Segmentation, and some other metrics using Analytical SQL such as Window Functions, CTEs ... etc.

The data is visualized through various charts to add more clearness to the insights and understand sales trends and uncover potential opportunities for growth.

---

## Guiding Questions ##

The purpose of this analysis is to answer five major questions to help move the business in the right direction.

### Question 1 ###

As a retial store, we're interested to view the revenue data for each month for the year `2011`. Also, it's beneficial to understand and dig deeper into the *Seasonal Trends*.

So, we've aggregated the total revenue for each month in the year `2011` and shown the corresponding quarter. The data is sorted by total revenue in descending order partitioned by quarter.

<div align="center">
  <img src="images/seasonal-trends.jpg" alt="Image" width=700>
  <p><em>Total Revenue Per Month</em></p>
</div>

Besides, we've decided to dig deeper into the behavior of the revenue for each quarter and measure the *Quarter on Quarter* metric which represents the rate of change between quarterly fiscal data. It helps in determining the store's quarterly growth.

<div align="center">
  <img src="images/QoQ.jpg" alt="Image" width=700>
  <p><em>Quarter on Quarter %</em></p>
</div>

---

### Question 2 ###

As a retail store which helps thousands of customers to get their products, we're interested in viewing some information on the top 10 customers by revenue. This information shows the rank of each customer based on the `Average Puchase Value`, the total revenue he/she helps us to earn, and the total number of invoices he/she has made.

This helps us to define the top 10 customers who participated in our growth, and make a decision to invest in those customers.

<div align="center">
  <img src="images/average-purchase-value.jpg" alt="Image" width=700>
  <p><em>Average Purchase Value Per Customer</em></p>
</div>

---