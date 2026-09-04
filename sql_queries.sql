-- SQL Data Analysis Project
-- Author: Mukesh Singh

-- Create Database
CREATE DATABASE sales_analysis;

USE sales_analysis;

-- Create Sales Table

CREATE TABLE sales (
    order_id INT PRIMARY KEY,
    product VARCHAR(50),
    category VARCHAR(50),
    region VARCHAR(50),
    quantity INT,
    unit_price DECIMAL(10,2),
    sales DECIMAL(12,2)
);
-- Insert Sales Data

INSERT INTO sales
(order_id, product, category, region, quantity, unit_price, sales)
VALUES
(1001, 'Laptop', 'Electronics', 'North', 2, 60000, 120000),
(1002, 'Mouse', 'Accessories', 'South', 5, 800, 4000),
(1003, 'Keyboard', 'Accessories', 'East', 3, 1500, 4500),
(1004, 'Monitor', 'Electronics', 'West', 2, 15000, 30000),
(1005, 'Laptop', 'Electronics', 'North', 1, 60000, 60000),
(1006, 'Mouse', 'Accessories', 'South', 8, 800, 6400),
(1007, 'Headphones', 'Accessories', 'East', 4, 2500, 10000),
(1008, 'Monitor', 'Electronics', 'West', 3, 15000, 45000),
(1009, 'Keyboard', 'Accessories', 'North', 6, 1500, 9000),
(1010, 'Laptop', 'Electronics', 'South', 2, 60000, 120000);
-- 1. View All Sales Data

SELECT *
FROM sales;

-- 2. Calculate Total Sales

SELECT SUM(sales) AS total_sales
FROM sales;

-- 3. Total Sales by Category

SELECT
    category,
    SUM(sales) AS total_sales
FROM sales
GROUP BY category
ORDER BY total_sales DESC;

-- 4. Total Sales by Region

SELECT
    region,
    SUM(sales) AS total_sales
FROM sales
GROUP BY region
ORDER BY total_sales DESC;

-- 5. Top-Selling Products

SELECT
    product,
    SUM(quantity) AS total_quantity_sold,
    SUM(sales) AS total_sales
FROM sales
GROUP BY product
ORDER BY total_sales DESC;

-- 6. Average Order Value

SELECT
    AVG(sales) AS average_order_value
FROM sales;

-- 7. Highest Revenue Product

SELECT
    product,
    SUM(sales) AS total_revenue
FROM sales
GROUP BY product
ORDER BY total_revenue DESC
LIMIT 1;

-- 8. High-Value Orders

SELECT
    order_id,
    product,
    region,
    sales
FROM sales
WHERE sales > 10000
ORDER BY sales DESC;

-- 9. Classify Orders by Sales Value

SELECT
    order_id,
    product,
    sales,
    CASE
        WHEN sales >= 50000 THEN 'High Value'
        WHEN sales >= 10000 THEN 'Medium Value'
        ELSE 'Low Value'
    END AS sales_category
FROM sales
ORDER BY sales DESC;

-- 10. Products with Sales Above 50000

SELECT
    product,
    SUM(sales) AS total_sales
FROM sales
GROUP BY product
HAVING SUM(sales) > 50000
ORDER BY total_sales DESC;

-- 11. Create Customers Table

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    region VARCHAR(50)
);

-- 12. Insert Customer Data

INSERT INTO customers
(customer_id, customer_name, region)
VALUES
(1, 'Rahul Sharma', 'North'),
(2, 'Priya Singh', 'South'),
(3, 'Amit Verma', 'East'),
(4, 'Neha Gupta', 'West'),
(5, 'Rohit Kumar', 'North'),
(6, 'Anjali Patel', 'South'),
(7, 'Vikas Yadav', 'East'),
(8, 'Pooja Mishra', 'West'),
(9, 'Arjun Singh', 'North'),
(10, 'Sneha Verma', 'South');

