-- =====================================================
-- CREATE SCHEMA
-- =====================================================
CREATE SCHEMA IF NOT EXISTS dw;

-- =====================================================
-- DIMENSION TABLES
-- =====================================================

-- 1. Dimension Time
CREATE TABLE dw.dim_time (
    time_id SERIAL PRIMARY KEY,
    trans_date DATE,
    year INT,
    month INT,
    hour INT,
    year_month VARCHAR(7),
    UNIQUE (trans_date, hour)
);

-- 2. Dimension Category
CREATE TABLE dw.dim_category (
    category_id SERIAL PRIMARY KEY,
    category_name VARCHAR(50) UNIQUE
);

-- 3. Dimension Location
CREATE TABLE dw.dim_location (
    location_id SERIAL PRIMARY KEY,
    city TEXT,
    state TEXT,
    zip BIGINT,
    lat DOUBLE PRECISION,
    long DOUBLE PRECISION,
    city_pop BIGINT,
    UNIQUE (city, state)
);

-- 4. Dimension Customer
CREATE TABLE dw.dim_customer (
    customer_id BIGINT PRIMARY KEY, -- cc_num
    first_name TEXT,
    last_name TEXT,
    gender TEXT,
    age INT,
    job TEXT
);

-- 5. Dimension Merchant
CREATE TABLE dw.dim_merchant (
    merchant_id SERIAL PRIMARY KEY,
    merchant_name TEXT UNIQUE,
    merch_lat DOUBLE PRECISION,
    merch_long DOUBLE PRECISION,
    merch_zipcode BIGINT
);

-- =====================================================
-- FACT TABLE
-- =====================================================
CREATE TABLE dw.fact_credit_card_transactions (
    trans_num TEXT PRIMARY KEY,
    time_id INT REFERENCES dw.dim_time(time_id),
    category_id INT REFERENCES dw.dim_category(category_id),
    location_id INT REFERENCES dw.dim_location(location_id),
    customer_id BIGINT REFERENCES dw.dim_customer(customer_id),
    merchant_id INT REFERENCES dw.dim_merchant(merchant_id),
    amount DOUBLE PRECISION,
    amount_log DOUBLE PRECISION,
    amount_norm DOUBLE PRECISION,
    is_fraud INT,
    interest_rate DOUBLE PRECISION
);
