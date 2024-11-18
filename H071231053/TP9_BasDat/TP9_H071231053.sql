-- nomor 1
CREATE DATABASE Soccer_Management;
USE DATABASE Soccer_Management

CREATE TABLE Klub (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nama_klub VARCHAR(50) NOT NULL,
    kota_asal VARCHAR(20) NOT NULL
);

CREATE TABLE Pemain (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nama_pemain VARCHAR(50) NOT NULL,
    posisi VARCHAR(20) NOT NULL,
    id_klub INT,
    FOREIGN KEY (id_klub) REFERENCES Klub(id)
);

CREATE TABLE Pertandingan (
    id INT AUTO_INCREMENT PRIMARY KEY,
    id_klub_tuan_rumah INT,
    id_klub_tamu INT,
    tanggal_pertandingan DATE NOT NULL,
    skor_tuan_rumah INT DEFAULT 0,
    skor_tamu INT DEFAULT 0,
    FOREIGN KEY (id_klub_tuan_rumah) REFERENCES Klub(id),
    FOREIGN KEY (id_klub_tamu) REFERENCES Klub(id)
);




CREATE INDEX idx_posisi ON Pemain(posisi);

CREATE INDEX idx_kota_asal ON Klub(kota_asal);

-- nomor 2
USE classicmodels;
#customer order dan payments
SELECT 
    customername,
    country,
    SUM(amount) AS totalpayment,
    COUNT(orderNumber) AS ordercount,
    MAX(paymentdate) AS lastpaymentdate,
    CASE 
        WHEN SUM( amount) > 100000 THEN 'VIP'
        WHEN SUM( amount) BETWEEN 5000 AND 100000 THEN 'Loyal'
        WHEN SUM( amount) < 5000 THEN 'New'
        WHEN SUM( amount) IS NULL THEN 'New'
    END AS STATUS
FROM 
    customers AS c
LEFT JOIN 
    orders AS o ON c.customernumber = o.customernumber
LEFT JOIN 
    payments AS p ON c.customernumber = p.customernumber
GROUP BY 
    customername, country;
--  nomor 3
SELECT 
    c.customerNumber,
    c.customerName,
    SUM(odt.quantityOrdered) AS total_quantity,
    CASE 
        WHEN SUM(odt.quantityOrdered) > (SELECT AVG(total_quantity) 
                                         FROM (SELECT customerNumber, SUM(quantityOrdered) AS total_quantity 
                                               FROM orders AS o
                                               JOIN orderdetails AS odt ON o.orderNumber = odt.orderNumber
                                               GROUP BY customerNumber) AS avg_table) 
        THEN 'di atas rata-rata'
        ELSE 'di bawah rata-rata'
    END AS kategori_pembelian
FROM 
    customers AS c
JOIN 
    orders AS o ON c.customerNumber = o.customerNumber
JOIN 
    orderdetails AS odt ON o.orderNumber = odt.orderNumber
GROUP BY 
    c.customerNumber, c.customerName
ORDER BY 
    total_quantity DESC;
    
    
START TRANSACTION 

SELECT id,nama_klub, kota_asal FROM klub

INSERT INTO klub (id,nama_klub,kota_asal)
VALUES(1,'persib','bandung'),
		(2,'arema','malang');
		
DELETE FROM klub

COMMIT;

ROLLBACK;
