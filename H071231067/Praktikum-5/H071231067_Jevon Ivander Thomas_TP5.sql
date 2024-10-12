-- Nomor 1
SELECT DISTINCT c.customerName AS namaKustomer, p.productName AS namaProduk, p.productDescription AS textDescription
FROM products AS p
INNER JOIN orderdetails AS od
	 ON p.productCode = od.productCode
INNER JOIN orders AS o
	 ON od.orderNumber = o.orderNumber
INNER JOIN customers AS c
	 ON c.customerNumber = o.customerNumber
WHERE p.productName LIKE '%Titanic%'
ORDER BY customerName;


-- Nomor 2
SELECT c.customerName, p.productName, o.status, o.shippedDate
FROM products AS p
INNER JOIN orderdetails AS od
	 USING (productCode)
INNER JOIN orders AS o
	 ON od.orderNumber = o.orderNumber
INNER JOIN customers AS c
	 ON c.customerNumber = o.customerNumber
WHERE p.productName LIKE '%ferrari%'
		AND 
		o.status = 'Shipped'
		AND
		o.shippedDate BETWEEN '2003-10-01' AND '2004-10-01'
ORDER BY o.shippedDate DESC;
		

-- Nomor 3
SELECT e1.firstName AS SuperVisor, e2.firstName AS Karyawan
FROM employees AS e1
INNER JOIN employees AS e2
	 ON e1.employeeNumber = e2.reportsTo 
WHERE e1.firstName = 'Gerard'
ORDER BY e2.firstName;


-- Nomor 4
-- A
SELECT c.customerName, p.paymentDate, e.firstName AS employeeName, p.amount
FROM customers AS c
INNER JOIN payments AS p
    ON c.customerNumber = p.customerNumber
INNER JOIN employees AS e
    ON c.salesRepEmployeeNumber = e.employeeNumber
WHERE p.paymentDate LIKE '%-11-%';

-- B
SELECT c.customerName, p.paymentDate, e.firstName AS employeeName, p.amount
FROM customers AS c
INNER JOIN payments AS p
    ON c.customerNumber = p.customerNumber
INNER JOIN employees AS e
    ON c.salesRepEmployeeNumber = e.employeeNumber
WHERE p.paymentDate LIKE '%-11-%'
ORDER BY p.amount DESC
LIMIT 1;

-- C
SELECT c.customerName, p.productName
FROM customers AS c
INNER JOIN orders AS o
	 ON o.customerNumber = c.customerNumber
INNER JOIN orderdetails AS od
	 ON o.orderNumber = od.orderNumber
INNER JOIN products AS p
	 ON p.productCode = od.productCode
WHERE c.customerName = 'Corporate Gift Ideas Co.';


-- Soal Tambahan
SELECT c.customerName, p.productName, pa.paymentDate, o.status
FROM customers AS c
INNER JOIN orders AS o
	 USING (customerNumber)
INNER JOIN payments AS pa
	 ON c.customerNumber = pa.customerNumber
INNER JOIN orderdetails AS od
	 USING (orderNumber)
INNER JOIN products AS p
	 USING (productCode)
WHERE p.productName LIKE '%ferrari%'
	 AND
	 STATUS = 'Shipped';
	 

