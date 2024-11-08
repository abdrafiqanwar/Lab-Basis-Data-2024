USE classicmodels;

# Nomor 1
SELECT productCode, productName, buyPrice
FROM products
WHERE buyPrice > (SELECT AVG(buyPrice) FROM products);

# Nomor 2
SELECT orderNumber, orderDate
FROM orders
WHERE customerNumber IN (
    SELECT customerNumber
    FROM customers
    WHERE salesRepEmployeeNumber IN (
        SELECT employeeNumber
        FROM employees
        WHERE officeCode = (
            SELECT officeCode
            FROM offices
            WHERE city = 'Tokyo'
        )
    )
);

# Nomor 3
SELECT 
    c.customerName,
    o.orderNumber,
    o.shippedDate,
    o.requiredDate,
    (
        SELECT GROUP_CONCAT(p.productName SEPARATOR ', ')
        FROM orderdetails od
        JOIN products p ON od.productCode = p.productCode
        WHERE od.orderNumber = o.orderNumber
    ) AS products,
    (
        SELECT SUM(od.quantityOrdered)
        FROM orderdetails od
        WHERE od.orderNumber = o.orderNumber
    ) AS total_quantity_ordered,
    CONCAT(e.firstName, ' ', e.lastName) AS employeeName
FROM orders o
JOIN customers c 
    ON o.customerNumber = c.customerNumber
JOIN employees e 
    ON c.salesRepEmployeeNumber = e.employeeNumber
WHERE DATEDIFF(o.shippedDate, o.requiredDate) > 0
GROUP BY o.orderNumber;

# Nomor 4
SELECT 
    p.productName,
    p.productLine,
    SUM(od.quantityOrdered) AS total_quantity_ordered
FROM products p
JOIN orderdetails od ON p.productCode = od.productCode
WHERE p.productLine IN (
    SELECT productLine 
    FROM (
        SELECT productLine
        FROM products p
        JOIN orderdetails od ON p.productCode = od.productCode
        JOIN orders o ON od.orderNumber = o.orderNumber
        GROUP BY p.productLine
        ORDER BY SUM(od.quantityOrdered) DESC
        LIMIT 3
    ) AS topCategories
)
GROUP BY p.productName, p.productLine
ORDER BY p.productLine, total_quantity_ordered DESC;

# Nomor 5
SELECT o.addressLine1, o.addressLine2, o.city, o.country
FROM offices o
JOIN employees e
USING (officeCode)
JOIN customers c
ON e.employeeNumber = c.salesRepEmployeeNumber
JOIN payments p
USING (customerNumber)
GROUP BY c.customerNumber
HAVING COUNT(p.customerNumber) = (
	SELECT COUNT(p.customerNumber)
	FROM customers c
	JOIN payments p
	USING (customerNumber)
    JOIN employees e
    ON e.employeeNumber = c.salesRepEmployeeNumber
	GROUP BY (p.customerNumber)
	ORDER BY COUNT(p.customerNumber) LIMIT 1
    );