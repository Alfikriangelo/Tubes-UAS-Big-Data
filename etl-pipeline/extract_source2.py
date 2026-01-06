import pandas as pd
import requests
import time
import os
from config import RAW_DIR

def extract_etl_source2():
    start = time.time()

    url = "https://api.stlouisfed.org/fred/series/observations"
    params = {
        "series_id": "FEDFUNDS",
        "api_key": "51c9062a781c9b5719b643681e26d34b",
        "file_type": "json",
        "frequency": "m"
    }

    resp = requests.get(url, params=params)
    resp.raise_for_status()

    df = pd.DataFrame(resp.json()["observations"])

    raw_path = os.path.join(RAW_DIR, "raw_fred_fedfunds.csv")
    df.to_csv(raw_path, index=False)

    print("[EXTRACT] FRED FEDFUNDS")
    print("Rows:", df.shape[0], "Cols:", df.shape[1])
    print("Execution time:", round(time.time() - start, 2), "sec\n")

    return df
