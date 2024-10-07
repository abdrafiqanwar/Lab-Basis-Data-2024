USE classicmodels
-- nomor 1
SELECT * FROM customers
SELECT customerNumber, customerName, country FROM customers
WHERE country = 'USA' AND creditLimit > 50000 AND creditLimit < 100000
OR country <> 'USA' AND creditLimit BETWEEN 100000 AND 200000
ORDER BY creditLimit DESC;

-- nomor 2
SELECT * FROM products
SELECT productCode, productName, quantityInStock, buyPrice FROM products
WHERE quantityInStock BETWEEN 1000 AND 2000 AND buyPrice < 50 OR buyPrice > 150
AND productLine NOT LIKE  '%Vintage%';

-- nomor 3
SELECT productCode, productName, msrp FROM products
WHERE productLine LIKE '%classic%' AND buyPrice > 50;

-- nomor 4
SELECT * FROM orders
SELECT orderNumber, orderDate, STATUS, customerNumber FROM orders
WHERE orderNumber > 10250 AND STATUS !='shipped' AND STATUS <> 'cancelled'
AND orderDate BETWEEN '2003-12-31' AND '2005-12-31';

-- nomor 5
SELECT * FROM orderdetails
SELECT orderNumber, orderLineNumber, productCode, quantityOrdered, priceEach, priceEach * quantityOrdered * 0.95 AS discountedTotalPrice
FROM orderdetails
WHERE quantityOrdered > 50 AND priceEach > 100
AND productCode NOT LIKE '%S18%'
ORDER BY discountedTotalPrice DESC;