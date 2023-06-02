/*
--------------------------
CREATE DATABASE DAN TABEL
--------------------------
*/

-- Membuat Schema Database
CREATE SCHEMA kimia_farma;
USE kimia_farma;

-- Membuat Tabel Barang
CREATE TABLE kimia_farma.barang (
  `kode_barang` VARCHAR(45) NOT NULL,
  `sektor` VARCHAR(45) NULL,
  `nama_barang` VARCHAR(45) NULL,
  `tipe` VARCHAR(45) NULL,
  `nama_tipe` VARCHAR(45) NULL,
  `kode_lini` VARCHAR(45) NULL,
  `lini` VARCHAR(45) NULL,
  `kemasan` VARCHAR(45) NULL,
  PRIMARY KEY (kode_barang));
  
-- Membuat Tabel Penjualan
CREATE TABLE kimia_farma.penjualan (
  `id_distributor` VARCHAR(45) NULL,
  `id_cabang` VARCHAR(45) NULL,
  `id_invoice` VARCHAR(45) NOT NULL,
  `tanggal` DATE NULL,
  `id_customer` VARCHAR(45) NULL,
  `id_barang` VARCHAR(45) NULL,
  `jumlah` INT NULL,
  `unit` VARCHAR(45) NULL,
  `harga` FLOAT NULL,
  `mata_uang` VARCHAR(45) NULL,
  `brand_id` VARCHAR(45) NULL,
  `lini` VARCHAR(45) NULL,
  PRIMARY KEY (id_invoice));
  
  ALTER TABLE penjualan MODIFY COLUMN harga DECIMAL(45);
  
  SELECT harga FROM penjualan;
  
-- Membuat Tabel Penjualan
CREATE TABLE `kimia_farma`.`pelanggan` (
  `id_customer` VARCHAR(45) NOT NULL,
  `level` VARCHAR(45) NULL,
  `nama` VARCHAR(45) NULL,
  `id_cabang` VARCHAR(45) NULL,
  `cabang_sales` VARCHAR(45) NULL,
  `id_group` VARCHAR(45) NULL,
  `group` VARCHAR(45) NULL,
  PRIMARY KEY (`id_customer`));
  
/* Melakukan Import Data ke dalam Table
1. Pilih tabel yang akan dimasukkan data, next
2. Klik kanan pilih Table Data Import Wizard, next
3. Pilih file dataset ytang akan diimport, next
4. Centang use existing tabel dan truncate table before import, pastikan nama tabel sesuai, next
5. Pastikan nama kolom sesuai, next
6. Klik next pada section import data dan selesai
*/
  
/*
--------------------------
CREATING BASE TABLE
--------------------------
*/

-- Membuat datamart base table penjualan
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

-- Membuat id_invoice Menjadi Primary Key pada base table
ALTER TABLE base_tbl_penjualan ADD PRIMARY KEY(id_invoice);

/*
--------------------------
CREATING AGGREGAT TABLE
--------------------------
*/

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
