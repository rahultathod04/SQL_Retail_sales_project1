-- Q1: Sales on 2022-11-05
SELECT * 
FROM retail_sales
WHERE sale_date = '2022-11-05';

-- Q2: Clothing category with quantity >= 4 in Nov 2022
SELECT * 
FROM retail_sales
WHERE category = 'Clothing'
  AND quantiy >= '4'
  AND TO_CHAR(sale_date, 'YYYY-MM') = '2022-11';

-- Q3: Total and Net sales by category
SELECT category, 
       COUNT(total_sale) AS total_sales, 
       SUM(total_sale) AS net_sale
FROM retail_sales
GROUP BY category;

-- Q4: Avg age of customers buying Beauty
SELECT ROUND(AVG(age),2) AS avg_age
FROM retail_sales
WHERE category = 'Beauty';

-- Q5: Transactions > 1000
SELECT *
FROM retail_sales
WHERE total_sale > 1000;

-- Q6: Total transactions by gender & category
SELECT category, gender, COUNT(*) AS total_transactions
FROM retail_sales
GROUP BY category, gender
ORDER BY total_transactions DESC;

-- Q7: Best-selling month in each year
SELECT year, month, the_avg_sale 
FROM (
    SELECT EXTRACT(YEAR FROM sale_date) AS year,
           EXTRACT(MONTH FROM sale_date) AS month,
           AVG(total_sale) AS the_avg_sale,
           RANK() OVER(PARTITION BY EXTRACT(YEAR FROM sale_date) 
                       ORDER BY AVG(total_sale) DESC) AS rank
    FROM retail_sales
    GROUP BY year, month
) t
WHERE rank = 1;

-- Q8: Top 5 customers by sales
SELECT customer_id, SUM(total_sale) AS total_sales
FROM retail_sales
GROUP BY customer_id
ORDER BY total_sales DESC
LIMIT 5;

-- Q9: Unique customers per category
SELECT category, COUNT(DISTINCT customer_id) AS unique_customers
FROM retail_sales
GROUP BY category;

-- Q10: Shift-wise orders (Morning, Afternoon, Evening)
WITH Hourly_sale AS (
    SELECT *,
           CASE
             WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
             WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
             ELSE 'Evening'
           END AS shift
    FROM retail_sales
)
SELECT shift, COUNT(*) AS total_orders
FROM Hourly_sale
GROUP BY shift;

-- 11. Find the second highest sale
SELECT MAX(total_sale) AS second_highest_sale
FROM retail_sales
WHERE total_sale < (SELECT MAX(total_sale) FROM retail_sales);

-- 12. Find customers who purchased from more than 1 category
SELECT customer_id, COUNT(DISTINCT category) AS category_count
FROM retail_sales
GROUP BY customer_id
HAVING COUNT(DISTINCT category) > 1;

-- 13. Find top-selling category overall
SELECT category, SUM(total_sale) AS total_sales
FROM retail_sales
GROUP BY category
ORDER BY total_sales DESC
LIMIT 1;

-- 14. Get running total of sales (cumulative)
SELECT sale_date, SUM(total_sale) OVER (ORDER BY sale_date) AS running_total
FROM retail_sales;

