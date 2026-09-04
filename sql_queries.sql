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
