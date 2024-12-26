# Amazon-sales-analysis

## Project Objective
The major aim of this project was to gain insight into the sales data of Amazon to understand the different factors that affected sales across various branches.

## About the Data
This dataset contained sales transactions from three different branches of Amazon located in Mandalay, Yangon, and Naypyitaw. The data consisted of 17 columns and 1000 rows, including:

- **invoice_id**
- **branch**
- **city**
- **customer_type**
- **gender**
- **product_line**
- **unit_price**
- **quantity**
- **VAT**
- **total**
- **date**
- **time**
- **payment_method**
- **cogs**
- **gross_margin_percentage**
- **gross_income**
- **rating**

## Approach Used

### Data Wrangling
- **Built a Database**: Created a table and inserted the data.
- **NULL Value Inspection**: Selected columns with NULL values; there were no NULL values as each field was set to NOT NULL during table creation.

### Feature Engineering
- **Added Time of Day Column**: Gained insight into sales during Morning, Afternoon, and Evening.
- **Added Day Name Column**: Extracted days of the week for transaction analysis.
- **Added Month Name Column**: Extracted months to determine sales and profit trends throughout the year.

### Exploratory Data Analysis (EDA)
- Conducted EDA to answer the key business questions outlined below.

## Business Questions Answered
1. Counted the distinct cities in the dataset.
2. Identified the corresponding city for each branch.
3. Counted the distinct product lines in the dataset.
4. Determined the most frequently occurring payment method.
5. Identified which product line had the highest sales.
6. Calculated the revenue generated each month.
7. Found the month in which the cost of goods sold reached its peak.
8. Identified the product line that generated the highest revenue.
9. Determined the city with the highest revenue recorded.
10. Found which product line incurred the highest Value Added Tax.
11. Added a column indicating "Good" or "Bad" for product lines based on sales performance.
12. Identified the branch that exceeded the average number of products sold.
13. Analyzed which product line was most frequently associated with each gender.
14. Calculated the average rating for each product line.
15. Counted the sales occurrences for each time of day on every weekday.
16. Identified the customer type contributing the highest revenue.
17. Determined the city with the highest VAT percentage.
18. Identified the customer type with the highest VAT payments.
19. Counted the distinct customer types in the dataset.
20. Counted the distinct payment methods in the dataset.
21. Identified the most frequently occurring customer type.
22. Determined the customer type with the highest purchase frequency.
23. Analyzed the predominant gender among customers.
24. Examined the distribution of genders within each branch.
25. Identified the time of day when customers provided the most ratings.
26. Determined the time of day with the highest customer ratings for each branch.
27. Identified the day of the week with the highest average ratings.
28. Determined the day of the week with the highest average ratings for each branch.

## Tools Used
Used **SQL** and **Excel** for data analysis and manipulation.

## License
This project is for educational purposes only and does not require a formal license.
