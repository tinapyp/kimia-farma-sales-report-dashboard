# **Virtual Internship Experience: Big Data Analytics - Kimia Farma**
Tool : MySQL Workbench - [Lihat script](https://github.com/fathinafif/BigDataAnalytics-KimiaFarma_VIX/blob/main/VIX_BigDataAnalyst_KimiaFarma_SQLCode.sql) <br>
Visualization : Looker Data Studio - [Lihat dashboard](https://lookerstudio.google.com/reporting/3c67b292-3be2-484d-bc29-27bd0b4015fd) <br>
Dataset : [VIX Kimia Farma](https://www.rakamin.com/virtual-internship-experience/kimiafarma-big-data-analytics-virtual-internship-program)
<br>

---

## 📂 **Introduction**
VIX Big Data Analytics Kimia Farma adalah pengalaman magang virtual yang diselenggarakan oleh Rakamin Academy. Dalam kesempatan ini, saya berperan sebagai Big Data Analytics yang bertugas untuk menganalisis dan membuat laporan penjualan perusahaan dengan menggunakan data yang telah diberikan. Melalui proyek ini, saya juga memperoleh banyak pengetahuan tentang data warehouse, dataleke, dan datamart. <br>
<br>

**Objectives**
- Membuat design datamart (tabel base dan tabel aggregat)
- Membuat visualisasi/dashboard laporan penjualan perusahaan
<br>

**Dataset** <br>
Dataset yang disediakan terdiri dari tabel-tabel berikut:
- penjualan
- barang
- pelanggan
<br>


<details>
  <summary>Klik untuk melihat ERD</summary>
<p align="center">
  <kbd> <img width="400" alt="erd" src="https://github.com/fathinafif/BigDataAnalytics-KimiaFarma_VIX/assets/127580188/1bd4cc9f-168d-401a-9147-fa0aefa312f3"></kbd> <br>
</p>

</details>
<br>

---


## 📂 **Design Datamart**
### Tabel Base
Tabel base merupakan tabel yang berisi data asli atau mentah yang dikumpulkan langsung dari sumbernya. Tabel ini mengandung informasi yang diperlukan untuk menjawab pertanyaan atau memecahkan masalah tertentu. Dalam proyek ini, tabel base dibuat dengan menggabungkan data dari tabel penjualan, pelanggan, dan barang. Primary key yang digunakan adalah 'invoice_id'. <br>

<details>
  <summary> Klik untuk melihat Query </summary>
    <br>
    
```sql
CREATE TABLE base_tbl_penjualan (
SELECT
    pnj.id_invoice,
    pnj.tanggal,
    pnj.id_customer,
    cus.nama,
    pnj.id_distributor,
    pnj.id_cabang,
    cus.cabang_sales,
    cus.id_group,
    cus.group,
    pnj.id_barang,
    brg.nama_barang,
    pnj.brand_id,
    brg.kode_lini,
    pnj.lini,
    brg.kemasan,
    pnj.jumlah,
    pnj.harga,
    pnj.mata_uang
FROM penjualan pnj
	LEFT JOIN pelanggan cus
		ON cus.id_customer = pnj.id_customer
	LEFT JOIN barang brg
		ON brg.kode_barang = pnj.id_barang
ORDER BY pnj.tanggal
);

ALTER TABLE base_tbl_penjualan ADD PRIMARY KEY(id_invoice);
```
    
<br>
</details>
<br>

<p align="center">
    <kbd> <img width="1000" alt="sample table base" src="https://github.com/fathinafif/BigDataAnalytics-KimiaFarma_VIX/assets/127580188/014c6f7d-e734-4bd9-8d62-6c0ea3c6dc41"> </kbd> <br>
    Gambar 1 — Sampel Hasil Pembuatan Tabel Base 
</p>
<br>

### Tabel Aggregat
Tabel aggregat adalah tabel yang dibentuk dengan mengumpulkan dan menghitung data dari tabel dasar. Tabel aggregat ini berisi informasi yang lebih terkompresi dan digunakan untuk menganalisis data dengan lebih cepat dan efisien. Hasil dari tabel ini akan digunakan sebagai sumber untuk membuat dashboard laporan penjualan..

<details>
  <summary> Klik untuk melihat Query </summary>
    <br>
    
```sql
-- Membuat datamart aggregat table penjualan
CREATE TABLE agg_tbl_penjualan(
SELECT
    tanggal,
    MONTHNAME(tanggal) AS bulan,
    id_invoice,
    cabang_sales AS lokasi_cabang,
    nama AS pelanggan,
    nama_barang AS produk,
    lini AS merek,
    jumlah AS jumlah_produk_terjual,
    harga AS harga_satuan,
    ROUND((jumlah * harga),3) AS total_pendapatan
FROM base_tbl_penjualan
ORDER BY 1, 4, 5, 6, 7, 8, 9, 10
);

-- Membuat id_invoice Menjadi Primary Key pada aggregat table
ALTER TABLE agg_tbl_penjualan ADD PRIMARY KEY(id_invoice);
```
    
<br>
</details>
<br>

<p align="center">
    <kbd> <img width="750" alt="sample aggregat" src="https://github.com/fathinafif/BigDataAnalytics-KimiaFarma_VIX/assets/127580188/fc1ce9be-128c-4cf1-b8e6-4747fdcb0e50"> </kbd> <br>
    Gambar 2 — Sampel Hasil Pembuatan Tabel Aggregat
</p>
<br>

---

## 📂 **Data Visualization**

[Lihat pada halaman Looker Data Studio](https://lookerstudio.google.com/reporting/3c67b292-3be2-484d-bc29-27bd0b4015fd).

<p align="center">
    <kbd> <img width="1000" alt="Kimia_Farma_page-0001" src="https://user-images.githubusercontent.com/115857221/222877035-53371a89-081d-4ec5-9e72-65b0176a96fd.jpg"> </kbd> <br>
    Gambar 3 — Sales Report Dashboard PT. Kimia Farma
</p>
<br>

---
