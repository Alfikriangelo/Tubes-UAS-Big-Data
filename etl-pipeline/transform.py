import pandas as pd
import numpy as np

def transform_data(df, df_fred):
    # =====================
    # CLEANING
    # =====================
    df.columns = (
        df.columns.str.strip()
        .str.lower()
        .str.replace(r"[^\w]+", "_", regex=True)
    )

    if "unnamed_0" in df.columns:
        df = df.drop(columns=["unnamed_0"])

    df = df.drop_duplicates(subset=["trans_num"])

    df["trans_date_trans_time"] = pd.to_datetime(df["trans_date_trans_time"], errors="coerce")
    df["dob"] = pd.to_datetime(df["dob"], errors="coerce")

    df = df.dropna(subset=["cc_num", "amt", "category", "gender"])
    df["merch_zipcode"] = df["merch_zipcode"].fillna(-1)

    # =====================
    # OUTLIER (IQR)
    # =====================
    Q1, Q3 = df["amt"].quantile([0.25, 0.75])
    IQR = Q3 - Q1
    df["amt"] = df["amt"].clip(Q1 - 1.5 * IQR, Q3 + 1.5 * IQR)

    # =====================
    # FEATURE ENGINEERING
    # =====================
    df["year"] = df["trans_date_trans_time"].dt.year
    df["month"] = df["trans_date_trans_time"].dt.month
    df["hour"] = df["trans_date_trans_time"].dt.hour
    df["year_month"] = df["trans_date_trans_time"].dt.to_period("M").astype(str)
    df["age"] = ((df["trans_date_trans_time"] - df["dob"]).dt.days // 365)
    df = df[df["age"] >= 0]

    df["amt_log"] = np.log1p(df["amt"])

    # =====================
    # ENCODING & NORMALIZATION
    # =====================
    df["gender_encoded"] = df["gender"].map({"M": 0, "F": 1}).fillna(-1)
    df = pd.get_dummies(df, columns=["category"], prefix="cat")

    df["amt_norm"] = (df["amt"] - df["amt"].min()) / (df["amt"].max() - df["amt"].min() + 1e-9)
    df["age_norm"] = (df["age"] - df["age"].min()) / (df["age"].max() - df["age"].min() + 1e-9)

    # =====================
    # FRED DATA
    # =====================
    df_fred["date"] = pd.to_datetime(df_fred["date"], errors="coerce")
    df_fred["year_month"] = df_fred["date"].dt.to_period("M").astype(str)
    df_fred["interest_rate"] = pd.to_numeric(df_fred["value"], errors="coerce")
    df_fred = df_fred[["year_month", "interest_rate"]].dropna()

    df_final = df.merge(df_fred, on="year_month", how="left")

    print("✅ TRANSFORM SELESAI")
    return df_final
