USE classicmodels;

-- Nomor 1
SELECT customerNumber,
	customerName,
	country
FROM customers
WHERE (country = 'USA' AND creditLimit between 50000 AND 100000) 
	OR (country != 'USA' AND creditLimit BETWEEN 100000 AND 200000)
ORDER BY creditLimit DESC;

-- Nomor 2
SELECT productCode,
productName,
quantityInStock,
buyPrice
FROM products
WHERE (quantityInStock BETWEEN 1000 AND 2000)
AND (buyPrice < 50 OR buyPrice > 150)
AND (productLine not LIKE '%Vintage%')

-- Nomor 3
SELECT productCode,
productName,
MSRP
FROM products
WHERE (buyPrice > 50)
AND (productLine LIKE '%Classic%')

-- Nomor 4
SELECT orderNumber,
orderDate,
STATUS,
customerNumber
FROM orders
WHERE (orderNumber > 10250)
AND (STATUS NOT IN ('Shipped', 'Cancelled'))
AND (orderDate BETWEEN '2004-01-01' AND '2005-12-31')

-- Nomor 5
SELECT orderNumber,
orderLineNumber,
productCode,
quantityOrdered,
priceEach,
quantityOrdered * priceEach * 0.95 AS 'discountedTotalPrice'
FROM orderdetails
WHERE (quantityOrdered > 50)
AND (priceEach > 100)
AND (productCode NOT LIKE 'S18%') 
ORDER BY discountedTotalPrice DESC 