-- no1
SELECT 
   productCode, 
   productName, 
   buyPrice
FROM products
WHERE buyPrice > (
   SELECT AVG(buyPrice) 
   FROM products
);

-- no2
SELECT
	o.orderNumber,
	o.orderdate
FROM orders o
JOIN customers c USING(customerNumber)
WHERE c.salesRepEmployeeNumber IN(
	SELECT e.employeeNumber
	FROM employees e
	JOIN offices USING(officeCode)
	WHERE city = 'Tokyo'
);

-- no3
SELECT
	c.customerName,
	o.orderNumber,
	o.shippedDate,
	o.requiredDate,
	GROUP_CONCAT(p.productName ORDER BY p.productName SEPARATOR ', ') AS products,
	SUM(od.quantityOrdered) AS total_quantity_ordered,
	CONCAT(e.firstName, ' ', e.lastName) AS employeeName
FROM customers c
JOIN employees e ON e.employeeNumber = c.salesRepEmployeeNumber
JOIN orders o USING (customerNumber)
JOIN orderdetails od USING (orderNumber)
JOIN products p USING (productCode)
WHERE o.orderNumber IN (
	SELECT o2.orderNumber
	FROM orders o2
	WHERE o2.shippedDate > o2.requiredDate
)
GROUP BY c.customerName;

-- no4
SELECT 
   p.productName,
   p.productLine,
   SUM(od.quantityOrdered) AS total_quantity_ordered
FROM products p
JOIN orderdetails od USING (productCode)
WHERE p.productLine IN (
	SELECT productLine FROM(
		SELECT 
			p2.productLine,
			SUM(od2.quantityOrdered) AS totalPerLines
		FROM products p2
		JOIN orderdetails od2 USING (productCode)
		GROUP BY p2.productLine
		ORDER BY totalPerLines DESC
		LIMIT 3
	) AS top3
)
GROUP BY p.productCode
ORDER BY p.productLine, total_quantity_ordered DESC;

-- soal tambahan
# mencari office yang memiliki customer yang paling sedikit total kali belanjanya
# outputnya 4 karena ada 4 customer yang belanja cuma 1 kali
SELECT
	OF.addressLine1,
	OF.addressLine2,
	OF.city,
	OF.country
FROM offices OF
JOIN employees e USING(officeCode)
JOIN customers c ON e.employeeNumber = c.salesRepEmployeeNumber
JOIN payments p USING(customerNumber)
GROUP BY c.customerNumber
HAVING COUNT(p.checkNumber) =(
		SELECT
			COUNT(p2.checkNumber) AS jumlah_transaksi
		FROM customers c2
		JOIN payments p2 USING(customerNumber)
		GROUP BY c2.customerNumber
		ORDER BY jumlah_transaksi
		LIMIT 1
);