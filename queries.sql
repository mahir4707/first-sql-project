-- ============================================
-- 📦 Database Table Structures
-- ============================================

-- Customer Data Table
CREATE TABLE customer_data (
    num             SERIAL PRIMARY KEY,
    customer_id     VARCHAR(10),
    age             INT,
    city            VARCHAR(50),
    card_type       VARCHAR(20),
    credit_limit    NUMERIC(10, 2),
    company         VARCHAR(50),
    job_segment     VARCHAR(50)
);

-- Transaction Data Table
CREATE TABLE customer_transactions (
    sl_no             SERIAL PRIMARY KEY,
    customer_id       VARCHAR(10),
    transaction_date  DATE,
    amount            NUMERIC(12, 2)
);
SET datestyle = 'ISO, DMY';

-- Purchase Data Table
CREATE TABLE customer_purchases (
    sl_no             SERIAL PRIMARY KEY,
    customer_id       VARCHAR(10),
    purchase_date     DATE,
    product_type      VARCHAR(50),
    amount            NUMERIC(12, 2)
);

-- ============================================
-- 🔰 Basic Queries
-- ============================================

-- 1. List all customers with their age and city
SELECT customer_id, age, city 
FROM customer_data;

-- 2. Find unique card types available
SELECT DISTINCT card_type 
FROM customer_data;

-- 3. Get customers above a certain age (e.g., 60)
SELECT customer_id, age
FROM customer_data
WHERE age > 60;

-- 4. Sort customers by credit limit in descending order
SELECT customer_id, credit_limit
FROM customer_data
ORDER BY credit_limit DESC;

-- 5. Count how many customers belong to each job segment
SELECT job_segment, COUNT(*) AS count
FROM customer_data
GROUP BY job_segment;

-- 6. Show all transactions made by a specific customer
SELECT *
FROM customer_transactions
WHERE customer_id = 'A58';

-- 7. Display purchases made on a particular date
SELECT *
FROM customer_purchases 
WHERE purchase_date = '25-01-2004';

-- 8. List all unique cities customers are from
SELECT DISTINCT city 
FROM customer_data;

-- 9. Show customers with credit limit more than ₹1,00,000
SELECT * 
FROM customer_data
WHERE credit_limit > 100000;

-- 10. Retrieve all customers with a specific card type
SELECT * 
FROM customer_data
WHERE card_type = 'Gold';

-- ============================================
-- ⚙️ Intermediate Queries
-- ============================================

-- 1. Calculate total transaction amount per customer
SELECT customer_id, SUM(amount) AS total_transaction
FROM customer_transactions
GROUP BY customer_id
ORDER BY customer_id DESC;

-- 2. Calculate average purchase amount per product type
SELECT product_type, AVG(amount) AS avg_amount 
FROM customer_purchases
GROUP BY product_type;

-- 3. Count number of transactions made each month in 2005
SELECT EXTRACT(MONTH FROM transaction_date) AS month, COUNT(*) AS total 
FROM customer_transactions
WHERE EXTRACT(YEAR FROM transaction_date) = 2005
GROUP BY month
ORDER BY month;

-- 4. Show the top 5 customers by total transaction amount
SELECT customer_id, SUM(amount) AS total_transaction 
FROM customer_transactions
GROUP BY customer_id
ORDER BY total_transaction DESC
LIMIT 5;

-- 5. Find customers who have both transactions and purchases
SELECT DISTINCT cp.customer_id 
FROM customer_purchases cp
JOIN customer_transactions ct ON cp.customer_id = ct.customer_id;

-- 6. Display product types purchased by each customer
SELECT customer_id, customer_id_num, product_type
FROM customer_purchases
ORDER BY customer_id_num;

-- Create numeric version of customer ID
ALTER TABLE customer_purchases
ADD COLUMN customer_id_num INT GENERATED ALWAYS AS (CAST(SUBSTRING(customer_id FROM 2) AS INTEGER)) STORED;

-- 7. Identify customers who made transactions in January 2005
SELECT DISTINCT customer_id
FROM customer_transactions
WHERE transaction_date BETWEEN '2005-01-01' AND '2005-01-31';

-- 8. Find how many different products each customer purchased
SELECT customer_id, COUNT(DISTINCT product_type) AS product_count
FROM customer_purchases
GROUP BY customer_id;

