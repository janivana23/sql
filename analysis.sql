/* =========================================================
   APPLE SALES DATA ANALYSIS
   SQL Portfolio Project
   ========================================================= */


/* =========================================================
   LEVEL 1 — BASIC EXPLORATION (EDA)
   ========================================================= */

-- 1. Dataset size
SELECT COUNT(*) AS total_records
FROM apple_sales;


-- 2. Date range
SELECT 
    MIN(sale_date) AS earliest_sale,
    MAX(sale_date) AS latest_sale
FROM apple_sales;


-- 3. Product diversity
SELECT 
    COUNT(DISTINCT product_name) AS total_products
FROM apple_sales;


-- 4. Countries included
SELECT 
    COUNT(DISTINCT country) AS total_countries
FROM apple_sales;


-- 5. Missing ratings
SELECT 
    COUNT(customer_rating) AS missing_ratings
FROM apple_sales
WHERE customer_rating = 0;


-- 6. Returns percentage
SELECT 
    return_status,
    COUNT(*) AS total_orders,
    ROUND(
        COUNT(*) * 100 /
        (SELECT COUNT(*) FROM apple_sales),
        2
    ) AS percentage
FROM apple_sales
GROUP BY return_status;



/* =========================================================
   LEVEL 2 — BUSINESS INSIGHTS
   ========================================================= */

-- 7. Total revenue
SELECT 
    FORMAT(SUM(revenue_usd), 2) AS total_revenue_usd
FROM apple_sales;


-- 8. Revenue by category
SELECT 
    category,
    ROUND(SUM(revenue_usd)) AS total_revenue_usd
FROM apple_sales
GROUP BY category
ORDER BY total_revenue_usd DESC
LIMIT 1;


-- 9. Top 10 products by revenue
SELECT 
    product_name,
    SUM(revenue_usd) AS total_revenue
FROM apple_sales
GROUP BY product_name
ORDER BY total_revenue DESC
LIMIT 10;


-- 10. Revenue by region
SELECT 
    region,
    SUM(revenue_usd) AS highest_revenue
FROM apple_sales
GROUP BY region
ORDER BY highest_revenue DESC
LIMIT 1;


-- 11. Monthly revenue trend
SELECT 
    DATE_FORMAT(sale_date, '%Y-%m') AS month,
    SUM(revenue_usd) AS total_revenue
FROM apple_sales
GROUP BY DATE_FORMAT(sale_date, '%Y-%m')
ORDER BY month;


-- 12. Best sales channel
SELECT 
    sales_channel,
    SUM(revenue_usd) AS total_revenue
FROM apple_sales
GROUP BY sales_channel
ORDER BY total_revenue DESC
LIMIT 1;


-- 13. Most used payment method
SELECT 
    payment_method,
    COUNT(*) AS frequency
FROM apple_sales
GROUP BY payment_method
ORDER BY frequency DESC
LIMIT 1;



/* =========================================================
   LEVEL 3 — ANALYTICAL CHALLENGES
   ========================================================= */

-- 14. Discount impact
SELECT 
    CASE
        WHEN discount_pct = 0 THEN 'No Discount'
        ELSE 'Discounted'
    END AS discount_type,
    AVG(revenue_usd) AS avg_revenue_per_sale
FROM apple_sales
GROUP BY discount_type;


-- 15. Customer segments spending
SELECT 
    customer_segment,
    SUM(discounted_price_usd) AS total_spending
FROM apple_sales
GROUP BY customer_segment
ORDER BY total_spending DESC
LIMIT 1;


-- 16. Age group behavior
SELECT 
    customer_age_group,
    SUM(units_sold) AS total_units
FROM apple_sales
GROUP BY customer_age_group
ORDER BY total_units DESC
LIMIT 1;


-- 17. Return rate by category
SELECT 
    category,
    ROUND(
        SUM(CASE WHEN return_status LIKE 'Returned%' THEN 1 ELSE 0 END) * 100
        / COUNT(*),
        2
    ) AS return_rate
FROM apple_sales
GROUP BY category
ORDER BY return_rate DESC
LIMIT 1;


-- 18. Country performance
SELECT 
    country,
    SUM(revenue_usd) AS total_revenue,
    SUM(units_sold) AS total_units,
    ROUND(SUM(revenue_usd) / SUM(units_sold), 2) AS avg_order_value
FROM apple_sales
GROUP BY country
ORDER BY total_revenue DESC;


-- 19. Best city
SELECT 
    city,
    SUM(revenue_usd) AS total_revenue
FROM apple_sales
GROUP BY city
ORDER BY total_revenue DESC
LIMIT 1;



/* =========================================================
   LEVEL 4 — ADVANCED SQL
   ========================================================= */

-- 20. Top product per country
SELECT 
    pt.country,
    pt.product_name,
    pt.total_revenue
FROM (
    SELECT 
        country,
        product_name,
        SUM(revenue_usd) AS total_revenue
    FROM apple_sales
    GROUP BY country, product_name
) pt
JOIN (
    SELECT 
        country,
        MAX(total_revenue) AS max_revenue
    FROM (
        SELECT 
            country,
            product_name,
            SUM(revenue_usd) AS total_revenue
        FROM apple_sales
        GROUP BY country, product_name
    ) totals
    GROUP BY country
) max_pt
ON pt.country = max_pt.country
AND pt.total_revenue = max_pt.max_revenue
ORDER BY pt.country;


