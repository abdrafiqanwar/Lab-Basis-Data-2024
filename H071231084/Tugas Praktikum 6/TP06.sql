USE classicmodels;

-- NOMOR 1
SELECT c.customerName,
	CONCAT(e.firstName, ' ', e.lastName) AS salesRep,
	creditLimit - SUM(amount) AS remainingCredit
FROM customers c
JOIN employees e
	ON e.employeeNumber = c.salesRepEmployeeNumber
JOIN payments p
	USING (customerNumber)
GROUP BY customerNumber
HAVING remainingCredit > 0
ORDER BY customerName

-- NOMOR 2
SELECT p.productName AS 'Nama Produk',
	GROUP_CONCAT(distinct customerName ORDER BY customerName SEPARATOR ', ') AS 'Nama Customer',
	COUNT(distinct c.customerNumber) AS 'Jumlah Customer',
	SUM(quantityOrdered) AS 'Total Quantitas'
FROM products p
JOIN orderdetails od 
	USING (productCode)
JOIN orders o
	USING (orderNumber)
JOIN customers c
	USING (customerNumber)
GROUP BY productCode
ORDER BY `Nama Produk`

-- NOMOR 3
SELECT CONCAT(firstName, ' ', lastName) AS employeeName,
	COUNT(customerNumber) AS totalCustomers
FROM employees e
JOIN customers c
	ON e.employeeNumber = c.salesRepEmployeeNumber
GROUP BY employeeNumber
ORDER BY totalCustomers DESC

-- NOMOR 4
SELECT CONCAT(firstName, ' ', lastName) AS 'Nama Karyawan',
	p.productName AS 'Nama Produk',
	SUM(quantityOrdered) AS 'Jumlah Pesanan'
FROM products p
JOIN orderdetails od 
	USING (productCode)
JOIN orders o
	USING (orderNumber)
JOIN customers c
	USING (customerNumber)
RIGHT JOIN employees e
	ON c.salesRepEmployeeNumber = e.employeeNumber
JOIN offices f
	USING (officeCode)
WHERE f.country = 'Australia'
GROUP BY employeeNumber, p.productCode
ORDER BY `Jumlah Pesanan` DESC

-- NOMOR 5
SELECT customerName AS 'Nama Pelanggan',
	GROUP_CONCAT(productName ORDER BY productName) AS 'Nama Produk',
	COUNT(productCode) AS 'Banyak Jenis Produk'
FROM customers c
JOIN orders o
	USING(customerNumber)
JOIN orderdetails
	USING(orderNumber)
JOIN products
	USING(productCode)
WHERE shippedDate IS NULL
GROUP BY customerNumber
ORDER BY `Nama Pelanggan`

-- tampilkan jumlah pembayaran yg dilakukan oleh tiap customer pada setiap kota
SELECT city,
	YEAR(paymentDate),
	SUM(amount)
FROM customers
JOIN payments
	USING(customerNumber)
GROUP BY city, YEAR(paymentDate)