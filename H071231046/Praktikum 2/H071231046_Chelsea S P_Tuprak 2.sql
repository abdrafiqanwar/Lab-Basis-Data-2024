USE classicmodels;

#Nomor 1
SELECT * FROM products;
SELECT productCode AS 'Kode Produk', productName AS 'Nama Produk', quantityInStock AS 'Jumlah Stok'
FROM products
WHERE quantityInStock BETWEEN 5000 AND 6000 ORDER BY quantityInStock ASC;

#Nomor 2
SELECT * FROM orders;
SELECT orderNumber AS 'Nomor Pesanan', orderDate AS 'Tanggal Pesanan', STATUS, customerNumber AS 'Nomor Pelanggan'
FROM orders
WHERE STATUS != 'Shipped'
ORDER BY customerNumber ASC;

#Nomor 3
SELECT * FROM employees;
SELECT employeenumber AS 'Nomor Karyawan', firstName, lastname, email, jobtitle AS 'Jabatan'
FROM employees
WHERE jobtitle = 'Sales Rep' 
ORDER BY firstname ASC
LIMIT 10;

#Nomor 4
SELECT * FROM products;
SELECT productcode 'Kode Produk', productname AS 'Nama Produk', productLine as 'Lini Produk', buyPrice as 'Harga Beli'
FROM products
ORDER BY buyprice DESC
LIMIT 10 OFFSET 5;

#Nomor 5
SELECT * FROM customers;
SELECT DISTINCT country, city 
FROM customers
ORDER BY country, city ASC;
