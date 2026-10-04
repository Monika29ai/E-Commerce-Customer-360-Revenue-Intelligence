-- Select the database
USE project;

-- Show all tables in the database
SHOW TABLES;

-- View all records and columns from the customer dataset
SELECT *
FROM customer_analysis_cleaned_one;


-- 1. Count the total number of customers
SELECT COUNT(customer_id) AS Customer_Total
FROM customer_analysis_cleaned_one;


-- 2. Count customers in each customer segment
SELECT
    customer_segment,
    COUNT(*) AS Total_Customers
FROM customer_analysis_cleaned_one
GROUP BY customer_segment
ORDER BY Total_Customers DESC;


-- 3. Count customers by gender
SELECT
    gender,
    COUNT(*) AS Total_Customers
FROM customer_analysis_cleaned_one
GROUP BY gender
ORDER BY Total_Customers DESC;


-- 4. Count customers by country
SELECT
    country,
    COUNT(*) AS Total_Customers
FROM customer_analysis_cleaned_one
GROUP BY country
ORDER BY Total_Customers DESC;


-- 5. Count customers in each loyalty tier
SELECT
    loyalty_tier,
    COUNT(*) AS Total_Customers
FROM customer_analysis_cleaned_one
GROUP BY loyalty_tier
ORDER BY Total_Customers DESC;


-- 6. Find the top 10 customers by total spending
SELECT
    customer_id,
    total_spent_usd
FROM customer_analysis_cleaned_one
ORDER BY total_spent_usd DESC
LIMIT 10;


-- 7. Find the top 10 customers by Customer Lifetime Value (CLV)
SELECT
    customer_id,
    customer_lifetime_value_usd
FROM customer_analysis_cleaned_one
ORDER BY customer_lifetime_value_usd DESC
LIMIT 10;


-- 8. Find the top 10 customers by profitability
SELECT
    customer_id,
    customer_profitability_usd
FROM customer_analysis_cleaned_one
ORDER BY customer_profitability_usd DESC
LIMIT 10;


-- 9. Calculate total spending for each customer segment
SELECT
    customer_segment,
    SUM(total_spent_usd) AS Total_Spent
FROM customer_analysis_cleaned_one
GROUP BY customer_segment
ORDER BY Total_Spent DESC;


-- 10. Calculate average CLV for each customer segment
SELECT
    customer_segment,
    AVG(customer_lifetime_value_usd) AS Avg_CLV
FROM customer_analysis_cleaned_one
GROUP BY customer_segment
ORDER BY Avg_CLV DESC;


-- 11. Count customers in each CLV category
SELECT
    clv_category,
    COUNT(*) AS Total_Customers
FROM customer_analysis_cleaned_one
GROUP BY clv_category
ORDER BY Total_Customers DESC;


-- 12. Find the RFM category with the highest total spending
SELECT
    rfm_category,
    SUM(total_spent_usd) AS Total_Spent
FROM customer_analysis_cleaned_one
GROUP BY rfm_category
ORDER BY Total_Spent DESC
LIMIT 1;


-- 13. Count customers in each churn-risk category
SELECT
    churn_risk_category,
    COUNT(*) AS Total_Customers
FROM customer_analysis_cleaned_one
GROUP BY churn_risk_category
ORDER BY Total_Customers DESC;


-- 14. Find the preferred category with the highest total purchases
SELECT
    preferred_category_1,
    SUM(total_purchases) AS Total_Purchases
FROM customer_analysis_cleaned_one
GROUP BY preferred_category_1
ORDER BY Total_Purchases DESC
LIMIT 1;


-- 15. Find the shopping channel with the highest average CLV
SELECT
    shopping_channel,
    AVG(customer_lifetime_value_usd) AS Avg_CLV
FROM customer_analysis_cleaned_one
GROUP BY shopping_channel
ORDER BY Avg_CLV DESC
LIMIT 1;


-- 16. Classify customers into High, Medium, and Low Value based on CLV
SELECT
    customer_id,
    customer_lifetime_value_usd,
    CASE
        WHEN customer_lifetime_value_usd >= 10000 THEN 'High Value'
        WHEN customer_lifetime_value_usd >= 5000 THEN 'Medium Value'
        ELSE 'Low Value'
    END AS customer_value_classification
FROM customer_analysis_cleaned_one;


-- 17. Find customer segments with total spending greater than $1,000,000
SELECT
    customer_segment,
    SUM(total_spent_usd) AS total_spent
FROM customer_analysis_cleaned_one
GROUP BY customer_segment
HAVING total_spent > 1000000;


-- 18. Find customers whose spending is greater than the overall average spending
SELECT
    customer_id,
    total_spent_usd
FROM customer_analysis_cleaned_one
WHERE total_spent_usd > (
    SELECT AVG(total_spent_usd)
    FROM customer_analysis_cleaned_one
);