-- 9. Get customer’s age, credit limit, and total transaction value
SELECT DISTINCT cd.customer_id, cd.customer_id_num, cd.age, cd.credit_limit, 
       SUM(ct.amount) AS total_transactions
FROM customer_data cd
JOIN customer_transactions ct ON cd.customer_id = ct.customer_id
GROUP BY cd.customer_id, cd.age, cd.credit_limit, cd.customer_id_num
ORDER BY customer_id_num;

-- 10. Find the most popular product type by number of purchases
SELECT product_type, COUNT(product_type) AS num_of_purchases
FROM customer_purchases
GROUP BY product_type
ORDER BY num_of_purchases DESC
LIMIT 1;

-- ============================================
-- 🚀 Advanced Queries
-- ============================================

-- 🔹 Window Functions

-- 1. Rank customers by total transaction amount
SELECT customer_id, SUM(amount) AS total_amount,
       RANK() OVER (ORDER BY SUM(amount) DESC) AS rank_by_total
FROM customer_transactions
GROUP BY customer_id;

-- 2. Show cumulative transaction amount per customer
SELECT customer_id, transaction_date, amount,
       SUM(amount) OVER (PARTITION BY customer_id ORDER BY transaction_date) AS running_total
FROM customer_transactions;

-- 3. Show difference between each customer’s transaction and their average
SELECT customer_id, transaction_date, amount,
       amount - AVG(amount) OVER (PARTITION BY customer_id) AS difference_from_avg
FROM customer_transactions;

-- 🔹 Common Table Expressions (CTE)

-- 1. Use a CTE to find customers with total purchase amount above ₹3,00,000
WITH sum_amt AS ( 
    SELECT customer_id, SUM(amount) AS total_purchase 	
    FROM customer_purchases
    GROUP BY customer_id
)
SELECT * 
FROM sum_amt
WHERE total_purchase > 300000
ORDER BY customer_id;

-- 2. Use a CTE to identify customers with multiple transactions in a single month
WITH monthly_transactions AS (
    SELECT customer_id,
           DATE_TRUNC('month', transaction_date) AS transaction_month,
           COUNT(*) AS transaction_count
    FROM customer_transactions
    GROUP BY customer_id, DATE_TRUNC('month', transaction_date)
)
SELECT *
FROM monthly_transactions
WHERE transaction_count > 1;

-- 🔹 CASE WHEN Logic

-- 1. Label customers as 'High', 'Medium', or 'Low' spenders
SELECT customer_id, SUM(amount) AS total_amount,
       CASE 
         WHEN SUM(amount) <= 450000 THEN 'Low'
         WHEN SUM(amount) BETWEEN 4500001 AND 5500000 THEN 'Medium'
         ELSE 'High'
       END AS amount_category
FROM customer_transactions
GROUP BY customer_id;

-- 2. Classify customers by age group
SELECT customer_id, age,
       CASE 
         WHEN age BETWEEN 13 AND 24 THEN 'Youth'
         WHEN age BETWEEN 25 AND 59 THEN 'Adult'
         WHEN age >= 60 THEN 'Senior'
       END AS age_group
FROM customer_data;

-- 🔹 Data Cleaning & Formatting

-- 1. Trim extra spaces in product types
SELECT TRIM(product_type) AS cleaned_product
FROM customer_purchases
GROUP BY product_type;

-- 2. Convert card_type to uppercase
SELECT DISTINCT UPPER(card_type) AS card_types
FROM customer_data;

-- 🔹 UNION / INTERSECT

-- 1. Get all unique customer IDs from transactions and purchases
SELECT customer_id FROM customer_transactions
UNION
SELECT customer_id FROM customer_purchases;

-- 2. Find customers who appear in both transactions and purchases
SELECT customer_id FROM customer_transactions
INTERSECT
SELECT customer_id FROM customer_purchases;

-- 🔹 Date Functions

-- 1. Extract month and year from transaction dates
SELECT 
  EXTRACT(MONTH FROM transaction_date) AS month,
  EXTRACT(YEAR FROM transaction_date) AS year
FROM customer_transactions;

-- 2. Group total transaction amount by year and month
SELECT 
  EXTRACT(MONTH FROM transaction_date) AS month,
  EXTRACT(YEAR FROM transaction_date) AS year,
  SUM(amount) AS total_amt
FROM customer_transactions 
GROUP BY year, month
ORDER BY year, month;
