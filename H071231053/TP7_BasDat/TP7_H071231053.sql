USE classicmodels;
#no1
SELECT productcode,productname,buyprice
FROM products
WHERE buyprice > (SELECT AVG(buyprice) FROM products);

#No2
SELECT ordernumber,orderdate FROM orders AS o
JOIN customers AS c
ON o.customerNumber = c.customerNumber
JOIN employees AS e
ON c.salesRepEmployeeNumber = e.employeeNumber
JOIN offices AS ofc
ON e.officeCode = ofc.officeCode
WHERE c.salesrepemployeenumber IN (SELECT employeenumber FROM employees 
WHERE officeCode = (SELECT officeCode from offices WHERE city='Tokyo'));

#No 3
SELECT c.customerName`customerName`, o.orderNumber orderNumber, o.shippedDate ,
o.requiredDate, GROUP_CONCAT(p.productName ORDER BY p.productName)  products, SUM(od.quantityOrdered) total_quantity_ordered, 
CONCAT(e.firstName, ' ', e.lastName) employeeName
FROM customers c
JOIN orders o
USING(customerNumber)
JOIN orderdetails od
USING(orderNumber)
JOIN products p
USING(productCode)
JOIN employees e
ON e.employeeNumber = c.salesRepEmployeeNumber
where o.orderNumber in (SELECT orderNumber FROM orders
WHERE requiredDate < shippedDate)
GROUP BY c.customerName;

#no 4
SELECT p.productName, p.productLine, SUM(od.quantityOrdered) AS total
FROM products p
JOIN orderdetails od USING(productCode)
WHERE p.productLine IN (
    SELECT total_quantity
        FROM (
            SELECT productLine AS total_quantity
            FROM products p3
            JOIN orderdetails od3 USING (productCode)
            GROUP BY p3.productLine
            ORDER BY sum(od3.quantityOrdered) DESC
            LIMIT 3
        ) AS top3
)
GROUP BY p.productName, p.productLine
ORDER BY p.productLine, total DESC;