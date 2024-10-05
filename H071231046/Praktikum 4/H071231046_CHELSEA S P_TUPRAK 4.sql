USE classicmodels;


#Nomor 1
Select * from customers;

SELECT
	customerNumber,
	customerName,
	country
FROM customers
WHERE (country = 'USA' AND creditlimit BETWEEN 50000 AND 99999) OR (country != 'USA' AND creditlimit BETWEEN 100000 AND 200000)
ORDER BY creditlimit DESC;

#Memastikan
SELECT country, city, creditlimit FROM customers
WHERE country = 'USA' AND  creditlimit  between 50000 AND 999999
ORDER BY creditlimit DESC;



#Nomor 2
Select * from products;
SELECT 
	productCode,
	productName,
	quantityInStock,
	buyPrice
FROM products
WHERE 
	(quantityInStock BETWEEN 1000 AND 2000)
   AND (buyPrice < 50 OR buyPrice > 150)
   AND productLine NOT LIKE '%Vintage%';
   
#Memastikan
SELECT productline, quantityInstock 
FROM products
WHERE 
	quantityInStock BETWEEN 1000 AND 2000
	AND productLine NOT LIKE 'Vintage%';


#Nomor 3
SELECT * FROM products;
SELECT 
	productCode,
	productName,
	MSRP
FROM products
WHERE productLine LIKE '%Classic%'
		AND (buyPrice > 50);
		
#Memastikan
SELECT 
	productName,
	productLine,
	buyprice
FROM products
WHERE productline LIKE 'Classic%'
		AND buyprice > 50;
		


#Nomor 4
SELECT * FROM orders;
SELECT
	orderNumber,
	orderDate,
	STATUS,
	customerNumber
FROM orders
WHERE ordernumber > 10250
		AND STATUS NOT IN ('Shipped','Cancelled')
		AND orderDate BETWEEN '2004-01-01' AND '2005-12-31';
		
		
#Nomor 5
SELECT * FROM orderdetails;
SELECT
	orderNumber,
	orderLineNumber,
	productCode,
	quantityOrdered,
	priceEach,
	quantityordered * priceEach * (0.95) as discountedTotalPrice 
from orderdetails
WHERE quantityOrdered > 50
		AND priceEach > 100
		AND productcode NOT LIKE 'S18%'
ORDER BY discountedTotalPrice DESC;

