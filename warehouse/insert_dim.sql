-- =====================================================
-- DIM TIME
-- =====================================================
INSERT INTO dw.dim_time (trans_date, year, month, hour, year_month)
SELECT DISTINCT
    trans_date_trans_time::date,
    year,
    month,
    hour,
    year_month
FROM public.fact_credit_card_transactions
ON CONFLICT DO NOTHING;

-- =====================================================
-- DIM CATEGORY (dari one-hot encoded)
-- =====================================================
INSERT INTO dw.dim_category (category_name)
SELECT REPLACE(column_name, 'cat_', '')
FROM information_schema.columns
WHERE table_name = 'fact_credit_card_transactions'
  AND column_name LIKE 'cat_%'
ON CONFLICT DO NOTHING;

-- =====================================================
-- DIM LOCATION
-- =====================================================
INSERT INTO dw.dim_location (city, state, zip, lat, long, city_pop)
SELECT DISTINCT
    city,
    state,
    zip,
    lat,
    long,
    city_pop
FROM public.fact_credit_card_transactions
ON CONFLICT DO NOTHING;

-- =====================================================
-- DIM CUSTOMER
-- =====================================================
INSERT INTO dw.dim_customer (customer_id, first_name, last_name, gender, age, job)
SELECT DISTINCT
    cc_num,
    first,
    last,
    gender,
    age,
    job
FROM public.fact_credit_card_transactions
ON CONFLICT (customer_id) DO NOTHING;

-- =====================================================
-- DIM MERCHANT
-- =====================================================
INSERT INTO dw.dim_merchant (merchant_name, merch_lat, merch_long, merch_zipcode)
SELECT DISTINCT
    merchant,
    merch_lat,
    merch_long,
    merch_zipcode
FROM public.fact_credit_card_transactions
ON CONFLICT (merchant_name) DO NOTHING;
