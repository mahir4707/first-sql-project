# 📊 Customer Insights with SQL – Data Analysis Project

Welcome to my SQL project! In this repository, I’ve explored a customer-based transactional dataset using **PostgreSQL** to uncover meaningful insights that can help businesses better understand their users, optimize performance, and personalize offerings.

This project is not just about running queries — it’s about asking the right questions and turning raw data into clear, actionable answers. 💡

---

## 📁 Dataset Overview

The dataset is divided into three main tables:

- `customer_data` – Includes demographic and financial info like age, city, job segment, and credit limit.
- `customer_transactions` – Holds transaction history, including amounts and dates.
- `customer_purchases` – Records each product purchase by the customers.

---

## 🧠 What I Did

I wrote SQL queries across three levels of difficulty to demonstrate core data analysis skills using PostgreSQL:

---

### 🔰 Basic Queries
Simple queries to explore and understand the data.
- List all customers with their age and city.
- Find unique card types.
- Get customers above age 60.
- Sort customers by credit limit.
- Count customers per job segment.
- And more...

---

### ⚙️ Intermediate Queries
Grouped data, applied transformations, and used built-in functions.
- Calculate total transaction amount per customer.
- Average purchase amount per product type.
- Top 5 customers by spending.
- Count monthly transactions.
- Find customers active in both transactions and purchases.
- Clean data using `TRIM()` and `UPPER()`.
- Handle NULLs and format date fields.
- And more...

---

### 🚀 Advanced Queries
Took the analysis up a notch with window functions, CTEs, and logic-based segmentation.
- Rank customers by transaction amount.
- Running totals (cumulative spend).
- Deviation from customer average.
- Segment customers as 'High', 'Medium', or 'Low' spenders.
- Group customers into 'Youth', 'Adult', and 'Senior'.
- Use `UNION` and `INTERSECT` to compare datasets.
- Analyze transaction trends by month and year.

---

## 🧪 Sample Techniques Used

- `CASE WHEN` for categorization
- `CTEs` for modular query building
- `Window Functions` for rankings and cumulative values
- `EXTRACT()` and `DATE_TRUNC()` for time-based analysis
- `JOIN`, `UNION`, `INTERSECT` to bring tables together
- `COALESCE`, `TRIM`, `UPPER` for data cleaning

---

## 📌 Bonus: Performance Tips

For faster query execution, indexing key columns like `customer_id` and `transaction_date` can drastically improve performance — especially on large datasets. Proper indexing allows PostgreSQL to avoid full table scans and fetch only the relevant rows quickly.

---

## 🔧 Tools Used

- 🐘 PostgreSQL (via pgAdmin 4)
- 🖥️ VS Code (for writing and formatting queries)
- 📄 Git & GitHub (for version control and project showcase)

---

## 📎 How to Use

1. Clone this repo
2. Open your PostgreSQL client (e.g., pgAdmin)
3. Import the data (CSV or SQL dump if available)
4. Run the queries from the `sql_queries.sql` file step-by-step
5. Explore and modify to dig deeper!

---

## 🙋‍♂️ About Me

Hi! I’m Mahir Mustakbhai Sama, a data enthusiast and aspiring analyst who enjoys solving problems using clean logic and creative thinking. I'm currently learning, building, and sharing everything I know — one query at a time. 😊

Let’s connect on [LinkedIn](https://www.linkedin.com/in/mahir-sama-7432902a5) or check out my other projects!

---

## ⭐ If You Like It...

Don’t forget to **star ⭐ this repo** to support my work!

---

## 📬 Contact

Feel free to open an issue, fork the repo, or message me if you’d like to collaborate or just say hi!

