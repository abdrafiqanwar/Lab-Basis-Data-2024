-- A.M.Yusran Mazidan
-- H071231064
USE classicmodels;

SELECT * FROM customers;
SELECT * FROM products;
SELECT * FROM orders;
SELECT * FROM orderdetails;

-- Nomor 1
SELECT customerNumber, customerName, country, creditLimit 
FROM customers 
WHERE (country = 'USA' AND creditLimit BETWEEN 50000 AND 100000)
   OR (country != 'USA' AND creditLimit BETWEEN 100000 AND 200000)
ORDER BY creditLimit DESC;

-- Nomor 2
SELECT productCode, productName, quantityInStock, buyPrice
FROM products
WHERE (quantityInStock BETWEEN 1000 AND 2000) 
AND (buyPrice BETWEEN 50 AND 150) 
AND (productLine NOT LIKE '%Vintage%');

-- Nomor 3
SELECT productCode, productName, MSRP
FROM products
WHERE productLine LIKE '%Classic%' AND buyPrice > 50;

-- Nomor 4
SELECT orderNumber, orderDate, status, customerNumber
FROM orders
WHERE (orderNumber > 10250) 
AND (status NOT IN ('Shipped','Cancelled'))
AND (orderDate LIKE '2004-%' AND '2005-%');

-- Nomor 5
SELECT orderNumber, orderLineNumber, productCode, quantityOrdered, priceEach
, (priceEach * 95/100) AS discountedTotalPrice
FROM orderdetails
WHERE (quantityOrdered > 50)
AND (priceEach > 100)
AND (productCode NOT LIKE 'S18_%')
ORDER BY discountedTotalPrice DESC;
