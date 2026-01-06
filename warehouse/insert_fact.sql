-- =====================================================
-- VIEW: derive category_name from one-hot encoding
-- =====================================================
CREATE OR REPLACE VIEW dw.v_fact_with_category AS
SELECT
    *,
    CASE
        WHEN cat_entertainment THEN 'entertainment'
        WHEN cat_food_dining THEN 'food_dining'
        WHEN cat_gas_transport THEN 'gas_transport'
        WHEN cat_grocery_net THEN 'grocery_net'
        WHEN cat_grocery_pos THEN 'grocery_pos'
        WHEN cat_health_fitness THEN 'health_fitness'
        WHEN cat_home THEN 'home'
        WHEN cat_kids_pets THEN 'kids_pets'
        WHEN cat_misc_net THEN 'misc_net'
        WHEN cat_misc_pos THEN 'misc_pos'
        WHEN cat_personal_care THEN 'personal_care'
        WHEN cat_shopping_net THEN 'shopping_net'
        WHEN cat_shopping_pos THEN 'shopping_pos'
        WHEN cat_travel THEN 'travel'
    END AS category_name
FROM public.fact_credit_card_transactions;

-- =====================================================
-- INSERT INTO FACT TABLE
-- =====================================================
INSERT INTO dw.fact_credit_card_transactions (
    trans_num,
    time_id,
    category_id,
    location_id,
    customer_id,
    merchant_id,
    amount,
    amount_log,
    amount_norm,
    is_fraud,
    interest_rate
)
SELECT
    f.trans_num,
    t.time_id,
    c.category_id,
    l.location_id,
    cu.customer_id,
    m.merchant_id,
    f.amt,
    f.amt_log,
    f.amt_norm,
    f.is_fraud,
    f.interest_rate
FROM dw.v_fact_with_category f
JOIN dw.dim_time t
  ON t.trans_date = f.trans_date_trans_time::date
 AND t.hour = f.hour
JOIN dw.dim_category c
  ON c.category_name = f.category_name
JOIN dw.dim_location l
  ON l.city = f.city AND l.state = f.state
JOIN dw.dim_customer cu
  ON cu.customer_id = f.cc_num
JOIN dw.dim_merchant m
  ON m.merchant_name = f.merchant
ON CONFLICT (trans_num) DO NOTHING;
