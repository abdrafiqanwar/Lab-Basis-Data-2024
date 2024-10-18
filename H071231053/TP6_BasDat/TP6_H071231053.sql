-- No. 1 
SELECT c.customerName,
       CONCAT(e.firstName, ' ', e.lastName) salesRep,
       (c.creditLimit - SUM(p.amount)) remainingCredit
FROM customers c
JOIN employees e ON e.employeeNumber = c.salesRepEmployeeNumber
JOIN payments p ON p.customerNumber = c.customerNumber
GROUP BY c.customerName
HAVING remainingCredit > 0;

-- No. 2
SELECT p.productName 'Nama Produk',
	GROUP_CONCAT(DISTINCT c.customerName SEPARATOR ', ') 'Nama Customer',
	COUNT(DISTINCT c.customerNumber) 'Jumlah Customer',
	SUM(od.quantityOrdered) 'Total Kuantitas'
FROM products p 
JOIN orderdetails od on od.productCode = p.productCode
JOIN orders o on o.orderNumber = od.orderNumber
JOIN customers c on c.customerNumber = o.customerNumber
GROUP BY p.productName;

-- No. 3
SELECT CONCAT(e.firstName, ' ', e.lastName) employeeName,
	COUNT(c.salesRepEmployeeNumber) totalCustomers
FROM employees e
JOIN customers c ON e.employeeNumber = c.salesRepEmployeeNumber
GROUP BY e.employeeNumber
ORDER BY totalCustomers DESC;

-- No. 4
SELECT CONCAT(e.firstName, ' ', e.lastName) 'Nama Karyawan',
	p.productName 'Nama Produk',
	SUM(od.quantityOrdered) 'Jumlah Pesanan'
FROM employees e
LEFT JOIN offices ofc ON ofc.officeCode = e.officeCode
JOIN customers c ON c.salesRepEmployeeNumber = e.employeeNumber 
JOIN orders o ON o.customerNumber = c.customerNumber
JOIN orderdetails od ON od.orderNumber = o.orderNumber
JOIN products p ON p.productCode = od.productCode
WHERE ofc.country = 'Australia'
GROUP BY e.employeeNumber, p.productName 
ORDER BY `Jumlah Pesanan` DESC;

-- No. 5
SELECT c.customerName 'Nama Pelanggan',
	GROUP_CONCAT(DISTINCT p.productName SEPARATOR ', ') 'Nama Produk',
	COUNT(DISTINCT p.productCode) 'Banyak Jenis Produk'
FROM customers c 
JOIN orders o ON o.customerNumber = c.customerNumber
JOIN orderdetails od ON od.orderNumber  = o.orderNumber
JOIN products p ON p.productCode = od.productCode
WHERE o.shippedDate IS NULL
GROUP BY `Nama Pelanggan`;

#jumlah harga satuan tiap kategori produk

SELECT p.productLine, AVG(od.priceEach)
FROM products p
JOIN orderdetails od ON od.productCode = p.productCode 
GROUP BY p.productLine