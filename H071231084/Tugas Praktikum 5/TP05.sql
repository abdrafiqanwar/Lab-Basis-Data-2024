USE classicmodels;

-- Nomor 1
SELECT DISTINCT
	c.customerName AS namaKustomer,
	p.productName AS namaProduk,
	pl.textDescription
FROM customers c
JOIN orders o
	USING (customerNumber)
	ON c.customerNumber = o.customerNumber
JOIN orderdetails od
	ON o.orderNumber = od.orderNumber
JOIN products p
	ON p.productCode = od.productCode
JOIN productlines pl
	ON pl.productLine = p.productLine
WHERE productName LIKE '%Titanic%'
ORDER BY namaKustomer

-- Nomor 2
SELECT 
	c.customerName,
	p.productName,
	o.status,
	o.shippedDate
FROM customers c
JOIN orders o
	ON c.customerNumber = o.customerNumber
JOIN orderdetails od
	ON o.orderNumber = od.orderNumber
JOIN products p
	ON p.productCode = od.productCode
WHERE (p.productName LIKE '%Ferrari%')
	AND (o.status = 'Shipped')
	AND (o.shippedDate BETWEEN '2003-10-01' AND '2004-09-30')
ORDER BY o.shippedDate DESC

-- Nomor 3
SELECT
	s.firstName AS Supervisor,
	k.firstName AS Karyawan
FROM employees k
JOIN employees s
	ON k.reportsTo = s.employeeNumber
WHERE s.firstName = 'Gerard'
ORDER BY k.firstname ASC;

-- Nomor 4
-- Bagian a
SELECT 
	c.customerName,
	p.paymentDate,
	e.firstName AS employeeName,
	p.amount
FROM customers c
JOIN payments p
	ON c.customerNumber = p.customerNumber
JOIN employees e
	ON c.salesRepEmployeeNumber = e.employeeNumber
WHERE paymentDate LIKE '%-11-%' 
-- Bagian b
ORDER BY amount DESC
LIMIT 1;

-- Bagian c
SELECT
	c.customerName,
	p.productName
FROM customers c
JOIN orders o
	ON c.customerNumber = o.customerNumber
JOIN orderdetails od
	ON o.orderNumber = od.orderNumber
JOIN products p
	ON od.productCode = p.productCode
JOIN payments pm
	ON pm.customerNumber = c.customerNumber
WHERE c.customerName = 'Corporate Gift Ideas Co.'	
	AND pm.paymentDate LIKE '%-11-%'
	
-- soal tambahan
SELECT
	c.customerName,
	p.productName,
	e.firstName AS employeeName	
FROM customers c
JOIN orders o
	ON c.customerNumber = o.customerNumber
JOIN orderdetails od
	ON o.orderNumber = od.orderNumber
JOIN products p
	ON od.productCode = p.productCode
JOIN employees e
	ON e.employeeNumber = c.salesRepEmployeeNumber