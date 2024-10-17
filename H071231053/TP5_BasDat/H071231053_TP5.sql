SELECT * FROM customers;
SELECT * FROM employees;
SELECT * FROM offices;
SELECT * FROM orders;
SELECT * FROM payments;
SELECT * FROM orderdetails;
SELECT * FROM productlines;
SELECT * FROM products;

#no1
SELECT DISTINCT c.customerName, p.productName, p.productDescription
FROM customers 
JOIN orders AS o 
ON c.customerNumber = o.customerNumber
JOIN orderdetails od 
ON o.orderNumber = od.orderNumber
JOIN products p 
ON od.productCode = p.productCode
WHERE p.productName LIKE '%Titanic%'
ORDER BY c.customerName;

#no.2
SELECT c.customerName, p.productName, o.status, o.shippedDate
FROM customers c 
JOIN orders AS o 
ON c.customerNumber = o.customerNumber
JOIN orderdetails od 
ON o.orderNumber = od.orderNumber
JOIN products p 
ON od.productCode = p.productCode
WHERE productName LIKE '%Ferrari%'
  AND status = 'Shipped'
  AND shippedDate BETWEEN '2003-10-01' AND '2004-10-01'
ORDER BY shippedDate DESC;

SELECT emp.firstName AS supervisor, e.firstName AS karyawan
FROM employees e
JOIN employees emp 
ON e.reportsTo = emp.employeeNumber
WHERE emp.firstName = 'Gerard'

#4a
SELECT c.customerName, p.paymentdate, e.firstName, p.amount
FROM customers c
JOIN payments p
ON c.customerNumber = p.customerNumber 
JOIN employees e
ON c.salesRepEmployeeNumber = e.employeeNumber
WHERE p.paymentDate LIKE '%-11-%' 

#4b
SELECT c.customerName, p.paymentdate, e.firstName, p.amount
FROM customers c
JOIN payments p
ON c.customerNumber = p.customerNumber 
JOIN employees e
ON c.salesRepEmployeeNumber = e.employeeNumber
WHERE p.paymentDate LIKE '%-11-%'
ORDER BY p.amount DESC 
LIMIT 1; 

#4c
SELECT c.customerName, p.productName
FROM customers c
JOIN orders o
ON c.customernumber = o.customernumber
JOIN orderdetails odt
ON o.orderNumber = odt.ordernumber
JOIN products p
ON odt.productCode = p.productCode 
JOIN payments py
ON c.customerNumber = py.customernumber WHERE py.paymentDate LIKE '%-11-%' AND customername = "Corporate Gift Ideas Co.";


--Soal Tambahan
-- pembayaran dikasi 100k+
-- kasi show productline,custumername, amount 100k

SELECT c.customerName, py.amount, p.productLine
FROM customers c
JOIN orders o
ON c.customerNumber = o.customerNumber
JOIN orderdetails odt
ON o.orderNumber = odt.orderNumber
JOIN products p
ON odt.productCode = p.productCode
JOIN payments py
ON c.customerNumber= py.customerNumber 
WHERE py.amount >= 100000