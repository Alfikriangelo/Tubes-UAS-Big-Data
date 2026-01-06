import os
from sqlalchemy import create_engine
from urllib.parse import quote_plus

# =====================
# DATABASE CONFIG
# =====================
DB_USER = "postgres"
DB_PASSWORD = quote_plus("Postgres@123")
DB_HOST = "localhost"
DB_PORT = "5433"
DB_NAME = "etl_warehouse"

ENGINE = create_engine(
    f"postgresql+psycopg2://{DB_USER}:{DB_PASSWORD}@{DB_HOST}:{DB_PORT}/{DB_NAME}"
)

# =====================
# PATH CONFIG
# =====================
BASE_DIR = r"D:\codingan\dataset\bigdata\uas"
RAW_DIR = os.path.join(BASE_DIR, "raw")
PROCESSED_DIR = os.path.join(BASE_DIR, "processed")

os.makedirs(RAW_DIR, exist_ok=True)
os.makedirs(PROCESSED_DIR, exist_ok=True)
