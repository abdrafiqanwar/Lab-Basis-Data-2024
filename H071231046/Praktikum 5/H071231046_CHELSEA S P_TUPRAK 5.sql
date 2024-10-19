USE classicmodels;

#Nomor 1
SELECT DISTINCT
    c.customerName namaKostumer,
    p.productName namaProduk,
    p.productDescription AS textDescription 
FROM customers c
INNER JOIN
	ORDERS o USING(customerNumber)
INNER JOIN
    orderdetails od USING(orderNumber)
INNER JOIN
    products p USING(productCode)
WHERE
    p.productName LIKE '%Titanic%'
ORDER BY
    c.customerName ASC;
	

#Nomor 2
SELECT
    c.customerName,
    p.productName,
    o.status,
    o.shippedDate
FROM customers c
INNER JOIN
    orders o ON c.customerNumber = o.customerNumber
INNER JOIN
    orderdetails od ON o.orderNumber = od.orderNumber
INNER JOIN
    products p ON od.productCode = p.productCode
WHERE
    p.productName LIKE '%Ferrari%'
    AND o.status = 'Shipped'
    AND o.shippedDate BETWEEN '2003-10-01' AND '2004-09-30'
ORDER BY
    o.shippedDate DESC;
    
SELECT * FROM employees;    
#Nomor 3
SELECT
    s.firstName 'Supervisor',
    k.firstName 'Karyawan'
FROM employees AS k
INNER JOIN employees AS s
    ON k.reportsTo = s.employeeNumber
WHERE s.firstName = 'Gerard'
ORDER BY k.firstName ASC;


#Nomor 4
#Bagian a
SELECT
    c.customerName,
    pay.paymentDate,
    CONCAT(e.firstName, ' ', e.lastName) AS employeeName,
    pay.amount
FROM
    customers c
INNER JOIN
    payments pay ON c.customerNumber = pay.customerNumber
INNER JOIN
    employees e ON c.salesRepEmployeeNumber = e.employeeNumber
WHERE
	pay.paymentDate LIKE '%-11-%'
	
ORDER BY
    pay.paymentDate ASC;


#Bagian b
SELECT
    c.customerName,
    p.paymentDate,
    e.firstName AS 'employeeName',
    p.amount
FROM customers AS c
INNER JOIN payments AS p
    ON c.customerNumber = p.customerNumber
INNER JOIN employees AS e
    ON c.salesRepEmployeeNumber = e.employeeNumber
WHERE p.paymentDate LIKE '%-11-%' 
ORDER BY p.amount desc
LIMIT 1;

#Bagian c
SELECT
    c.customerName,
    po.productName
FROM customers AS c
INNER JOIN orders AS o
    ON c.customerNumber = o.customerNumber
INNER JOIN orderdetails AS od
    ON o.orderNumber = od.orderNumber
INNER JOIN products AS po
    ON od.productCode = po.productCode
INNER JOIN payments AS p
	ON p.customerNumber = c.customerNumber
WHERE (p.paymentDate LIKE '%-11-%') 
	and c.customerName = 'corporate gift ideas co.';

SELECT * FROM employees e
SELECT * FROM customers c	

#Tugas Tambahan
SELECT
	e.firstName 'Nama Petugas',
	c.customerName 'Nama Pelanggan',
	p.amount 'Total Pembayaran'
FROM employees e
	JOIN customers c
		ON c.salesRepEmployeeNumber = E.employeeNumber 
JOIN payments p
	USING(customerNumber)
WHERE (p.amount > 100000)
ORDER BY p.amount DESC;



