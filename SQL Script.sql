-- Data Wrangling
-- Creating database and importing data using table data import wizard

-- Creating Database named 'amazon'.
create database amazon;

use  amazon;


-- Checking Columns
SELECT COUNT(*) Total_Columns 
FROM information_schema.columns
where table_name = 'amazon';


-- Checking Rows
SELECT COUNT(*) as Total_Rows FROM amazon;


-- Checking Null Values
SELECT COUNT(*) AS Null_values FROM amazon WHERE NULL;


-- Feature Engineering 

-- Modifying Datetime to Date
ALTER TABLE AMAZON
MODIFY COLUMN Date date;


-- Adding a new column named `dayname` that captures the day of the week on which each transaction occurred.
ALTER TABLE AMAZON
ADD COLUMN Day_Name varchar(50);

UPDATE amazon
SET Day_Name = DAYNAME(Date);


-- Updating Dafe Updates to 0
SET SQL_SAFE_UPDATES = 0;


-- Adding New Column Month_Name that contains the Extracted Monthname from Date Column. 
ALTER TABLE amazon
ADD COLUMN Month_Name varchar(50);

UPDATE amazon
SET Month_Name = MONTHNAME(Date);


-- Adding a new column, `Time_of_day`, to provide insights into sales during the morning, afternoon, and evening.
ALTER TABLE amazon
ADD COLUMN Time_of_day VARCHAR(20) NOT NULL;

UPDATE amazon 
SET Time_of_day = 
CASE
WHEN hour(Time) BETWEEN 06 and 11 THEN "Morning"
WHEN hour(Time) BETWEEN 12 and 17 THEN 'Afternoon'
ELSE 'Evening'
END;

-- Checking Columns
SELECT COUNT(*) Total_Columns 
FROM information_schema.columns
where table_name = 'amazon';


-- Checking Rows
SELECT COUNT(*) as Total_Rows FROM amazon;


-- Checking Null Values
SELECT COUNT(*) AS Null_values FROM amazon WHERE NULL;

-- Answering the Project Questions.

-- 1 What is the count of distinct cities in the dataset? (3)
SELECT COUNT(distinct(City)) AS Distinct_Cities 
FROM amazon;

-- There are 3 Unique Cities in Dataset. 


-- 2 For each branch, what is the corresponding city?
SELECT DISTINCT City, Branch
FROM amazon;

-- There are 3 unique Branches corresponding to 3 unique Brach and City. 


-- 3 What is the count of distinct product lines in the dataset?
SELECT COUNT(DISTINCT(`Product line`)) as Distinct_Pl
FROM amazon;

-- In dataset there are 6 unqui product lines. 


-- 4 Which payment method occurs most frequently? (Ewallet - 345)
SELECT Payment, COUNT(Payment) as Occurs
FROM amazon
GROUP BY Payment
ORDER BY Occurs DESC;

-- 'Ewallet' occurs most frequently (345). 


-- 5 Which product line has the highest sales? (Food and beverages - 53471.28)
SELECT `Product line`, SUM(Quantity) Quantity_Sold,  ROUND(SUM(Quantity * `Unit price`), 3) as Total_Sales
FROM amazon
GROUP BY `Product line`
ORDER BY Total_Sales DESC
LIMIT 1;

-- 'Food and beverages' has generated Highest Total_Sales Amount (53471.28) with 952 Quantity Sold. 
-- Where 'Electronic accessories' has Highest Quantity Sold with 971. 


-- 6 How much revenue is generated each month? 
SELECT Month_Name, ROUND(SUM(Total), 3) Monthly_Revenue
FROM amazon
GROUP BY Month_Name
ORDER BY Month_Name;

-- January generated the highest revenue with 116291.868 followed by February and March. 


-- 7 In which month did the cost of goods sold reach its peak? ( February - 92589.88)
SELECT Month_Name, SUM(cogs) Total_Cogs
FROM amazon
GROUP BY Month_Name
ORDER BY Total_Cogs
LIMIT 1;

-- In 'February' cost of goods sold reached peak with 92589.88


-- 8 Which product line generated the highest revenue? (Food and beverages - 56144.844)
SELECT `Product line`, ROUND(SUM(Total), 3) as Revenue
FROM amazon
GROUP BY `Product line`
ORDER BY Revenue DESC
LIMIT 1;

-- Out of 6 Unique product lines, 'Food and beverages' received the highest Revenue in Total 56144.844 


