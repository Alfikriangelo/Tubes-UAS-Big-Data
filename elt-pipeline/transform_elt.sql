-- buat Schema Staging
CREATE SCHEMA IF NOT EXISTS staging;

-- transformasi Data Transaksi (Cleaning dan Casting)
DROP TABLE IF EXISTS staging.cc_tx_casted;

CREATE TABLE staging.cc_tx_casted AS
SELECT
    trans_num,
    cc_num,
    merchant,
    category,
    -- casting tipe data numerik
    amt::NUMERIC(12,2) AS amount,
    is_fraud::INT AS is_fraud,
    -- konversi Unix Time ke Timestamp
    to_timestamp(unix_time::BIGINT) AT TIME ZONE 'UTC' AS transaction_ts,
    city,
    state,
    zip,
    merch_zipcode,
    -- casting Koordinat Geografis
    lat::DOUBLE PRECISION AS cust_lat,
    long::DOUBLE PRECISION AS cust_long,
    merch_lat::DOUBLE PRECISION AS merch_lat,
    merch_long::DOUBLE PRECISION AS merch_long,
    city_pop::INT AS city_pop
FROM raw_elt.cc_tx
WHERE amt IS NOT NULL; -- cleaning: Hapus data yang amount-nya kosong

-- transformasi Data FRED (Casting)
DROP TABLE IF EXISTS staging.fred_fedfunds_casted;

CREATE TABLE staging.fred_fedfunds_casted AS
SELECT
    -- casting tanggal dan nilai suku bunga
    date::DATE AS obs_date,
    value::NUMERIC(10,4) AS fedfunds_rate
FROM raw_elt.fred_fedfunds
WHERE value != '.'; -- cleaning sederhana jika ada nilai non-numerik