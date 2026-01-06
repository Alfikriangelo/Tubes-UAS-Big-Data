# Big Data Final Project – ETL, ELT, and Analytics Pipeline

## Deskripsi Singkat Studi Kasus
Repositori ini berisi implementasi pipeline **ETL dan ELT** untuk pengolahan data transaksi kartu kredit yang diperkaya dengan data makroekonomi (Federal Funds Rate). Tujuan utama proyek ini adalah membangun alur data yang reproducible, terstruktur, dan siap dianalisis hingga tahap visualisasi dashboard.

Pipeline dirancang untuk mendukung proses **data cleaning, feature engineering, integrasi multi-sumber**, serta penyimpanan data terpusat di data warehouse untuk kebutuhan analitik.

---

## Arsitektur Sistem (Ringkas)
Alur sistem dibangun dengan tahapan berikut:
1. **Extract** data dari file CSV dan API eksternal
2. **Raw storage** sebagai bukti data mentah tanpa preprocessing
3. **ETL pipeline** untuk transformasi berbasis Python
4. **ELT pipeline** untuk transformasi lanjutan berbasis SQL di warehouse
5. **Data Warehouse** dengan skema analitik
6. **Dashboard** untuk visualisasi insight

Diagram arsitektur lengkap tersedia pada folder `architecture/`.

---

## Perbedaan ETL dan ELT yang Digunakan
- **ETL (Extract – Transform – Load)**  
  Transformasi dilakukan sebelum data dimuat ke warehouse menggunakan Python (cleaning, encoding, normalisasi, feature engineering).

- **ELT (Extract – Load – Transform)**  
  Data mentah dimuat terlebih dahulu ke warehouse, kemudian dilakukan transformasi lanjutan dan agregasi menggunakan SQL.

Kedua pendekatan digunakan secara terpisah dan tidak identik.

---

## Cara Menjalankan Pipeline ETL
1. Pastikan Python dan PostgreSQL aktif
2. Install dependency:
   ```bash
   pip install -r requirements.txt
3. Jalankan pipeline ETL:
   ```bash
   python etl_pipeline/load_warehouse.py
4. Hasil data bersih akan tersimpan pada:
   - Folder warehouse/
   - Database PostgreSQL (data warehouse)
Log eksekusi tersedia pada folder logs/.

## Tools dan Versi Utama
- Python 3.10+
- pandas 2.x
- numpy 1.24+
- SQLAlchemy 2.x
- PostgreSQL
- psycopg2-binary
- Power BI

## Struktur Direktori
```bash
TUBES-UAS-BIG-DATA/
├── architecture/
│   └── Diagram arsitektur ETL & ELT.png
│
├── dashboard/
│   ├── link_dashboard.txt
│   ├── page_1.jpeg
│   ├── page_2.jpeg
│   └── page_3.jpeg
│
├── datalake/
│   ├── credit_card_transactions_cleaned.csv
│   └── link_fulldataset_datalake.txt
│
├── elt-pipeline/
│   ├── aggregation.sql
│   ├── load_raw.sql
│   └── transform_elt.sql
│
├── etl-pipeline/
│   ├── __pycache__/
│   ├── config.py
│   ├── data_validation.py
│   ├── extract_source1.py
│   ├── extract_source2.py
│   ├── transform.py
│   └── load_warehouse.py
│
├── logs/
│   ├── WhatsApp Image 2026-01-06 at 10.39.53.jpeg
│   ├── WhatsApp Image 2026-01-06 at 10.41.49.jpeg
│   ├── WhatsApp Image 2026-01-06 at 10.42.02.jpeg
│   ├── WhatsApp Image 2026-01-06 at 10.42.19.jpeg
│   ├── WhatsApp Image 2026-01-06 at 10.42.53.jpeg
│   ├── WhatsApp Image 2026-01-06 at 10.43.37.jpeg
│   ├── WhatsApp Image 2026-01-06 at 10.44.04.jpeg
│   ├── WhatsApp Image 2026-01-06 at 10.45.31.jpeg
│   ├── WhatsApp Image 2026-01-06 at 10.45.46.jpeg
│   ├── WhatsApp Image 2026-01-06 at 10.46.01.jpeg
│   ├── WhatsApp Image 2026-01-06 at 10.46.49.jpeg
│   └── WhatsApp Image 2026-01-06 at 10.47.14.jpeg
│
├── raw/
│   ├── link_fulldataset_raw.txt
│   ├── raw_credit_card.csv
│   └── raw_fred_fedfunds.csv
│
├── tambahan/
│   └── Notebook/
│
├── warehouse/
│   ├── analytical_queries.sql
│   ├── create_tables.sql
│   ├── insert_dim.sql
│   └── insert_fact.sql
│
├── requirements.txt
└── README.md


