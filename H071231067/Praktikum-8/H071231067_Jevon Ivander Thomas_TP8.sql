-- No1
(SELECT
	p.productName,
	SUM(od.priceEach * od.quantityOrdered) AS TotalRevenue,
	'Pendapatan Tinggi' AS Pendapatan
FROM products p
JOIN orderdetails od USING(productCode)
JOIN orders o USING(orderNumber)
WHERE MONTH(o.orderDate) = 9
GROUP BY p.productCode
ORDER BY TotalRevenue DESC 
LIMIT 5)

UNION

(SELECT
	p.productName,
	SUM(od.priceEach * od.quantityOrdered) AS TotalRevenue,
	'Pendapatan Pendek (Kayak Kamu)'
FROM products p
JOIN orderdetails od USING(productCode)
JOIN orders o USING(orderNumber)
WHERE MONTH(o.orderDate) = 9
GROUP BY p.productCode
ORDER BY TotalRevenue ASC
LIMIT 5);


-- No2
SELECT productName
FROM products

EXCEPT

SELECT DISTINCT p.productName
FROM products p
JOIN orderdetails od USING(productCode)
JOIN orders o USING (orderNumber)
JOIN customers c USING (customerNumber)
WHERE c.customerNumber IN (
	SELECT c.customerNumber
	FROM orders o
	JOIN customers c USING (customerNumber)
	GROUP BY c.customerNumber
	HAVING COUNT(o.orderNumber) > 10
	
	INTERSECT
	
	SELECT c.customerNumber 
	FROM customers c
	JOIN orders o USING (customerNumber)
	JOIN orderdetails od USING (orderNumber)
	WHERE od.priceEach > (SELECT AVG(priceEach) FROM orderdetails)
	GROUP BY c.customerNumber
);
	
	
-- No3
SELECT
	c.customerName
FROM customers c
JOIN payments pa USING(customerNumber)
GROUP BY c.customerNumber
HAVING SUM(pa.amount) > 2 *(SELECT AVG(total) FROM
 									(SELECT SUM(amount) as total FROM payments GROUP BY customerNumber) AS tes)

INTERSECT

SELECT
	c.customerName
FROM customers c
JOIN orders o USING(customerNumber)
JOIN orderdetails od USING(orderNumber)
JOIN products p USING(productCode)
WHERE p.productLine IN('Planes','Trains')
GROUP BY c.customerNumber
HAVING SUM(od.quantityOrdered * od.priceEach) > 20000;

-- No4
SELECT
	o.orderDate AS Tanggal,
	c.customerNumber,
	'Membayar Pesanan dan Memesan Barang' AS 'riwayat'
FROM customers c
JOIN orders o USING(customerNumber)
JOIN payments pa ON o.orderDate = pa.paymentDate
WHERE o.orderdate LIKE '2003-09-%'

UNION

SELECT
	o.orderDate,
	c.customerNumber,
	'Memesan Barang'
FROM customers c
JOIN orders o USING(customerNumber)
WHERE o.orderdate LIKE '2003-09-%'
		AND 
		o.orderDate NOT IN (  
			SELECT pa.paymentDate AS 'Tanggal'
			FROM orders o
			JOIN customers c USING (customerNumber)
			JOIN payments pa ON o.orderDate = pa.paymentDate
			WHERE pa.paymentDate LIKE '2003-09-%')

UNION

SELECT
	pa.paymentDate,
	c.customerNumber,
	'Membayar Pesanan'
FROM customers c
JOIN payments pa USING(customerNumber)
WHERE pa.paymentDate LIKE '2003-09-%'
		AND 
		pa.paymentDate NOT IN (  
			SELECT o.orderDate AS 'Tanggal'
			FROM orders o
			JOIN customers c USING (customerNumber)
			JOIN payments pa ON o.orderDate = pa.paymentDate
			WHERE pa.paymentDate LIKE '2003-09-%')
ORDER BY Tanggal;

-- No5
SELECT
	p.productCode
FROM products p
JOIN orderdetails od USING(productCode)
JOIN orders o USING(orderNumber)
WHERE od.priceEach > (SELECT AVG(od.priceEach) FROM orderdetails od
							JOIN orders o USING(orderNumber)
							WHERE o.orderdate BETWEEN "2001-01-01" AND "2004-03-31")
		AND
		od.quantityOrdered > 48
		AND 
		LEFT(p.productVendor,1) IN ('a','i','u','e','o')				
GROUP BY p.productCode

EXCEPT

SELECT DISTINCT
	p.productCode
FROM products p
JOIN orderdetails od USING(productCode)
JOIN orders o USING(orderNumber)
JOIN customers c USING(customerNumber)
WHERE c.country IN('Japan','Germany','Italy');