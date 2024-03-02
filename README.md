# Online-Retail-Data-Analysis-using-Analytical-SQL
This project aims to analyze the data of an Online Retail to gather some insights and make decisions depending on the Products Popularity, Profitability, Customer Segmentation, and some other metrics using Analytical SQL such as Window Functions, CTEs ... etc.

## Customers Purchasing Behavior ##

### Consecutive Purchasing Days for each Customer ###

Having a dataset with the purchasing dates and amount spent for each customer helps our retail store to track the customers behavior in purchasing our products. One of the KPIs which helps us is the number of consecutive purchasing days of each customer. The customers who but regularly from our retail store are so valuable and we need to care about them.

You can check the dataset from here &rarr; [Daily Purchasing Dataset](datasets/daily-purchasing.csv)

Using *Analytical SQL* and *Window Functions*, it's easy to track the consecutive days through `LAG` function to get each previous purchasing day and compare the results with the actual previous days in calender. This results in getting multiple number of consecutive days per customer, but getting the maximum of them is easier using `MAX` function.

You can check the whole code from here &rarr; [Tracing Customers Purchasing Behavior](codes/CustomersPurchasingBehvior.sql)

<div align="center">
  <img src="images/max-consecutive-days.jpg" alt="Image" width=600>
  <p><em>Sample of the Maximum Consecutive Days of some Customers</em></p>
</div>

---