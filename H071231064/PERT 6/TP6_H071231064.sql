USE classicmodels;

# Nomor 1
SELECT c.customerName, 
		 CONCAT(e.firstName, " ", e.lastName) AS salesRep, 
		 (c.creditLimit - COALESCE(SUM(p.amount), 0)) AS remainingCredit
FROM customers c
JOIN employees e
	ON c.salesRepEmployeeNumber = e.employeeNumber
LEFT JOIN payments p
	ON c.customerNumber = p.customerNumber
GROUP BY c.customerNumber
HAVING (remainingCredit) > 0;

# Nomor 2
SELECT p.productName AS 'Nama Produk', 
		 GROUP_CONCAT(c.customerName)AS 'Nama Customer', 
		 COUNT(DISTINCT c.customerNumber) AS 'Jumlah Customer', 
		 SUM(od.quantityOrdered) AS 'Total Quantitas'
FROM products p
JOIN orderdetails od
	ON p.productCode = od.productCode
JOIN orders o
	ON od.orderNumber = o.orderNumber
JOIN customers c
	ON o.customerNumber = c.customerNumber
GROUP BY p.productCode
ORDER BY p.productName;

# Nomor 3
SELECT CONCAT(e.firstName, ' ', e.lastName) AS 'employeeName', 
		 COUNT(c.customerNumber) AS 'totalCustomers'
FROM employees e
JOIN customers c
	ON e.employeeNumber = c.salesRepEmployeeNumber
GROUP BY e.employeeNumber
ORDER BY totalCustomers DESC;

# Nomor 4
SELECT CONCAT(e.firstName, ' ', e.lastName) AS 'Nama Karyawan',
		 p.productName AS 'Nama Produk', 
       SUM(od.quantityOrdered) AS 'Jumlah Pesanan'
FROM products p
JOIN orderdetails od
    ON p.productCode = od.productCode
JOIN orders o
    ON od.orderNumber = o.orderNumber
JOIN customers c
    ON o.customerNumber = c.customerNumber
RIGHT JOIN employees e
    ON c.salesRepEmployeeNumber = e.employeeNumber
JOIN offices os
    ON e.officeCode = os.officeCode
WHERE os.country = 'Australia'
GROUP BY e.employeeNumber, p.productName
ORDER BY SUM(od.quantityOrdered) DESC;

# Nomor 5
SELECT c.customerName AS 'Nama Pelanggan',
       GROUP_CONCAT(p.productName ORDER BY p.productName) AS 'Nama Produk',
       COUNT(p.productName) AS 'Banyak Jenis Produk'
FROM customers c
JOIN orders o
	ON c.customerNumber = o.customerNumber
JOIN orderdetails od
	ON o.orderNumber = od.orderNumber
JOIN products p
ON od.productCode = p.productCode
WHERE o.shippedDate IS NULL
GROUP BY c.customerName;

# Nomor 6
SELECT
	c.customerName,
    o.status,
    SUM(od.quantityOrdered) AS `Jumlah Barang yang dipesan`
FROM customers c
JOIN orders o
USING (customerNumber)
JOIN orderdetails od
USING (orderNumber)
GROUP BY c.customerNumber, o.status
ORDER BY c.customerName;
