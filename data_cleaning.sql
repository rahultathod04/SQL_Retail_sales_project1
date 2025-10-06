-- FIND NULL VALUES
SELECT * 
FROM retail_sales
WHERE transactions_id IS NULL 
   OR sale_date IS NULL 
   OR sale_time IS NULL 
   OR category IS NULL 
   OR gender IS NULL 
   OR quantiy IS NULL 
   OR total_sale IS NULL 
   OR cogs IS NULL;

-- DELETE NULL ROWS
DELETE FROM retail_sales
WHERE transactions_id IS NULL 
   OR sale_date IS NULL 
   OR sale_time IS NULL 
   OR category IS NULL 
   OR gender IS NULL 
   OR quantiy IS NULL 
   OR total_sale IS NULL 
   OR cogs IS NULL;
