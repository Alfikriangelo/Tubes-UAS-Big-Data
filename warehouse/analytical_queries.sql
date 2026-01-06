-- 1. Total transaksi
SELECT COUNT(*) AS total_transaksi
FROM dw.fact_credit_card_transactions;

-- 2. Total transaksi fraud
SELECT COUNT(*) AS total_fraud
FROM dw.fact_credit_card_transactions
WHERE is_fraud = 1;

-- 3. Persentase fraud
SELECT
    ROUND(
        COUNT(*) FILTER (WHERE is_fraud = 1)::NUMERIC /
        COUNT(*) * 100, 4
    ) AS fraud_rate_percent
FROM dw.fact_credit_card_transactions;

-- 4. Jumlah fraud per kategori
SELECT
    c.category_name,
    COUNT(*) AS fraud_count
FROM dw.fact_credit_card_transactions f
JOIN dw.dim_category c ON f.category_id = c.category_id
WHERE f.is_fraud = 1
GROUP BY c.category_name
ORDER BY fraud_count DESC;

-- 5. Fraud rate per kategori
SELECT
    c.category_name,
    ROUND(
        COUNT(*) FILTER (WHERE f.is_fraud = 1)::NUMERIC /
        COUNT(*) * 100, 4
    ) AS fraud_rate
FROM dw.fact_credit_card_transactions f
JOIN dw.dim_category c ON f.category_id = c.category_id
GROUP BY c.category_name
ORDER BY fraud_rate DESC;

-- 6. Fraud berdasarkan jam transaksi
SELECT
    t.hour,
    COUNT(*) AS fraud_count
FROM dw.fact_credit_card_transactions f
JOIN dw.dim_time t ON f.time_id = t.time_id
WHERE f.is_fraud = 1
GROUP BY t.hour
ORDER BY t.hour;

-- 7. Fraud rate per jam
SELECT
    t.hour,
    ROUND(
        COUNT(*) FILTER (WHERE f.is_fraud = 1)::NUMERIC /
        COUNT(*) * 100, 4
    ) AS fraud_rate
FROM dw.fact_credit_card_transactions f
JOIN dw.dim_time t ON f.time_id = t.time_id
GROUP BY t.hour
ORDER BY t.hour;

-- 8. Distribusi fraud berdasarkan lokasi (state)
SELECT
    l.state,
    COUNT(*) AS fraud_count
FROM dw.fact_credit_card_transactions f
JOIN dw.dim_location l ON f.location_id = l.location_id
WHERE f.is_fraud = 1
GROUP BY l.state
ORDER BY fraud_count DESC;
