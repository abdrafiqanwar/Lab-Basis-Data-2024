#1
CREATE DATABASE sepakBola;

USE sepakBola;

CREATE TABLE klub(
	id INT AUTO_INCREMENT PRIMARY KEY,
	nama_klub VARCHAR(50) NOT NULL,
	kota_asal VARCHAR(20) NOT NULL
);

CREATE TABLE pemain (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nama_pemain VARCHAR(50) NOT NULL,
    posisi VARCHAR(20) NOT NULL,
    id_klub INT,
    FOREIGN KEY (id_klub) REFERENCES klub(id)
);

CREATE TABLE pertandingan(
	id INT AUTO_INCREMENT PRIMARY KEY,
	id_klub_tuan_rumah INT,
	id_klub_tamu INT,
	tanggal_pertandingan DATE NOT NULL,
	skor_tuan_rumah INT DEFAULT(0),
	skor_tamu INT DEFAULT(0),
	FOREIGN KEY(id_klub_tuan_rumah) REFERENCES klub(id),
	FOREIGN KEY(id_klub_tamu) REFERENCES klub(id)
);

ALTER TABLE pemain
ADD INDEX posisi(posisi);

ALTER TABLE klub
ADD INDEX kota_asal (kota_asal);

DESCRIBE klub;
DESCRIBE pemain;
DESCRIBE pertandingan;

###########

SELECT * FROM klub;
SELECT * FROM pemain;
SELECT * FROM pertandingan;

DROP DATABASE sepakbola;

#Soal tambahan

SET autocommit = OFF;

start TRANSACTION;

INSERT INTO klub(nama_klub,kota_asal)
VALUE('Chelsea', 'Inggris'),('Real Madrid C.F.', 'Spanyol');

INSERT INTO pemain(nama_pemain,posisi, id_klub)
VALUE('Cole Palmer', 'Gelandang Sarang', 1),('Endrick', 'Penyerang', 2);

INSERT INTO pertandingan(id_klub_tuan_rumah, id_klub_tamu, tanggal_pertandingan, skor_tuan_rumah, skor_tamu)
VALUE(1,1,'2024-08-07', 2,2),(2,1,'2024-08-07', 1,1);

COMMIT;

ROLLBACK;

###########

#2
USE classicmodels;
SELECT
	customerName,
	country,
	SUM(amount) AS totalPayment,
	COUNT(orderNumber) AS orderCount,
	MAX(paymentDate) AS LastPaymentDate,
	case
		when SUM(amount) > 100000 then 'VIP'
		when SUM(amount) < 5000 then 'New'
		ELSE 'Loyal'
	END AS status
FROM customers
left JOIN orders USING (customerNumber)
left JOIN payments USING (customerNumber)
GROUP BY customerName;

#3
SELECT
	customerNumber,
	customerName,
	SUM(quantityOrdered) AS total_quantity,
	case
		when sum(quantityOrdered)  > (SELECT AVG(total_quantity) FROM (SELECT
																								customerNumber,
																								SUM(quantityOrdered) AS total_quantity
																							FROM orders
																							JOIN orderdetails USING (orderNumber)
																							GROUP BY customerNumber)AS o) then 'di atas rata-rata'
		ELSE 'di bawah rata-rata'
	END AS kategori_pembelian
FROM customers
JOIN orders USING (customerNumber)
JOIN orderdetails USING (orderNumber)
GROUP by customerNumber
ORDER BY total_quantity DESC;




