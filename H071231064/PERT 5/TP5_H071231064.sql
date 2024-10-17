USE classicmodels;

#nomor1
SELECT DISTINCT c.customerName AS 'namakustomer', p.productName AS 'namaProduk', p.productDescription
FROM products AS p
INNER JOIN orderdetails AS od
ON p.productCode = od.productCode
INNER JOIN orders AS o
ON od.orderNumber = o.orderNumber
INNER JOIN customers AS c
ON c.customerNumber = o.customerNumber
WHERE p.productName LIKE '%Titanic%'
ORDER BY c.customerName;

#Nomor2
SELECT c.customerNumber, productName, STATUS, shippedDate
FROM orders AS o
INNER JOIN orderdetails AS od
ON o.orderNumber = od.orderNumber
INNER JOIN products AS p
ON od.productCode = p.productCode
INNER JOIN customers AS c
ON o.customerNumber = c.customerNumber
WHERE p.productName LIKE '%Ferrari%' AND o.status = 'Shipped' AND o.shippedDate BETWEEN '2003-10-01' AND '2004-10-01'
ORDER BY o.shippedDate DESC;

#Nomor3
SELECT * FROM employees;
SELECT s.firstName AS 'Supervisor', e.firstName AS 'Karyawan'
FROM employees AS e
INNER JOIN employees AS s
ON e.reportsTo = s.employeeNumber
WHERE s.firstName = 'Gerard'
ORDER BY e.firstName;

#Nomor4
SELECT * FROM employees;
#A
SELECT customerName, paymentDate, e.firstName AS 'employeeName', amount
FROM payments AS p
INNER JOIN customers AS c
ON c.customerNumber = p.customerNumber
INNER JOIN employees AS e
ON e.employeeNumber = c.salesRepEmployeeNumber
WHERE p.paymentDate LIKE '_____11%'
#B
ORDER BY p.amount DESC LIMIT 1;
#C
SELECT customerName, productName
FROM customers AS c
INNER JOIN orders AS o
ON o.customerNumber = c.customerNumber
INNER JOIN orderdetails AS od
ON od.orderNumber = o.orderNumber
INNER JOIN products AS pr
ON pr.productCode = od.productCode
WHERE customerName = 'Corporate Gift Ideas Co.';

#5 Tambahan
SELECT pl.productLine, p.paymentDate, offf.city
FROM productlines AS pl
INNER JOIN products AS pr
ON pl.productLine = pr.productLine
INNER JOIN orderdetails AS od
ON pr.productCode = od.productCode
INNER JOIN orders AS o
ON od.orderNumber = o.orderNumber
INNER JOIN customers AS c
ON o.customerNumber = c.customerNumber
INNER JOIN employees AS e
ON c.salesRepEmployeeNumber = e.employeeNumber
INNER JOIN offices AS offf
ON e.officeCode = offf.officeCode
INNER JOIN payments AS p
ON c.customerNumber = p.customerNumber
WHERE c.creditLimit > 100000;