-- 19. Find customers whose CLV is greater than the average CLV
-- of their own customer segment
SELECT
    c.customer_id,
    c.customer_segment,
    c.customer_lifetime_value_usd,
    s.avg_clv
FROM customer_analysis_cleaned_one c
JOIN (
    SELECT
        customer_segment,
        AVG(customer_lifetime_value_usd) AS avg_clv
    FROM customer_analysis_cleaned_one
    GROUP BY customer_segment
) s
ON c.customer_segment = s.customer_segment
WHERE c.customer_lifetime_value_usd > s.avg_clv;


-- 20. Find segments whose average CLV is greater than
-- the overall average CLV
WITH larger_segments AS (
    SELECT
        customer_segment,
        AVG(customer_lifetime_value_usd) AS avg_clv
    FROM customer_analysis_cleaned_one
    GROUP BY customer_segment
    HAVING AVG(customer_lifetime_value_usd) > (
        SELECT AVG(customer_lifetime_value_usd)
        FROM customer_analysis_cleaned_one
    )
)
SELECT *
FROM larger_segments;


-- 21. Calculate total spending, total profitability,
-- and average CLV for each customer segment
WITH segment_analysis AS (
    SELECT
        customer_segment,
        SUM(total_spent_usd) AS total_spending,
        SUM(customer_profitability_usd) AS total_profitability,
        AVG(customer_lifetime_value_usd) AS avg_clv
    FROM customer_analysis_cleaned_one
    GROUP BY customer_segment
)
SELECT *
FROM segment_analysis;


-- 22. Rank all customers by CLV
-- Highest CLV receives rank 1
SELECT
    customer_id,
    customer_segment,
    customer_lifetime_value_usd,
    RANK() OVER (
        ORDER BY customer_lifetime_value_usd DESC
    ) AS `rank`
FROM customer_analysis_cleaned_one;


-- 23. Rank customers by CLV within each customer segment
-- Ranking starts again from 1 for every segment
SELECT
    customer_id,
    customer_segment,
    customer_lifetime_value_usd,
    RANK() OVER (
        PARTITION BY customer_segment
        ORDER BY customer_lifetime_value_usd DESC
    ) AS `rank`
FROM customer_analysis_cleaned_one;


-- 24. Rank customers by total spending using DENSE_RANK()
-- Return only the top 5 spending ranks
WITH ranked_customers AS (
    SELECT
        customer_id,
        total_spent_usd,
        DENSE_RANK() OVER (
            ORDER BY total_spent_usd DESC
        ) AS `rank`
    FROM customer_analysis_cleaned_one
)
SELECT
    customer_id,
    total_spent_usd,
    `rank`
FROM ranked_customers
WHERE `rank` <= 5
ORDER BY `rank`;


-- 25. Assign a unique row number to each customer based on CLV
SELECT
    customer_id,
    customer_lifetime_value_usd,
    ROW_NUMBER() OVER (
        ORDER BY customer_lifetime_value_usd DESC
    ) AS row_num
FROM customer_analysis_cleaned_one;


-- 26. Compare each customer's spending with the previous
-- customer based on spending order
SELECT
    customer_id,
    total_spent_usd,
    LAG(total_spent_usd) OVER (
        ORDER BY total_spent_usd DESC
    ) AS previous_spending,
    total_spent_usd
        - LAG(total_spent_usd) OVER (
            ORDER BY total_spent_usd DESC
        ) AS difference
FROM customer_analysis_cleaned_one;


-- 27. Calculate a running total of customer spending
SELECT
    customer_id,
    total_spent_usd,
    SUM(total_spent_usd) OVER (
        ORDER BY total_spent_usd DESC
    ) AS running_total
FROM customer_analysis_cleaned_one;


-- 28. Calculate each customer's percentage contribution
-- to the total spending
SELECT
    customer_id,
    total_spent_usd,
    ROUND(
        total_spent_usd * 100.0 /
        SUM(total_spent_usd) OVER (),
        2
    ) AS spending_percentage
FROM customer_analysis_cleaned_one;


-- 29. Calculate total spending by category
-- and rank the categories
WITH category_spending AS (
    SELECT
        preferred_category_1,
        SUM(total_spent_usd) AS total_spending
    FROM customer_analysis_cleaned_one
    GROUP BY preferred_category_1
)
SELECT
    preferred_category_1,
    total_spending,
    RANK() OVER (
        ORDER BY total_spending DESC
    ) AS `rank`
FROM category_spending;


-- 30. Find the top 3 highest-CLV customers within each segment
WITH ranked_customers AS (
    SELECT
        customer_id,
        customer_segment,
        customer_lifetime_value_usd,
        RANK() OVER (
            PARTITION BY customer_segment
            ORDER BY customer_lifetime_value_usd DESC
        ) AS `rank`
    FROM customer_analysis_cleaned_one
)
SELECT
    customer_id,
    customer_segment,
    customer_lifetime_value_usd,
    `rank`
FROM ranked_customers
WHERE `rank` <= 3
ORDER BY customer_segment, `rank`;