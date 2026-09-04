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
