-- TOTAL SALES RECORDS
SELECT COUNT(*) AS total_sale 
FROM retail_sales;

-- UNIQUE CUSTOMERS
SELECT COUNT(DISTINCT customer_id) AS unique_customers
FROM retail_sales;

-- CATEGORIES
SELECT DISTINCT category
FROM retail_sales;
