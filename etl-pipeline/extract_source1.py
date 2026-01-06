import pandas as pd
import time
import os
from config import BASE_DIR, RAW_DIR

def extract_etl_source1():
    start = time.time()

    path = os.path.join(BASE_DIR, "credit_card_transactions.csv")
    df = pd.read_csv(path)

    raw_path = os.path.join(RAW_DIR, "raw_credit_card.csv")
    df.to_csv(raw_path, index=False)

    print("[EXTRACT] Credit Card Dataset")
    print("Rows:", df.shape[0], "Cols:", df.shape[1])
    print("Execution time:", round(time.time() - start, 2), "sec\n")

    return df
