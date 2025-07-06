# Total Revenue
Select sum(Total_Revenue)
From data1.onlinesales;

# Total Units Sold
Select sum(Units_Sold)
From data1.onlinesales;

# Top revenue of category
Select Product_Category,sum(Total_Revenue) AS 'Revenue'
From data1.onlinesales
Group by Product_Category
Order by 2 DESC;

# Total Units Sold by Region
Select region,sum(Units_Sold)
From data1.onlinesales
Group by 1;

# create column OrderDate with data type is Date
ALTER TABLE data1.onlinesales
ADD COLUMN OrderDate DATE;
SET SQL_SAFE_UPDATES = 0;
UPDATE data1.onlinesales
SET OrderDate = STR_TO_DATE(Date_, '%m/%d/%Y');
SET SQL_SAFE_UPDATES = 1;

# Total Order by Month
select month(OrderDate) as Month_ , sum(Total_Revenue) as TotalRevenue
From data1.onlinesales
group by 1;

# Total Unit Price by Category
select Product_Category, sum(Unit_Price)
From data1.onlinesales
group by 1;

# Total Order by Payment Method
select Payment_Method, count(distinct(Transaction_ID)) as Quantity
From data1.onlinesales
group by 1;

# Peak month revenue
WITH MonthlyProductRevenue AS (
    SELECT Product_Category, month(OrderDate) as Month_, SUM(Total_Revenue) AS Revenue
    FROM data1.onlinesales
    GROUP BY 1,2
),
RankedMonthlyRevenue AS (
    SELECT Product_Category, Month_, Revenue,
        ROW_NUMBER() OVER (PARTITION BY Product_Category ORDER BY Revenue DESC) AS rank_
    FROM
        MonthlyProductRevenue
)
SELECT Product_Category, Month_, Revenue
FROM RankedMonthlyRevenue
WHERE rank_ = 1
ORDER BY 1;

# Top Payment Method
SELECT Payment_Method,count(Payment_Method) as Quantity
FROM data1.onlinesales
GROUP BY 1;

# Best Performance Region
WITH BestPerformanceRegion AS (
    SELECT Product_Category, region, SUM(Total_Revenue) AS Revenue
    FROM data1.onlinesales
    GROUP BY 1,2
),
RankedRevenue AS (
    SELECT Product_Category,region, Revenue,
        ROW_NUMBER() OVER (PARTITION BY Product_Category ORDER BY Revenue DESC) AS rank_
    FROM BestPerformanceRegion
)
SELECT Product_Category, Region, Revenue
FROM RankedRevenue
WHERE rank_ = 1
ORDER BY 1;

# Best revenue performer
WITH BestPerformer AS (
    SELECT Product_Category, Product_Name, SUM(Total_Revenue) AS Revenue
    FROM data1.onlinesales
    GROUP BY 1,2
),
RankedRevenue AS (
    SELECT Product_Category,Product_Name, Revenue,
        ROW_NUMBER() OVER (PARTITION BY Product_Category ORDER BY Revenue DESC) AS rank_
    FROM BestPerformer
)
SELECT Product_Category, Product_Name, Revenue
FROM RankedRevenue
WHERE rank_ = 1
ORDER BY 1;

# Best Selling product
WITH BestSelling AS (
    SELECT Product_Category, Product_Name, SUM(Units_Sold) AS TotalUnitSold, sum(Total_Revenue) AS Revenue
    FROM data1.onlinesales
    GROUP BY 1,2
),
RankedUnitSold AS (
    SELECT Product_Category,Product_Name, TotalUnitSold, Revenue,
        ROW_NUMBER() OVER (PARTITION BY Product_Category ORDER BY TotalUnitSold DESC, Revenue DESC) AS rank_
    FROM BestSelling
)
SELECT Product_Category, Product_Name, TotalUnitSold
FROM RankedUnitSold
WHERE rank_ = 1
ORDER BY 1;