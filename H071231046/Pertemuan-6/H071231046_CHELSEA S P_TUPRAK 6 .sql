USE classicmodels;

#Nomor 1
SELECT
    c.customerName,
    CONCAT(e.firstname, ' ', e.lastname) salesRep,
    (c.creditLimit - coalesce(SUM(p.amount), 0)) remainingCredit
FROM customers c
JOIN employees e
    ON e.employeeNumber = c.salesRepEmployeeNumber
LEFT JOIN payments p
    USING(customerNumber)
GROUP BY c.customerName
HAVING remainingCredit > 0
ORDER BY c.customerName ASC;

#Nomor 2
SELECT
    p.productName 'Nama Produk',
    GROUP_CONCAT(DISTINCT c.customerName ORDER BY c.customerName) 'Nama Customer',
    COUNT(DISTINCT c.customerNumber) 'Jumlah Customer',
    SUM(od.quantityOrdered) 'Total Quantitas'
FROM products p
JOIN orderdetails od
    using(productCode)
JOIN orders o
    using(orderNumber)
JOIN customers c
    ON o.customerNumber = c.customerNumber
GROUP BY p.productName
ORDER BY p.productName ASC;

#Nomor 3
SELECT
    CONCAT(e.firstName, ' ', e.lastName) AS employeeName,
    COUNT(c.customerNumber) AS totalCustomers
FROM employees e
JOIN customers c
    ON e.employeeNumber = c.salesRepEmployeeNumber
GROUP BY employeeName
ORDER BY totalCustomers DESC;

#Nomor 4
SELECT
    CONCAT(e.firstName, ' ', e.lastName) AS "Nama Karyawan",
    p.productName AS "Nama Produk",
    SUM(od.quantityOrdered) AS "Jumlah Pesanan"
FROM employees e
JOIN offices o
    USING(officeCode)
JOIN customers c
    ON e.employeeNumber = c.salesRepEmployeeNumber
JOIN orders 
    USING(customerNumber)
JOIN orderdetails od
    USING(orderNumber)
JOIN products p
    USING(productCode)
WHERE o.country = 'Australia'
GROUP BY `Nama Karyawan`, p.productName
ORDER BY `Jumlah Pesanan` DESC;

#Nomor 5 
SELECT
    c.customerName 'Nama Pelanggan',
    group_concat(p.productName) 'Nama Produk',
    COUNT( distinct p.productCode) 'Banyak Jenis Produk'
FROM customers c
JOIN orders o 
	using(customerNumber)
JOIN orderdetails od 
	using(orderNumber)
JOIN products p 
	using(productCode)
WHERE shippeddate IS null
GROUP BY c.customerName;