-- 9 In which city was the highest revenue recorded? (Naypyitaw - 110568.706)
SELECT City, ROUND(SUM(Total), 3) Revenue
FROM amazon
GROUP BY City
ORDER BY Revenue DESC
LIMIT 1;

-- Out of 3 Unique cities, 'Naypyitaw' has received Highest Revenue with 110568.706


-- 10 Which product line incurred the highest Value Added Tax? (Food and beverages - 2673.564)
SELECT `Product line`, MAX(`Tax 5%`) Highest_Vat, ROUND(SUM(`Tax 5%`), 3) Vat_Amount
FROM amazon
GROUP BY `Product line`
ORDER BY Highest_Vat DESC
LIMIT 1;

-- 'Fashion accessories' product line have Highest VAT with 2585.995 Total VAT amount. 


-- 11 For each product line, add a column indicating "Good" if its sales are above average, otherwise "Bad."
SELECT `Product line`, sum(`Unit price` * Quantity) AS Total_Sales, 
CASE 
	WHEN SUM(Quantity * `Unit price`) > (SELECT SUM(`Unit price` * Quantity)/COUNT(DISTINCT(`Product line`)) FROM amazon) THEN 'Good'
    ELSE 'Bad'
END Sales_Performance
FROM amazon
GROUP BY `Product line`
ORDER BY Total_Sales DESC;

-- Only 'Health and beauty' product line have Sales less than Average that is "BAD" performance. 
-- All other product lines have sales higher than average "GOOD" performance. 


-- 12 Identify the branch that exceeded the average number of products sold. ( A - 1859)
SELECT Branch, SUM(Quantity) as Total_Units_Sold
FROM amazon
GROUP BY Branch
HAVING Total_Units_Sold > (SELECT SUM(Quantity) / COUNT(DISTINCT(Branch)) AS Avg_Quantity
FROM amazon);

--  Branch 'A' Exceeded the Average No.of Products sold '1859'. 


-- 13 Which product line is most frequently associated with each gender?
SELECT `Product line`, 
SUM(CASE WHEN Gender = 'Female' THEN 1 ELSE 0 END) AS Female, -- If Gender is "Female', it counts 1 to the SUM. If not it contributes 0
SUM(CASE WHEN Gender = 'Male' THEN 1 ELSE 0 END) AS Male      -- using case create Ner Aggregated Column   
FROM amazon
GROUP BY `Product line`
ORDER BY Male DESC;

-- "MALES" contribution is high with 'HEALTH AND BEAUTY".
-- "FEMALES" contribution is high with "FOOD ABD BEVERAGES". 


-- 14 Calculate the average rating for each product line.
SELECT `Product line`, ROUND(AVG(Rating), 2) Avg_Rating
FROM amazon
GROUP BY `Product line`
ORDER BY Avg_Rating DESC;

-- 'Food and Beverages' get the highest Average rating 7.11 followed by 'Fashion Accessories 7.03' 


-- 15 Count the sales occurrences for each time of day on every weekday.
SELECT Day_Name, Time_of_day, COUNT(*) AS Sales_Count
FROM amazon
GROUP BY Day_Name, Time_of_day   
ORDER BY FIELD(Day_Name, 'Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'),
FIELD(Time_of_day, 'Morning', 'Afternoon', 'Evening'); -- used Field for custom sorting 

-- Count method to get the count of sales occur on a particular weekday and on particular time of that weekday.
-- Every weekday most sales occur during the Afternoon time (between 12 to 6 PM)


-- 16 Identify the customer type contributing the highest revenue. (Member - 164223.444)
select `Customer type`, ROUND(SUM(Total), 3) as Revenue
FROM amazon
GROUP BY `Customer type`
ORDER BY Revenue DESC;

-- 'MEMBER' customer type contributing to highest Revenue with 164223.444


-- 17 Determine the city with the highest VAT percentage.  -- VAT = Amount of Tax on purchase
SELECT City, ROUND(SUM(`Unit price` * Quantity), 2) as Before_Tax, 
ROUND(SUM(Total), 2) AS After_Tax, 
ROUND(SUM(`Tax 5%`), 2) as Vat_Amount,
ROUND((SUM(`Tax 5%`) / SUM(Total)) * 100, 2) AS Vat_Percentage -- Calculating VAT Percentage
From amazon
GROUP BY City
ORDER BY Vat_Percentage DESC;

-- Although there is very slight difference in decimals 'YANGON' city contribute to Highest VAT percentage. 


