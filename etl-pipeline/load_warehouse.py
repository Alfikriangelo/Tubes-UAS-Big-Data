import os
from config import ENGINE, PROCESSED_DIR
from extract_source1 import extract_etl_source1
from extract_source2 import extract_etl_source2
from transform import transform_data
from data_validation import validate_data

def load_to_warehouse():
    df = extract_etl_source1()
    df_fred = extract_etl_source2()

    df_final = transform_data(df, df_fred)
    validate_data(df_final)

    csv_path = os.path.join(PROCESSED_DIR, "credit_card_transactions_cleaned.csv")
    df_final.to_csv(csv_path, index=False)

    print("🚀 LOAD ke PostgreSQL")

    df_final.to_sql(
        name="credit_card_transactions",
        con=ENGINE,
        if_exists="replace",
        index=False,
        chunksize=5000,
        method="multi"
    )

    print("✅ SELESAI LOAD")

if __name__ == "__main__":
    load_to_warehouse()
