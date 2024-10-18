-- Nomor 1
SELECT c.customerName,
		 CONCAT(e.firstName,' ',e.lastName) AS salesRep,
		 (c.creditLimit - SUM(p.amount)) AS remainingCredit
FROM customers c
JOIN employees e ON c.salesRepEmployeeNumber = e.employeeNumber
JOIN payments p USING(customerNumber)
GROUP BY customerName
HAVING remainingCredit > 0;

-- Nomor 2
SELECT p.productName AS "Nama Produk",
		 GROUP_CONCAT(c.customerName ORDER BY c.customerName) AS "Nama Customer",
		 COUNT(DISTINCT c.customerNumber) AS "Jumlah Customer",
		 SUM(od.quantityOrdered) AS "Total Quantitas"
FROM customers c
JOIN orders o USING(customerNumber)
JOIN orderdetails od USING(orderNumber)
JOIN products p USING(productCode)
GROUP BY p.productName
ORDER BY "Nama Customer";

-- Nomor 3
SELECT CONCAT(e.firstName,' ',e.lastName) AS employeeName,
		 COUNT(c.customerNumber) AS TotalCustomers
FROM employees e
JOIN customers c ON c.salesRepEmployeeNumber = e.employeeNumber
GROUP BY e.employeeNumber
ORDER BY TotalCustomers DESC;

-- Nomor 4
SELECT CONCAT(e.firstName,' ',e.lastName) AS "Nama Karyawan",
		 p.productName AS "Nama Produk",
		 SUM(od.quantityOrdered) AS "Jumlah Pesanan"
FROM products p
JOIN orderdetails od USING(productCode)
JOIN orders o USING(orderNumber)
JOIN customers c USING(customerNumber)
RIGHT JOIN employees e ON c.salesRepEmployeeNumber = e.employeeNumber
JOIN offices OF USING(officeCode)
WHERE of.country = 'Australia'
GROUP BY e.employeeNumber,p.productName
ORDER BY SUM(od.quantityOrdered) DESC;

-- Nomor 5
SELECT c.customerName,
		 GROUP_CONCAT(p.productName ORDER BY p.productName) AS "Nama Produk",
		 COUNT(p.productName) AS "Banyak Jenis Produk"
FROM customers c
JOIN orders o USING(customerNumber)
JOIN orderdetails od USING(orderNumber)
JOIN products p USING(productCode)
WHERE o.shippedDate IS NULL
GROUP BY c.customerName;

-- Soal Tambahan
SELECT p.productLine,
		 AVG(od.priceEach) AS "Harga Rata-Rata"
FROM products p 
JOIN orderdetails od USING(productCode)
GROUP BY p.productLine;
		 