-- 21. Revenue contribution by category
SELECT 
    category,
    ROUND(
        SUM(revenue_usd) * 100 /
        (SELECT SUM(revenue_usd) FROM apple_sales),
        2
    ) AS revenue_percentage
FROM apple_sales
GROUP BY category
ORDER BY revenue_percentage DESC;


-- 22. Customer satisfaction by category
SELECT 
    category,
    AVG(customer_rating) AS avg_rating
FROM apple_sales
WHERE customer_rating > 0
GROUP BY category
ORDER BY avg_rating DESC;


-- 23. Month-over-month revenue growth
SELECT
    DATE_FORMAT(sale_date, '%Y-%m') AS yearmonth,
    SUM(revenue_usd) AS total_revenue,
    LAG(SUM(revenue_usd))
        OVER (ORDER BY DATE_FORMAT(sale_date, '%Y-%m')) AS prev_month_revenue,
    ROUND(
        (
            SUM(revenue_usd) -
            LAG(SUM(revenue_usd))
            OVER (ORDER BY DATE_FORMAT(sale_date, '%Y-%m'))
        )
        /
        LAG(SUM(revenue_usd))
        OVER (ORDER BY DATE_FORMAT(sale_date, '%Y-%m')) * 100,
        2
    ) AS mom_growth_pct
FROM apple_sales
GROUP BY DATE_FORMAT(sale_date, '%Y-%m')
ORDER BY yearmonth;


-- 24. Discount efficiency
SELECT 
    CASE
        WHEN discount_pct = 0 THEN '0%'
        WHEN discount_pct BETWEEN 1 AND 5 THEN '1-5%'
        WHEN discount_pct BETWEEN 6 AND 10 THEN '6-10%'
        WHEN discount_pct BETWEEN 11 AND 15 THEN '11-15%'
        WHEN discount_pct > 15 THEN '15%+'
    END AS discount_group,
    SUM(revenue_usd) AS total_revenue
FROM apple_sales
GROUP BY discount_group
ORDER BY total_revenue DESC;



/* =========================================================
   LEVEL 5 — REAL DATA ANALYST SCENARIOS
   ========================================================= */

-- 25. Best region + category combination
SELECT 
    region,
    category,
    SUM(revenue_usd) AS total_revenue
FROM apple_sales
GROUP BY region, category
ORDER BY total_revenue DESC;


-- 26. Best sales channel per region
SELECT 
    pt.region,
    pt.sales_channel,
    pt.total_revenue
FROM (
    SELECT 
        sales_channel,
        region,
        SUM(revenue_usd) AS total_revenue
    FROM apple_sales
    GROUP BY sales_channel, region
) pt
JOIN (
    SELECT 
        region,
        MAX(total_revenue) AS max_revenue
    FROM (
        SELECT 
            sales_channel,
            region,
            SUM(revenue_usd) AS total_revenue
        FROM apple_sales
        GROUP BY sales_channel, region
    ) totals
    GROUP BY region
) max_pt
ON pt.region = max_pt.region
AND pt.total_revenue = max_pt.max_revenue
ORDER BY pt.region;


-- 27. Customer behavior comparison
SELECT
    customer_segment,
    ROUND(AVG(revenue_usd), 2) AS avg_revenue_per_sale,
    MAX(revenue_usd) AS max_revenue,
    MIN(revenue_usd) AS min_revenue,
    COUNT(*) AS total_sales
FROM apple_sales
WHERE UPPER(customer_segment) IN ('INDIVIDUAL', 'BUSINESS')
GROUP BY customer_segment
ORDER BY avg_revenue_per_sale DESC;


-- 28. Premium product revenue percentage
SELECT 
    ROUND(
        SUM(CASE WHEN revenue_usd > 1000 THEN revenue_usd ELSE 0 END)
        / SUM(revenue_usd) * 100,
        2
    ) AS percentage_above_1k_revenue
FROM apple_sales;



/* =========================================================
   BONUS — PORTFOLIO KPI ANALYSIS
   ========================================================= */

-- 29. Sales KPI table
SELECT 
    year,
    month,
    COUNT(*) AS total_orders,
    SUM(units_sold) AS total_units,
    SUM(revenue_usd) AS total_revenue,
    ROUND(SUM(revenue_usd) / COUNT(*), 2) AS avg_order_value
FROM apple_sales
GROUP BY year, month
ORDER BY year, month;


-- 30. Detect unusual sales
SELECT 
    a.sale_id,
    a.product_name,
    a.units_sold,
    b.avg_units_sold
FROM apple_sales a
JOIN (
    SELECT 
        product_name,
        AVG(units_sold) AS avg_units_sold
    FROM apple_sales
    GROUP BY product_name
) b
ON a.product_name = b.product_name
WHERE a.units_sold > 2 * b.avg_units_sold
ORDER BY a.product_name, a.units_sold DESC;