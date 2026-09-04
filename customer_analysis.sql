-- Customer Analysis
-- Author: Mukesh Singh

USE sales_analysis;

-- 1. Customer and Sales Information
SELECT
    c.customer_id,
    c.customer_name,
    c.region,
    s.order_id,
    s.product,
    s.sales
FROM customers c
LEFT JOIN sales s
    ON c.region = s.region
ORDER BY c.customer_id;

-- 2. Sales by Customer Region
SELECT
    c.region,
    COUNT(s.order_id) AS total_orders,
    SUM(s.sales) AS total_sales
FROM customers c
LEFT JOIN sales s
    ON c.region = s.region
GROUP BY c.region
ORDER BY total_sales DESC;
