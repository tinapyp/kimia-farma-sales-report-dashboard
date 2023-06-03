# **Virtual Internship Experience: Big Data Analytics - Kimia Farma**
Tool : MySQL Workbench - [Lihat script](https://github.com/fathinafif/BigDataAnalytics-KimiaFarma_VIX/blob/main/VIX_BigDataAnalyst_KimiaFarma_SQLCode.sql) <br>
Visualization : Looker Data Studio - [Lihat dashboard](https://lookerstudio.google.com/u/0/reporting/f4d9925e-4658-4d37-bda0-772ba811ab40/page/fnySD) <br>
Dataset : [VIX Kimia Farma](https://www.rakamin.com/virtual-internship-experience/kimiafarma-big-data-analytics-virtual-internship-program)
<br>

---

## 📂 **Introduction**

VIX Big Data Analytics at Kimia Farma is a virtual internship experience organized by Rakamin Academy. In this opportunity, I played the role of a Big Data Analyst tasked with analyzing and generating sales reports for the company using provided data. Through this project, I gained extensive knowledge about data warehousing, data lakes, and data marts. <br>
<br>

**Objectives**
- Designing datamart (base table and aggregate table)
- Creating visualizations/dashboard for company sales reports
<br>

**Dataset** <br>
The provided dataset consists of the following tables:

- Sales
- Products
- Customers
<br>


<details>
  <summary>Click to view the ERD (Entity Relationship Diagram) </summary>
<p align="center">
  <kbd> <img width="400" alt="erd" src="https://github.com/fathinafif/BigDataAnalytics-KimiaFarma_VIX/assets/127580188/1bd4cc9f-168d-401a-9147-fa0aefa312f3"></kbd> <br>
</p>

</details>
<br>

---


## 📂 **Design Datamart**
### Tabel Base
The base table is a table that contains raw or original data collected directly from its source. This table contains the necessary information to answer specific questions or solve particular problems. In this project, the base table is created by combining data from the sales, customers, and products tables. The primary key used is 'invoice_id'. <br>

<details>
  <summary> Click to view the Query </summary>
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
    Gambar 1 — Sample Result of Creating the Base Table 
</p>
<br>

### Tabel Aggregat
The aggregate table is a table formed by collecting and summarizing data from the base table. This aggregate table contains more compressed information and is used for faster and more efficient data analysis. The results from this table will be used as a source to create a sales dashboard.

<details>
  <summary> Click to view the Query </summary>
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
    Gambar 2 — Sample Result of Creating the Aggregate Table
</p>
<br>

---

## 📂 **Data Visualization**

[Look on Looker Data Studio](https://lookerstudio.google.com/u/0/reporting/f4d9925e-4658-4d37-bda0-772ba811ab40/page/fnySD).

<p align="center">
    <kbd> <img width="1000" alt="Kimia_Farma_page-0001" src="https://github.com/fathinafif/BigDataAnalytics-KimiaFarma_VIX/assets/127580188/c3967697-3fa9-4b4c-a967-1f19367b11c8"> </kbd> <br>
    Gambar 3 — Sales Report Dashboard PT. Kimia Farma
</p>
<br>

---
