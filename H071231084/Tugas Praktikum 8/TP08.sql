USE classicmodels;

-- Nomor 1
(SELECT
	productName,
	SUM(priceEach * quantityOrdered) TotalRevenue,
	'Pendapatan Tinggi' Pendapatan
FROM
	products
	JOIN orderdetails USING(productCode) 
	JOIN orders USING(orderNumber)
WHERE
	MONTH(orderDate) = 9
GROUP BY
	productName	  
ORDER BY
	TotalRevenue DESC
LIMIT 5)

UNION

(SELECT
	productName,
	SUM(priceEach * quantityOrdered) TotalRevenue,
	'Pendapatan Rendah' Pendapatan
FROM
	products
	JOIN orderdetails USING(productCode) 
	JOIN orders USING(orderNumber)
WHERE
	MONTH(orderDate) = 9
GROUP BY
	productName	  
ORDER BY
	TotalRevenue
LIMIT 5)
 
-- Nomor 2
SELECT productName
FROM products
WHERE productCode NOT IN (
    SELECT productCode
    FROM orderdetails
    JOIN orders USING (orderNumber)
    WHERE customerNumber IN
	 (SELECT customerNumber
	  FROM customers
	  JOIN orders USING(customerNumber)
	  GROUP BY customerNumber
	  HAVING COUNT(orderNumber) > 10

	  INTERSECT 

	  SELECT customerNumber
	  FROM customers
	  JOIN orders USING(customerNumber)
	  JOIN orderdetails USING(orderNumber)
	  JOIN products USING(productCode)
	  where buyPrice > (SELECT AVG(buyPrice) FROM products)))

-- Nomor 3
SELECT
	customerName
FROM
	customers
	JOIN payments USING (customerNumber)
GROUP BY customerNumber
HAVING SUM(amount) > 2 * (SELECT AVG(amount) FROM 
															(SELECT SUM(amount) amount
															FROM payments
															GROUP BY customerNumber) AS a)

INTERSECT 

SELECT 
   customerName
FROM 
	customers 
   JOIN orders USING (customerNumber)
   JOIN orderdetails USING (orderNumber)
   JOIN products USING (productCode)
WHERE 
   productLine IN ('Planes', 'Trains')
GROUP BY 
   customerName
HAVING 
   SUM(quantityOrdered * priceEach) > 20000;

-- Nomor 4
SELECT
	Tanggal,
	CustomerNumber,
	GROUP_CONCAT(distinct riwayat SEPARATOR ' dan ') riwayat
FROM 
	(SELECT
		orderDate Tanggal,
		customerNumber,
		'Memesan Barang' riwayat
	FROM orders
	WHERE orderDate LIKE '2003-09%'
	UNION 
	SELECT
		paymentDate Tanggal,
		customerNumber,
		'Membayar Pesanan' riwayat
	FROM payments
	WHERE paymentDate LIKE '2003-09%') AS a
GROUP BY Tanggal

-- Nomor 5
SELECT productCode
FROM products
JOIN orderdetails USING(productCode)
JOIN orders USING(orderNumber)
JOIN customers USING(customerNumber)
WHERE priceEach > (SELECT AVG(priceEach)
						FROM orderdetails
						JOIN orders USING(orderNumber)
						WHERE orderDate BETWEEN '2001-01-01' AND '2004-03-31')
AND LEFT(productVendor, 1) IN ('A', 'I', 'U', 'E', 'O')
AND (quantityOrdered > 48)

EXCEPT 

SELECT productCode
FROM products
JOIN orderdetails USING(productCode)
JOIN orders USING(orderNumber)
JOIN customers USING(customerNumber)
WHERE country IN ('Japan', 'Germany', 'Italy')

ORDER BY productCode