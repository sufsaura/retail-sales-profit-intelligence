-- ============================================================
-- Retail Sales & Profit Intelligence — Validation Queries
-- Purpose: independently re-derive key numbers in SQL to cross-check
-- the Python/pandas pipeline output before building the Power BI dashboard.
-- Run against retail_validation.db (built from data/processed/*.csv)
-- ============================================================

-- 1. Row count sanity check
SELECT COUNT(*) AS total_rows,
       COUNT(DISTINCT order_id) AS distinct_orders,
       COUNT(DISTINCT product_id) AS distinct_products,
       COUNT(DISTINCT customer_id) AS distinct_customers
FROM fact_sales;

-- 2. Overall revenue, cost, profit, margin
SELECT
    ROUND(SUM(price), 2) AS total_revenue,
    ROUND(SUM(cost), 2) AS total_cost,
    ROUND(SUM(profit), 2) AS total_profit,
    ROUND(SUM(profit) * 100.0 / SUM(price), 2) AS overall_margin_pct
FROM fact_sales;

-- 3. No null / negative price or profit (data integrity check)
SELECT
    SUM(CASE WHEN price IS NULL OR price <= 0 THEN 1 ELSE 0 END) AS bad_price_rows,
    SUM(CASE WHEN profit IS NULL THEN 1 ELSE 0 END) AS null_profit_rows,
    SUM(CASE WHEN profit_margin_pct < 0 OR profit_margin_pct > 100 THEN 1 ELSE 0 END) AS out_of_range_margin_rows
FROM fact_sales;

-- 4. Monthly revenue & profit trend (cross-check vs monthly_rollup.csv from pandas)
SELECT
    strftime('%Y-%m', order_purchase_timestamp) AS year_month,
    COUNT(DISTINCT order_id) AS orders,
    COUNT(*) AS items_sold,
    ROUND(SUM(price), 2) AS revenue,
    ROUND(SUM(profit), 2) AS profit,
    ROUND(SUM(profit) * 100.0 / SUM(price), 2) AS margin_pct
FROM fact_sales
GROUP BY year_month
ORDER BY year_month;

-- 5. Top 10 categories by revenue (cross-check vs category_rollup.csv from pandas)
SELECT
    product_category_name_english AS category,
    COUNT(*) AS items_sold,
    ROUND(SUM(price), 2) AS revenue,
    ROUND(SUM(profit), 2) AS profit,
    ROUND(SUM(profit) * 100.0 / SUM(price), 2) AS margin_pct
FROM fact_sales
GROUP BY category
ORDER BY revenue DESC
LIMIT 10;

-- 6. Revenue by customer state (for geo dashboard page)
SELECT
    customer_state,
    COUNT(DISTINCT order_id) AS orders,
    ROUND(SUM(price), 2) AS revenue,
    ROUND(SUM(profit), 2) AS profit
FROM fact_sales
GROUP BY customer_state
ORDER BY revenue DESC;

-- 7. Delivery performance summary
SELECT
    order_status,
    COUNT(*) AS order_items,
    ROUND(AVG(delivery_days), 1) AS avg_delivery_days,
    ROUND(AVG(CASE WHEN is_late = 1 THEN 1.0 ELSE 0.0 END) * 100, 2) AS pct_late
FROM fact_sales
GROUP BY order_status;

-- 8. Payment type breakdown
SELECT
    payment_type,
    COUNT(*) AS transactions,
    ROUND(SUM(price), 2) AS revenue,
    ROUND(AVG(payment_installments), 1) AS avg_installments
FROM fact_sales
GROUP BY payment_type
ORDER BY revenue DESC;

-- 9. Flag the incomplete final month (Sept 2018 — dataset cutoff, not a real drop)
SELECT strftime('%Y-%m', order_purchase_timestamp) AS year_month, COUNT(*) AS items_sold
FROM fact_sales
GROUP BY year_month
ORDER BY year_month DESC
LIMIT 3;
