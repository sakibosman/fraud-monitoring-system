-- FRAUD ANALYTICS SQL QUERIES
-- Dataset: Canadian Anti-Fraud Centre Reporting Data

-- 1. Overall Fraud Statistics
SELECT
    COUNT(*) AS total_reports,
    SUM(dollar_loss) AS total_dollar_loss,
    AVG(dollar_loss) AS average_loss
FROM transactions;

-- 2. Fraud Loss by Category
SELECT
    fraud_category,
    COUNT(*) AS total_reports,
    SUM(dollar_loss) AS total_loss
FROM transactions
GROUP BY fraud_category
ORDER BY total_loss DESC;

-- 4. Fraud by Solicitation Method
SELECT
    method,
    COUNT(*) AS total_reports,
    SUM(dollar_loss) AS total_loss
FROM transactions
GROUP BY method
ORDER BY total_loss DESC;

-- 5. Fraud Impact by Age Group
SELECT
    age_range,
    COUNT(*) AS total_reports,
    SUM(dollar_loss) AS total_loss
FROM transactions
GROUP BY age_range
ORDER BY total_loss DESC;

-- 6. Top 10 Largest Fraud Cases
SELECT
    transaction_id,
    date_received,
    country,
    province_state,
    fraud_category,
    method,
    age_range,
    complaint_type,
    dollar_loss
FROM transactions
ORDER BY dollar_loss DESC
LIMIT 10;

-- 7. Fraud Categories With Highest Average Loss
SELECT
    fraud_category,
    COUNT(*) AS total_reports,
    AVG(dollar_loss) AS avg_loss
FROM transactions
GROUP BY fraud_category
ORDER BY avg_loss DESC;

-- 8. Monthly Fraud Trends
SELECT
    DATE_TRUNC('month', date_received) AS month,
    COUNT(*) AS reports,
    SUM(dollar_loss) AS total_loss
FROM transactions
GROUP BY month
ORDER BY month;

-- 9. Percentage of Cases With Financial Loss
SELECT
    COUNT(*) AS total_cases,
    COUNT(CASE WHEN dollar_loss > 0 THEN 1 END) AS cases_with_loss,
    ROUND(
        100.0 * COUNT(CASE WHEN dollar_loss > 0 THEN 1 END) / COUNT(*),
        2
    ) AS percent_with_loss
FROM transactions;

-- 10. Most Common Fraud Methods
SELECT
    method,
    COUNT(*) AS frequency
FROM transactions
GROUP BY method
ORDER BY frequency DESC;