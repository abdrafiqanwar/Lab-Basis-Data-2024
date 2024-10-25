USE classicmodels;

# Nomor 1
SELECT productCode, productName, buyPrice
FROM products
WHERE buyPrice > (SELECT AVG(buyPrice) FROM products);

# Nomor 2
SELECT orderNumber, orderDate
FROM orders 
JOIN customers 
USING(customerNumber)
WHERE salesRepEmployeeNumber IN (SELECT employeeNumber
											FROM employees
											JOIN offices
											USING (officeCode)
											WHERE city = 'Tokyo');
									
# Nomor 3
SELECT
	customerName,
	orderNumber,
	shippedDate,
	requiredDate, 
	GROUP_CONCAT(productName SEPARATOR ', ') products,
	SUM(quantityOrdered) total_quantity_ordered,
	CONCAT(firstName, ' ', lastName) AS employeeName
FROM customers
JOIN orders
USING(customerNumber)
JOIN orderdetails
USING(orderNumber)
JOIN products
USING(productCode)
JOIN employees
ON salesRepEmployeeNumber = employeeNumber
WHERE orderNumber IN (SELECT orderNumber 
							FROM orders
							WHERE requiredDate < shippedDate); 

# Nomor 4
SELECT productName, productLine, SUM(quantityOrdered) total_quantity_ordered
FROM products
JOIN orderDetails
USING(productCode)
WHERE productLine IN (SELECT * FROM
		(SELECT productLine
		FROM products
		JOIN orderDetails
		USING(productCode)
		GROUP BY productLine
		ORDER BY SUM(quantityOrdered) DESC
		LIMIT 3) top3)
GROUP BY productCode
ORDER BY productLine, total_quantity_ordered DESC; 

-- soal tambahan
SELECT CONCAT(firstName, ' ', lastName) nama_karyawan,
SUM(amount) pendapatan
FROM employees e
JOIN customers c
ON c.salesRepEmployeeNumber = e.employeeNumber
JOIN payments
USING(customerNumber)
GROUP BY employeeNumber
HAVING pendapatan IN ((SELECT pend FROM
		(SELECT SUM(amount) pend
		FROM employees e
		JOIN customers c
		ON c.salesRepEmployeeNumber = e.employeeNumber
		JOIN payments
		USING(customerNumber)
		GROUP BY employeeNumber
		ORDER BY SUM(amount) DESC
		LIMIT 1) AS maks_pendapatan),
		
		(SELECT pend FROM
		(SELECT SUM(amount) pend
		FROM employees e
		JOIN customers c
		ON c.salesRepEmployeeNumber = e.employeeNumber
		JOIN payments
		USING(customerNumber)
		GROUP BY employeeNumber
		ORDER BY SUM(amount) 
		LIMIT 1) AS min_pendapatan))
