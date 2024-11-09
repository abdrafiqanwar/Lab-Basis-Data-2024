
# Nomor 1
CREATE DATABASE sepakbola;
USE sepakbola;

CREATE TABLE club (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nama_club VARCHAR(50) NOT NULL,
    kota_asal VARCHAR(20) NOT NULL
);

CREATE TABLE pemain (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nama_pemain VARCHAR(50) NOT NULL, 
    posisi VARCHAR(20) NOT NULL,
    id_club INT,
    FOREIGN KEY (id_club) REFERENCES club(id)
);

CREATE TABLE pertandingan (
    id INT PRIMARY KEY AUTO_INCREMENT,
    id_club_tuan_rumah INT,
    id_club_tamu INT,
    tanggal_pertandingan DATE NOT NULL,
    skor_tuan_rumah INT DEFAULT 0,
    skor_tamu INT DEFAULT 0,
    FOREIGN KEY (id_club_tuan_rumah) REFERENCES club(id),
    FOREIGN KEY (id_club_tamu) REFERENCES club(id)
);

DESCRIBE club;
DESCRIBE pemain;
DESCRIBE pertandingan;

#membuat index
CREATE INDEX id_posisi ON pemain(posisi);
CREATE INDEX id_kota_asal ON club(kota_asal);

SHOW INDEXES FROM pemain;

# Nomor 2
USE classicmodels;

SELECT 
    c.customerName, 
    c.country, 
    SUM(p.amount) AS `totalPayment`, 
    COUNT(DISTINCT o.orderNumber) AS `total_orders`,
    MAX(paymentDate) AS `last_payment_date`,
    CASE 
    	WHEN SUM(p.amount)  > 100000 then 'VIP'
		WHEN SUM(p.amount)  BETWEEN 5000 AND 100000 then 'Loyal'
		ELSE 'New'
	END AS `Status`
FROM customers c
LEFT JOIN orders o 
USING(customerNumber)
LEFT JOIN payments p 
USING(customerNumber)
GROUP BY c.customerName;
    
# Nomor 3
SELECT customerNumber,customerName, count(orderNumber), SUM(quantityOrdered) `total`,
CASE 
WHEN SUM(quantityordered) > 
	(SELECT AVG(total_hasil)
	FROM 
		(SELECT SUM(quantityOrdered) AS total_hasil
		FROM orderdetails GROUP BY orderNumber) AS total)
	THEN 'di atas rata-rata'
ELSE 'di bawah rata rata'
END AS kategori
FROM customers c
JOIN orders 
USING(customerNumber)
JOIN orderdetails od
USING(orderNumber)
GROUP BY c.customerNumber
ORDER BY total DESC;

# Nomor 4
START TRANSACTION;

INSERT INTO club VALUES(1,'Barca', 'Eropa');

SELECT * FROM club;

ROLLBACK;