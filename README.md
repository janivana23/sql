# Apple Sales Data Analysis (SQL Portfolio Project)

## Project Overview
This project analyzes an **Apple product sales dataset** using SQL to extract insights about revenue performance, customer behavior, and sales trends.

The goal is to demonstrate practical **data analyst SQL skills** by answering real business questions through structured queries.

The analysis progresses from **basic exploratory analysis** to **advanced analytical SQL techniques**, similar to how a data analyst would approach a real dataset.

---

## Key Objectives
- Explore and understand the dataset structure
- Identify key revenue drivers
- Analyze customer purchasing behavior
- Evaluate discount effectiveness
- Identify high-performing regions, products, and sales channels

---

# Dataset Description
The dataset contains transactional sales data for Apple products across multiple regions and channels.

Each row represents a **single sales transaction**.

## Main Columns
- `sale_id` – Unique identifier for each transaction
- `sale_date` – Date when the sale occurred
- `product_name` – Apple product sold
- `category` – Product category
- `units_sold` – Number of units sold
- `revenue_usd` – Revenue generated from the sale
- `discount_pct` – Discount percentage applied
- `discounted_price_usd` – Final price after discount
- `customer_segment` – Individual or Business customer
- `customer_age_group` – Age demographic group
- `customer_rating` – Product rating from the customer
- `sales_channel` – Channel used to purchase the product
- `payment_method` – Payment method used
- `region`, `country`, `city` – Geographic location of the sale
- `return_status` – Indicates if the product was returned

---

# Project Structure


- `analysis.sql`
  - Contains all SQL queries used in the analysis.

- `README.md`
  - Documentation explaining the project and analytical approach.

---

# Analysis Workflow

The SQL analysis is organized into **five levels**, simulating how a data analyst approaches a real business dataset.

---

## 1. Basic Exploration (EDA)

Initial queries are used to understand the dataset and verify its structure.

### Questions Answered
- How many total sales records exist?
- What is the earliest and latest sale date?
- How many products are sold?
- How many countries are included in the dataset?
- How many transactions have missing ratings?
- What percentage of products were returned?

### Purpose
- Validate data quality
- Understand dataset coverage
- Identify potential data issues

---

## 2. Business Insights

This section focuses on identifying **core business performance metrics**.

### Key Analyses
- Total revenue generated
- Revenue by product category
- Top 10 products by revenue
- Highest revenue generating region
- Monthly revenue trends
- Best performing sales channel
- Most frequently used payment method

### Business Value
These metrics provide a **high-level view of company performance** and help identify where the business generates the most revenue.

---

## 3. Analytical Challenges

This section explores deeper **customer and operational insights**.

### Key Analyses
- Impact of discounts on revenue per sale
- Spending patterns by customer segment
- Purchasing behavior by age group
- Return rate by product category
- Country-level sales performance
- Cities generating the highest revenue

### Business Value
These insights help businesses understand:
- customer purchasing behavior
- product performance
- regional demand patterns

---

## 4. Advanced SQL Analysis

This section demonstrates **advanced SQL techniques used by data analysts**.

### Techniques Used
- Window functions
- Subqueries
- Aggregations
- Revenue contribution analysis
- Growth calculations

### Example Analyses
- Top product by revenue in each country
- Revenue contribution by product category
- Customer satisfaction analysis using ratings
- Month-over-month revenue growth
- Revenue performance across discount ranges

---

## 5. Real Data Analyst Scenarios

This section simulates **real business questions commonly asked in companies**.

### Business Questions
- Which region and product category combination generates the most revenue?
- Which sales channel performs best in each region?
- Do business customers buy more expensive products than individual customers?
- What percentage of revenue comes from premium products?

### Purpose
These analyses demonstrate how SQL can support **data-driven decision making**.

---

# Bonus Analysis

## Sales KPI Table
A summary table showing key monthly metrics:

- Year
- Month
- Total orders
- Total units sold
- Total revenue
- Average order value

These KPIs are commonly used in **business dashboards and reporting systems**.

---

### Potential Uses
- Detect demand spikes
- Identify promotional campaign impacts
- Discover potential data anomalies

---

# Skills Demonstrated

## SQL Skills
- Data exploration
- Aggregations (`SUM`, `AVG`, `COUNT`)
- `GROUP BY` analysis
- `CASE` statements
- Window functions (`LAG`)
- Subqueries
- Joins
- KPI calculations
- Data segmentation

## Analytical Skills
- Business metric identification
- Revenue analysis
- Customer behavior analysis
- Sales trend analysis
- Operational insights

---

# Potential Extensions

This project could be expanded with:

- Power BI or Tableau dashboards
- Python data analysis
- Time series forecasting
- Customer segmentation
- Machine learning models for demand prediction

---

# Author

**Janice Ivana**

- Bachelor of Computer Science (Data Science)
- Skills: SQL, Python, Data Analysis, Data Visualization
- Interested in data-driven business insights and analytics
