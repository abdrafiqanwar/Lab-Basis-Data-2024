-- Nomor 1
SELECT customerNumber, customerName, country FROM customers
WHERE country = 'USA' AND creditlimit BETWEEN 50000 AND 100000
		OR 
		country != 'USA' AND creditlimit BETWEEN 100000 AND 200000
ORDER BY creditLimit DESC;
		
-- Nomor 2
SELECT productCode, productName, quantityInStock, buyPrice FROM products
WHERE quantityInStock BETWEEN 1000 AND 2000
		AND
		buyPrice NOT BETWEEN 50 AND 150
		AND
		productLine NOT LIKE '%vintage%';
		
-- Nomor 3
SELECT productCode, productName, MSRP FROM products
WHERE productLine LIKE '%Classic%'
		AND
		buyPrice > 50;
		
-- Nomor 4
SELECT orderNumber, orderDate, status, customerNumber FROM orders
WHERE orderNumber > 10250
		AND
		STATUS NOT IN('Shipped','Cancelled')
		AND
		orderDate BETWEEN '2004-01-01' AND '2005-12-31';
		
-- Nomor 5
SELECT orderNumber, orderLineNumber, productCode, quantityOrdered, priceEach,
quantityOrdered * priceEach * 0.95 AS discountedTotalPrice
FROM orderdetails
WHERE quantityOrdered > 50
		AND
		priceEach > 100
		AND
		productCode not LIKE 'S18%'
ORDER BY discountedTotalPrice DESC;



