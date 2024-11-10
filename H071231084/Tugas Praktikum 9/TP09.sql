-- Nomor 1
CREATE DATABASE football;

USE football;

CREATE TABLE klub (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nama_klub VARCHAR(50) NOT NULL,
    kota_asal VARCHAR(20) NOT NULL
);

CREATE TABLE pemain (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nama_pemain VARCHAR(50) NOT NULL,
    posisi VARCHAR(20) NOT NULL,
    id_klub INT,
    FOREIGN KEY (id_klub) REFERENCES klub (id)
);

CREATE TABLE pertandingan (
    id INT AUTO_INCREMENT PRIMARY KEY,
    id_klub_tuan_rumah INT,
    id_klub_tamu INT,
    FOREIGN KEY (id_klub_tuan_rumah) REFERENCES klub (id),
    FOREIGN KEY (id_klub_tamu) REFERENCES klub (id),
    tanggal_pertandingan DATE NOT NULL,
    skor_tuan_rumah INT DEFAULT 0,
    skor_tamu INT DEFAULT 0
);

CREATE INDEX index_posisi_pemain ON pemain (posisi);

CREATE INDEX index_kota_asal_klub ON klub (kota_asal);

-- Nomor 2
USE classicmodels;

SELECT
    customerName,
    country,
    SUM(amount) TotalPayment,
    COUNT(orderNumber) orderCount,
    MAX(paymentdate) LastPaymentDate,
    case
        when SUM(amount) > 100000 then 'VIP'
        when SUM(amount) BETWEEN 5000 AND 100000  then 'Loyal'
        ELSE 'New'
    END AS Status
FROM customers
    LEFT JOIN payments USING (customerNumber)
    LEFT JOIN orders USING (customerNumber)
GROUP BY
    customerNumber
ORDER BY customerName;

-- Nomor 3
SELECT
    customerNumber,
    customerName,
    SUM(quantityOrdered) total_quantity,
    CASE
        WHEN SUM(quantityOrdered) > (SELECT AVG(totalQuantity)
		  FROM (SELECT SUM(quantityOrdered) totalQuantity
		  			FROM orderdetails
					JOIN orders USING(orderNumber)
					GROUP BY customerNumber) AS a) THEN 'di atas rata-rata'
        ELSE 'di bawah rata-rata'
    END AS kategori_pembelian
FROM customers
	JOIN orders USING (customerNumber)
	JOIN orderdetails USING (orderNumber)
GROUP BY customerNumber
ORDER BY total_quantity DESC


USE football
START TRANSACTION

INSERT INTO klub(nama_klub, kota_asal) 
	VALUES('Klub A', 'Makassar')

SELECT * FROM klub	

ROLLBACK 

COMMIT 