-- 13. INNER JOIN Sales with Customers

SELECT
    s.order_id,
    s.product,
    s.sales,
    c.customer_name,
    c.region
FROM sales s
INNER JOIN customers c
    ON s.region = c.region;

-- 14. LEFT JOIN Sales with Customers

SELECT
    s.order_id,
    s.product,
    s.sales,
    c.customer_name,
    c.region
FROM sales s
LEFT JOIN customers c
    ON s.region = c.region;

-- 15. Sales Analysis using CTE

WITH product_sales AS (
    SELECT
        product,
        SUM(sales) AS total_sales
    FROM sales
    GROUP BY product
)

SELECT
    product,
    total_sales
FROM product_sales
ORDER BY total_sales DESC;

-- 16. Rank Orders by Sales

SELECT
    order_id,
    product,
    sales,
    ROW_NUMBER() OVER (ORDER BY sales DESC) AS sales_rank
FROM sales
ORDER BY sales_rank;

-- 17. Rank Products by Total Sales

WITH product_sales AS (
    SELECT
        product,
        SUM(sales) AS total_sales
    FROM sales
    GROUP BY product
)

SELECT
    product,
    total_sales,
    RANK() OVER (ORDER BY total_sales DESC) AS sales_rank
FROM product_sales
ORDER BY sales_rank;

-- 18. Count Total Orders

SELECT
    COUNT(*) AS total_orders
FROM sales;

-- 19. Count Unique Products

SELECT
    COUNT(DISTINCT product) AS unique_products
FROM sales;

-- 20. Most Expensive Product

SELECT
    product,
    MAX(unit_price) AS highest_unit_price
FROM sales
GROUP BY product
ORDER BY highest_unit_price DESC
LIMIT 1;

-- 21. Products Above Average Sales

SELECT
    order_id,
    product,
    sales
FROM sales
WHERE sales > (
    SELECT AVG(sales)
    FROM sales
)
ORDER BY sales DESC;

-- 22. Products from Selected Regions

SELECT
    order_id,
    product,
    region,
    sales
FROM sales
WHERE region IN (
    SELECT region
    FROM customers
    WHERE customer_id IN (1, 2, 3)
)
ORDER BY sales DESC;

-- 23. Dense Rank Products

WITH product_sales AS (
    SELECT
        product,
        SUM(sales) AS total_sales
    FROM sales
    GROUP BY product
)

SELECT
    product,
    total_sales,
    DENSE_RANK() OVER (ORDER BY total_sales DESC) AS sales_rank
FROM product_sales
ORDER BY sales_rank;

-- 24. Compare Current Sale with Previous Sale

SELECT
    order_id,
    product,
    sales,
    LAG(sales) OVER (ORDER BY order_id) AS previous_sales
FROM sales
ORDER BY order_id;

-- 25. Compare Current Sale with Next Sale

SELECT
    order_id,
    product,
    sales,
    LEAD(sales) OVER (ORDER BY order_id) AS next_sales
FROM sales
ORDER BY order_id;

-- 26. Product Performance Summary

SELECT
    product,
    COUNT(*) AS total_orders,
    SUM(quantity) AS total_quantity,
    AVG(unit_price) AS average_price,
    SUM(sales) AS total_sales
FROM sales
GROUP BY product
ORDER BY total_sales DESC;

-- 27. Regional Performance Summary

SELECT
    region,
    COUNT(*) AS total_orders,
    SUM(quantity) AS total_quantity,
    SUM(sales) AS total_sales,
    AVG(sales) AS average_order_value
FROM sales
GROUP BY region
ORDER BY total_sales DESC;

-- 28. Category Performance Summary

SELECT
    category,
    COUNT(*) AS total_orders,
    SUM(quantity) AS total_quantity,
    SUM(sales) AS total_sales,
    AVG(sales) AS average_order_value
FROM sales
GROUP BY category
ORDER BY total_sales DESC;