-- 18 Identify the customer type with the highest VAT payments. (Member - 7820.16)
SELECT `Customer type`, ROUND(SUM(`Unit price` * Quantity), 2) as Before_Tax, 
ROUND(SUM(Total), 2) AS After_Tax, ROUND(SUM(`Tax 5%`), 2) as VAT
FROM amazon
GROUP BY `Customer type`
ORDER BY VAT DESC;

-- 'MEMBER' customer type contribute to highes VAT payments. 


-- 19 What is the count of distinct customer types in the dataset?
SELECT COUNT(DISTINCT(`Customer type`)) as Distinct_Cust_Types
FROM amazon;

-- There are 2 types of customers - Member and Normal

-- 20 What is the count of distinct payment methods in the dataset?
SELECT COUNT(DISTINCT(Payment)) Distinct_Pm 
FROM amazon;

-- There are 3 Distinct types - Ewallet, Cash, Credit Card. 

-- 21 Which customer type occurs most frequently? (Member - 501)
SELECT `Customer type`, COUNT(`Customer type`) AS Count_Cust
FROM amazon
GROUP BY `Customer type`;

-- Although there is not much difference in customer type in contribution buy yes 'MEMBER' type have upperhand than 'NORMAL'. 


-- 22 Identify the customer type with the highest purchase frequency.
SELECT `Customer type`, COUNT(*) Purchase_Frequency,
SUM(Quantity) Quantity_Purchased, ROUND(SUM(Total), 2) Revenue_Generated
FROM amazon
GROUP BY `Customer type`
ORDER BY Revenue_Generated DESC;

-- 'Member' type of customer type purchase goods more frequently. 

-- 23 Determine the predominant gender among customers. (Female - 501)
SELECT Gender, COUNT(Gender) Dominent
FROM amazon
GROUP BY Gender
ORDER BY Dominent DESC
LIMIT 1;

-- Although there is not much difference in gender in contribution by 'FEMALES' have Upperhand than 'MALES'.

-- 24 Examine the distribution of genders within each branch.
SELECT Branch,
SUM(CASE WHEN Gender = 'Female' THEN 1 ELSE 0 END) AS Female,
SUM(CASE WHEN Gender = 'Male' THEN 1 ELSE 0 END) AS Male
FROM amazon
GROUP BY Branch
ORDER BY Female, Male DESC;

-- Branch wise contribution of Gender says that in Branch A and B 'MALES' are high where in Branch C 'FEMALES' are high


-- 25 Identify the time of day when customers provide the most ratings. 
SELECT Time_of_day, COUNT(Rating) Most_Ratings
FROM amazon
GROUP BY Time_of_day
ORDER BY Most_Ratings DESC;

-- At Afternoon Ratings provided by customers is high with 528. 

-- 26 Determine the time of day with the highest customer ratings for each branch.
SELECT Branch, Time_of_day, Most_Ratings
FROM (
    SELECT Branch, Time_of_day, COUNT(Rating) AS Most_Ratings,
           ROW_NUMBER() OVER (PARTITION BY Branch ORDER BY COUNT(Rating) DESC) AS Rating
    FROM amazon
    GROUP BY Branch, Time_of_day
) AS ranked
WHERE Rating = 1;

-- For all the Three Branches(A, B, C) Afternoon is the time when they get their most number of Ratings.


-- 27 Identify the day of the week with the highest average ratings. (Monday - 7.154)
SELECT Day_Name, ROUND(AVG(Rating), 3) Avg_Rating
FROM amazon
GROUP BY Day_Name
ORDER BY Avg_Rating DESC;
-- LIMIT 1;

-- In all the Weekdays, Monday is the day with highest Average Rating 7.154 


-- 28 Determine the day of the week with the highest average ratings for each branch.
SELECT Day_Name, Branch, Avg_Rating FROM
(SELECT Branch, Day_Name, ROUND(AVG(Rating), 3) AS Avg_Rating,
ROW_NUMBER() OVER(PARTITION BY Branch ORDER BY AVG(Rating) DESC) AS High_Rating
FROM amazon
GROUP BY Branch, Day_Name 
ORDER BY Avg_Rating DESC) AS bb
WHERE High_Rating = 1;

-- To get the Average for each Branch with the weekday names, Subquery is used with Window Row number() Function. 
-- From the above query we can say that, Branch B, Monday is the day with highest Average Rating with 7.336. 
-- For Branch A & C it's Friday.
