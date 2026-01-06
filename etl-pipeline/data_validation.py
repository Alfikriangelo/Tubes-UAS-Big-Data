def validate_data(df):
    assert df.isnull().sum().sum() == 0, "❌ Masih ada missing value"
    assert df.shape[0] > 0, "❌ Data kosong"
    assert "amt" in df.columns, "❌ Kolom amt tidak ditemukan"

    print("✅ DATA VALIDATION BERHASIL")
