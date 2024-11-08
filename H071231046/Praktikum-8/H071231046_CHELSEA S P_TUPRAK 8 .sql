USE classicmodels;

#Nomor 1
(
  SELECT p.productName, 
         SUM(od.priceEach * od.quantityOrdered) AS TotalRevenue,
         'Pendapatan Tinggi' AS Pendapatan
  FROM orderdetails od
  JOIN orders o USING (orderNumber)
  JOIN products p USING (productCode)
  WHERE MONTH(o.orderDate) = 9
  GROUP BY p.productName
  ORDER BY TotalRevenue DESC
  LIMIT 5
)

UNION

(
  SELECT p.productName, 
         SUM(od.priceEach * od.quantityOrdered) AS TotalRevenue,
         'Pendapatan Pendek (kayak kamu)' AS Pendapatan
  FROM orderdetails od
  JOIN orders o USING (orderNumber)
  JOIN products p USING (productCode)
  WHERE MONTH(o.orderDate) = 9
  GROUP BY p.productName
  ORDER BY TotalRevenue ASC
  LIMIT 5
);

#Nomor 2
SELECT productName
FROM	(
    SELECT DISTINCT p.productName
    FROM products p
    #Produk yang Belum Pernah Dipesan oleh Pelanggan dengan Lebih dari 10 Pesanan
    LEFT JOIN (
        SELECT DISTINCT od.productCode
        FROM orderdetails od
        JOIN orders o using(orderNumber)
        WHERE o.customerNumber IN (
        		# apakah nilai dari kolom dalam query utama ada di dalam daftar nilai yang dihasilkan oleh subquery.
            SELECT customerNumber
            FROM orders
            GROUP BY customerNumber
            HAVING COUNT(orderNumber) > 10
        )
    ) AS od2 using(productCode)
    WHERE od2.productCode IS NULL
    
    UNION
    
    SELECT DISTINCT p.productName
    FROM products p
    JOIN (
    	# Produk yang Pernah Dipesan dengan Harga di Atas Rata-Rata
        SELECT DISTINCT od.productCode
        FROM orderdetails od
        JOIN products p using(productCode)
        WHERE od.priceEach > (SELECT AVG(od.priceEach) FROM products)
    ) AS above_avg_price using(productCode)
) AS products;

#Nomor 3
#Pelanggan dengan Total Pembayaran Lebih dari Dua Kali Rata-rata
SELECT customername
FROM customers
JOIN payments	
GROUP BY customername
HAVING SUM(amount) > (
	SELECT 2*AVG(amount)
	FROM payments
)

INTERSECT

#Pelanggan yang Pernah Memesan Produk dari "Planes" atau "Trains" dengan Total Pembelian Lebih dari 20.000
SELECT customername
FROM payments
JOIN customers USING (customernumber)
JOIN orders USING (customernumber)
JOIN orderdetails USING(ordernumber)
JOIN products USING(productcode)
WHERE productline IN ('Planes', 'Trains')
GROUP BY customername
HAVING SUM(buyprice) > 20000;


#Nomor 4
SELECT Tanggal, customerNumber,
GROUP_CONCAT(DISTINCT riwayat SEPARATOR ' dan ') riwayat
FROM (
	SELECT orderdate Tanggal,
			 customerNumber, 
			 'Memesan Barang' riwayat
	FROM orders
	WHERE orderdate LIKE '2003-09%'
	
	UNION 
	
	SELECT paymentdate Tanggal,
			 customernumber,
			 'Membayar Pesanan' riwayat
	FROM payments
	WHERE paymentdate LIKE '2003-09%'
) miaw
GROUP BY Tanggal;

#Nomor 5
SELECT DISTINCT p.productCode
FROM products p
JOIN orderdetails od 
USING(productCode)
JOIN orders o 
USING(orderNumber)
WHERE od.priceEach > (
    SELECT AVG(od2.priceEach)
    FROM orderdetails AS od2
    JOIN orders AS o2 
	 USING(orderNumber)
    WHERE o2.orderDate BETWEEN '2001-01-01' AND '2004-05-31'
) 
AND od.quantityOrdered > 48 
#left digunakan untuk mengambil karakter pertama dalam suatu string
AND LEFT(p.productVendor, 1) IN ('A', 'I', 'U', 'E', 'O')

EXCEPT

SELECT p.productCode
FROM products AS p
JOIN orderdetails AS od USING(productCode)
JOIN orders AS o USING(orderNumber)
JOIN customers AS c USING(customerNumber)
WHERE c.country IN ('Japan', 'Germany', 'Italy')
ORDER BY productCode ASC;


