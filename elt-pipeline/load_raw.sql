-- membuat Schema untuk Raw Data (jika belum ada)
CREATE SCHEMA IF NOT EXISTS raw_elt;

-- verifikasi Data Mentah (Validation Queries)
-- memastikan jumlah baris sesuai dengan sumber data
SELECT 'cc_tx' AS table_name, COUNT(*) AS total_rows FROM raw_elt.cc_tx
UNION ALL
SELECT 'fred_fedfunds', COUNT(*) FROM raw_elt.fred_fedfunds;

-- preview data mentah
SELECT * FROM raw_elt.cc_tx LIMIT 5;