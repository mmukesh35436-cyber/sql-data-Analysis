-- SQL Basics
-- Author: Mukesh Singh

USE sales_analysis;

-- View All Sales
SELECT *
FROM sales;

-- Total Sales
SELECT SUM(sales) AS total_sales
FROM sales;

-- Total Orders
SELECT COUNT(*) AS total_orders
FROM sales;

-- Unique Products
SELECT COUNT(DISTINCT product) AS unique_products
FROM sales;

-- Most Expensive Product
SELECT
    product,
    MAX(unit_price) AS highest_unit_price
FROM sales
GROUP BY product
ORDER BY highest_unit_price DESC
LIMIT 1;
