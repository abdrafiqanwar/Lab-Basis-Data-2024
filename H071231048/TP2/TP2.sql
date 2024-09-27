
-- nomor 1
SELECT productcode AS 'kode produk', productname AS 'nama produk', quantityinstock AS 'jumlah stok'
FROM products
WHERE quantityinstock BETWEEN 5000 AND 6000
#ORDER BY quantityinstock;

-- nomor 2
SELECT * FROM orders;
SELECT ordernumber AS 'nomor pesanan', orderdate AS 'tanggal pesanan', STATUS , customernumber AS 'nomor costemer'
FROM orders
WHERE STATUS != 'shipped'
ORDER BY customernumber;

-- nomor 3
SELECT * FROM employees;
SELECT employeenumber nomor_karyawan, firstname 'nama depan', lastname 'nama belakang', email ,jobtitle 'jabatan'
FROM employees
WHERE jobtitle = 'Sales Rep'
ORDER BY firstname ASC 
LIMIT 10;

-- nomor 4
SELECT * FROM products;
SELECT productcode 'kode produk', productname 'nama produk', productline 'lini produk', buyprice 'harga beli'
FROM products
ORDER BY `harga beli` desc
LIMIT 10 OFFSET 5

-- nomor 5
SELECT * FROM customers
SELECT DISTINCT country, city FROM customers
ORDER BY country, city