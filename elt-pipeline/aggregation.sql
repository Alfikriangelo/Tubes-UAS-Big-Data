-- membuat Schema Data Warehouse
CREATE SCHEMA IF NOT EXISTS dw;

-- data Enrichment & Feature Engineering
-- menggabungkan Transaksi dengan Suku Bunga (FRED) + Menghitung Log Amount
DROP TABLE IF EXISTS dw.elt_fact_transactions;

CREATE TABLE dw.elt_fact_transactions AS
SELECT
    t.*,
    -- feature Engineering: Logaritma dari Amount
    LN(t.amount + 0.0001) AS amount_log, -- +0.0001 untuk menghindari log(0)
    -- enrichment: Mengambil data suku bunga
    f.fedfunds_rate AS interest_rate
FROM staging.cc_tx_casted t
LEFT JOIN staging.fred_fedfunds_casted f
    -- logic join dengan mencocokkan Bulan dan Tahun Transaksi dengan Data FRED
    ON DATE_TRUNC('month', t.transaction_ts)::DATE = f.obs_date;

-- verifikasi final
SELECT 
    COUNT(*) AS total_rows,
    COUNT(interest_rate) AS rows_with_rate, 
    COUNT(*) - COUNT(interest_rate) AS rows_rate_null
FROM dw.elt_fact_transactions;

-- preview Data Akhir
SELECT * FROM dw.elt_fact_transactions 
ORDER BY transaction_ts DESC 
LIMIT 5;