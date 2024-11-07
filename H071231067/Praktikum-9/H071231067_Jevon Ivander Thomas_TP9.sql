USE classicmodels;
USE manajemen_sepak_bola;

# no1
CREATE DATABASE manajemen_sepak_bola;

CREATE TABLE klub(
	id INT AUTO_INCREMENT PRIMARY KEY,
	nama_klub VARCHAR(50) NOT NULL,
	kota_asal VARCHAR(20) NOT NULL
);
CREATE TABLE pemain(
	id INT AUTO_INCREMENT PRIMARY KEY,
	nama_pemain VARCHAR(20) NOT NULL,
	posisi VARCHAR(20) NOT NULL,
	id_klub INT NOT NULL,
	FOREIGN KEY (id_klub) REFERENCES klub(id)
);
CREATE TABLE pertandingan(
	id INT AUTO_INCREMENT PRIMARY KEY,
	id_klub_tuan_rumah INT NOT NULL,
	id_klub_tamu INT NOT NULL,
	tanggal_pertandingan DATE NOT NULL,
	skor_tuan_rumah INT DEFAULT 0,
	skor_tamu INT DEFAULT 0,
	FOREIGN KEY (id_klub_tuan_rumah) REFERENCES klub(id),
	FOREIGN KEY (id_klub_tamu) REFERENCES klub(id)
);
ALTER TABLE pemain
ADD INDEX index_posisi(posisi);
ALTER TABLE klub
ADD INDEX index_kota_asal(kota_asal);
DESCRIBE pemain;
DESCRIBE klub;
DESCRIBE pertandingan;

# no2
SELECT
	c.customerName,
	c.country,
	SUM(pa.amount) AS TotalPayment,
	COUNT(o.orderNumber) AS orderCount,
	MAX(pa.paymentDate) AS LastPaymentDate,
	case
		when SUM(pa.amount) > 100000 then 'VIP'
		when SUM(pa.amount) BETWEEN 5000 AND 100000 then 'Loyal'
	ELSE 'New'
	END AS status
FROM customers c
LEFT JOIN payments pa USING(customerNumber)
LEFT JOIN orders o USING(customerNumber)
GROUP BY c.customerNumber
ORDER BY c.customerName;

# no3
SELECT
	c.customerNumber,
	c.customerName,
	SUM(od.quantityOrdered) AS total_quantity,
	case
		when SUM(od.quantityOrdered) > (SELECT AVG(total) FROM 
												 (SELECT SUM(od.quantityOrdered) AS total FROM orderdetails od
												  JOIN orders o USING(orderNumber)
												  JOIN customers c USING(customerNumber)
												  GROUP BY c.customerNumber) AS hasil) then 'di atas rata-rata'
	ELSE 'di bawah rata-rata'
	END AS kategori_pembelian
FROM customers c
JOIN orders o USING(customerNumber)
JOIN orderdetails od USING(orderNumber)
GROUP BY c.customerNumber
ORDER BY total_quantity DESC;