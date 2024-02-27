# Online-Retail-Data-Analysis-using-Analytical-SQL
This project aims to analyze the data of an __Online Retail__ to gather some insights and make decisions based on *Products Popularity*, *Products and Customers Profitability*, *Customer Segmentation*, and some other metrics using __Analytical SQL__ such as *Window Functions*, *CTEs* ... etc.

The data is visualized through various charts to add more clearness to the insights and understand sales trends and uncover potential opportunities for growth.

---

## Data Exploration ##

As the data exploration phase is one of the most important phases of any data analytics project, so let's start with. This phase made me understand the aspects of our retail data such as the size of data, the number of customers that purchased in a specified period, the year we're trying to analyze its data, and the products that are included in this analysis.

*After some exploration, I've concluded that:*
1. Total number of records is `12858`.
2. Our customer network has `110` customers.
3. The total number of products sold are `2335` products.
4. We're interested in only one country which is `United Kingdom`.
5. Our period of interest is between `Jan 11, 2011` and `Sept 9, 2011`.
6. `717` invoices have been made by different customers.

---

## Guiding Questions ##

The purpose of this analysis is to answer some major questions to help move the business in the right direction.

### Seasonal Trends and QoQ ###

As a retial store, we're interested to view the revenue data for each month for the year `2011`. Also, it's beneficial to understand and dig deeper into the *Seasonal Trends*.

So, we've aggregated the total revenue for each month in the year `2011` and shown the corresponding quarter. The data is sorted by total revenue in descending order partitioned by quarter.

<div align="center">
  <img src="images/seasonal-trends.jpg" alt="Image" width=600>
  <p><em>Total Revenue Per Month</em></p>
</div>

Besides, we've decided to dig deeper into the behavior of the revenue for each quarter and measure the *Quarter on Quarter* metric which represents the rate of change between quarterly fiscal data. It helps in determining the store's quarterly growth.

<div align="center">
  <img src="images/QoQ.jpg" alt="Image" width=600>
  <p><em>Quarter on Quarter %</em></p>
</div>

---

### Average Purchase Value of Customers ###

As a retail store which helps thousands of customers to get their products, we're interested in viewing some information on the top 10 customers by revenue. This information shows the rank of each customer based on the `Average Puchase Value`, the total revenue he/she helps us to earn, and the total number of invoices he/she has made.

This helps us to define the top 10 customers who participated in our growth, and make a decision to invest in those customers.

<div align="center">
  <img src="images/average-purchase-value.jpg" alt="Image" width=800>
  <p><em>Average Purchase Value Per Customer</em></p>
</div>

---

### Products Popularity and Profitability ###

It's very important for any retail store to gain insights on the demand for their products. Two of the most important KPIs that determines this aspect is *Product Popularity* and *Product Profitability*.

*Product Popularity* defines the items that are selling well, in other words they're the best sellers.

<div align="center">
  <img src="images/products-popularity.jpg" alt="Image" width=600>
  <p><em>Best Sellers of our Online Retail Store</em></p>
</div>

On the other hand, *Product Profitability* determines the amount of profit that each product makes in a particular period.

<div align="center">
  <img src="images/products-profitability.jpg" alt="Image" width=600>
  <p><em>Products Profitability</em></p>
</div>

---