USE classicmodels;

#Nomor 1
SELECT productCode, productName, buyPrice
FROM products
WHERE buyPrice > (SELECT AVG(buyPrice) FROM products);

#Nomor 2
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

#Jika menggunakan inner join
SELECT orders.orderNumber, orders.orderDate
FROM orders
INNER JOIN customers ON orders.customerNumber = customers.customerNumber
INNER JOIN employees ON customers.salesRepEmployeeNumber = employees.employeeNumber
INNER JOIN offices ON employees.officeCode = offices.officeCode
WHERE offices.city = 'Tokyo';



#Nomor 3
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

#Menggunakan inner join
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


#Nomor 4
SELECT 
    p.productName,
    p.productLine,
    SUM(od.quantityOrdered) AS total_quantity_ordered
FROM products p
JOIN orderdetails od ON p.productCode = od.productCode
WHERE p.productLine IN (
    SELECT productLine 
    FROM (
        SELECT productLine, SUM(od.quantityOrdered) AS total_quantity_ordered
        FROM products p
        JOIN orderdetails od ON p.productCode = od.productCode
        JOIN orders o ON od.orderNumber = o.orderNumber
        GROUP BY p.productLine
        ORDER BY total_quantity_ordered DESC
        LIMIT 3
    ) AS topCategories
)
GROUP BY p.productName, p.productLine
ORDER BY p.productLine, total_quantity_ordered DESC;

#Soal tambahan
SELECT 
	c.customerName,
	sum(p.amount) "Total Pembayaran"
FROM customers c
JOIN payments p
USING(customerNumber)
GROUP BY c.customername
having 	sum(p.amount)  > (
	SELECT AVG(`Jumlah`)
	FROM (
		SELECT SUM(p1.amount) AS "Jumlah"
		FROM payments p1
		GROUP BY p1.customerNumber
	) AS tabel ) 