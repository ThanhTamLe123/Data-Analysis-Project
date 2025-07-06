# create column OrderDate with data type is Date
ALTER TABLE data1.eu_superstore_new
ADD COLUMN OrderDate DATE;
SET SQL_SAFE_UPDATES = 0;
UPDATE data1.eu_superstore_new
SET OrderDate = STR_TO_DATE(`Order Date`, '%m/%d/%Y');
SET SQL_SAFE_UPDATES = 1;

# Total Sales by year
select Year(OrderDate) as YEAR_,sum(Sales) as 'Total Sales'
From data1.eu_superstore_new
group by 1;

# Sales % change vs PY
WITH Sales2014 AS
	(select Sum(Sales) AS sales
     from data1.eu_superstore_new
     where year(OrderDate)=2014
     Group by year(OrderDate)
     ),
     Sales2015 AS
	(select Sum(Sales) AS sales
     from data1.eu_superstore_new
     where year(OrderDate)=2015
     Group by year(OrderDate)
     ),
     Sales2016 AS
	(select Sum(Sales) AS sales
     from data1.eu_superstore_new
     where year(OrderDate)=2016
     Group by year(OrderDate)
     ),
     Sales2017 AS
	(select Sum(Sales) AS sales
     from data1.eu_superstore_new
     where year(OrderDate)=2017
     Group by year(OrderDate)
     )
 SELECT (Sales2017.sales - Sales2016.sales)/ Sales2016.sales as  sales_change_17_16,
		(Sales2016.sales - Sales2015.sales)/ Sales2015.sales as  sales_change_16_15,
        (Sales2015.sales - Sales2014.sales)/ Sales2014.sales as  sales_change_15_14
From Sales2017, Sales2016, Sales2015, Sales2014;

# Total Profit by year
select Year(OrderDate) as YEAR_,sum(Profit) as 'Total Profit'
From data1.eu_superstore_new
group by 1;

# Profit % change vs PY
WITH Profit2014 AS
	(select Sum(Profit) AS profit
     from data1.eu_superstore_new
     where year(OrderDate)=2014
     Group by year(OrderDate)
     ),
     Profit2015 AS
	(select Sum(Profit) AS profit
     from data1.eu_superstore_new
     where year(OrderDate)=2015
     Group by year(OrderDate)
     ),
     Profit2016 AS
	(select Sum(Profit) AS profit
     from data1.eu_superstore_new
     where year(OrderDate)=2016
     Group by year(OrderDate)
     ),
     Profit2017 AS
	(select Sum(Profit) AS profit
     from data1.eu_superstore_new
     where year(OrderDate)=2017
     Group by year(OrderDate)
     )
 SELECT (Profit2017.profit - Profit2016.profit)/ Profit2016.profit as  profit_change_17_16,
		(Profit2016.profit - Profit2015.profit)/ Profit2015.profit as  profit_change_16_15,
        (Profit2015.profit - Profit2014.profit)/ Profit2014.profit as  profit_change_15_14
From Profit2017, Profit2016, Profit2015, Profit2014;

# Total Order by year
select Year(OrderDate) as YEAR_,count(distinct(`Order ID`)) as 'Total Order'
From data1.eu_superstore_new
group by 1;

# Order % change vs PY
WITH order2014 AS
	(select count(distinct(`Order ID`)) AS order_
     from data1.eu_superstore_new
     where year(OrderDate)=2014
     Group by year(OrderDate)
     ),
     order2015 AS
	(select count(distinct(`Order ID`)) AS order_
     from data1.eu_superstore_new
     where year(OrderDate)=2015
     Group by year(OrderDate)
     ),
     order2016 AS
	(select count(distinct(`Order ID`)) AS order_
     from data1.eu_superstore_new
     where year(OrderDate)=2016
     Group by year(OrderDate)
     ),
     order2017 AS
	(select count(distinct(`Order ID`)) AS order_
     from data1.eu_superstore_new
     where year(OrderDate)=2017
     Group by year(OrderDate)
     )
 SELECT (order2017.order_ - order2016.order_)/ order2016.order_ as  order_change_17_16,
		(order2016.order_ - order2015.order_)/ order2015.order_ as  order_change_16_15,
        (order2015.order_ - order2014.order_)/ order2014.order_ as  order_change_15_14
From order2017, order2016, order2015, order2014;

# Total Customer by year
select Year(OrderDate) as YEAR_,count(distinct(`Customer ID`)) as 'Total Customer'
From data1.eu_superstore_new
group by 1;

# Customer % change vs PY
WITH customer2014 AS
	(select count(distinct(`Customer ID`)) AS customer
     from data1.eu_superstore_new
     where year(OrderDate)=2014
     Group by year(OrderDate)
     ),
     customer2015 AS
	(select count(distinct(`Customer ID`)) AS customer
     from data1.eu_superstore_new
     where year(OrderDate)=2015
     Group by year(OrderDate)
     ),
     customer2016 AS
	(select count(distinct(`Customer ID`)) AS customer
     from data1.eu_superstore_new
     where year(OrderDate)=2016
     Group by year(OrderDate)
     ),
    customer2017 AS
	(select count(distinct(`Customer ID`)) AS customer
     from data1.eu_superstore_new
     where year(OrderDate)=2017
     Group by year(OrderDate)
     )
 SELECT (customer2017.customer - customer2016.customer)/ customer2016.customer as  customer_change_17_16,
		(customer2016.customer - customer2015.customer)/ customer2015.customer as  customer_change_16_15,
        (customer2015.customer - customer2014.customer)/ customer2014.customer as  customer_change_15_14
From customer2017, customer2016, customer2015, customer2014;

# Sales by country
Select country, sum(Sales) as 'Total Sales'
From data1.eu_superstore_new
group by 1
order by 2 DESC;

# Total profit by country
Select country, sum(profit) as Profit
From data1.eu_superstore_new
#Where Year(OrderDate)=2017
group by 1
order by 2 DESC;

# Sales by region
select region, sum(sales) as sales
From data1.eu_superstore_new
group by 1
order by 2 DESC;

# Sales by segment
select segment, sum(sales) as sales
From data1.eu_superstore_new
group by 1
order by 2 DESC;

# Sales by region
select category, sum(sales) as sales
From data1.eu_superstore_new
group by 1
order by 2 DESC