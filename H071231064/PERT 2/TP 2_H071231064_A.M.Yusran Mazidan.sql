-- A.M.Yusran Mazidan
-- H071231064

USE classicmodels;

SELECT productCode AS 'Kode Produk', productName AS 'Nama Produk', quantityInStock AS 'Jumlah Stok' FROM products WHERE quantityInStock >= 5000 AND quantityInStock <= 6000;

SELECT orderNumber AS 'Nomor Pesanan', orderDate AS 'Tanggal Pesanan', status, customerNumber AS 'Nomor Pelanggan' FROM orders WHERE status != 'shipped' ORDER BY customerNumber;

SELECT employeeNumber AS 'Nomor Karyawan', firstName, lastName, email, jobTitle AS 'Jabatan' FROM employees WHERE jobTitle = 'Sales rep' ORDER BY firstName LIMIT 10;

SELECT productCode Kode_Produk, productName AS 'Nama Produk', productLine AS 'Lini Produk', buyPrice AS 'Harga Beli' FROM products ORDER BY `Harga Beli` DESC LIMIT 10 OFFSET 5;

SELECT * FROM orders AS `or`; 

SELECT DISTINCT country, city FROM customers ORDER BY country, city;