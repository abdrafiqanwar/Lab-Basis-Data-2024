-- H071231048
-- Andi Aisar Saputra Dwi Anna

-- nomor1
CREATE TABLE produk(
	id INT PRIMARY KEY AUTO_INCREMENT,
	nama VARCHAR (100) NOT NULL,
	harga FLOAT (10),
	stok INT (5)
);

CREATE DATABASE ShopSmart;
USE ShopSmart;

INSERT INTO produk (nama, harga, stok)
VALUES ("Smartphone X" ,3000000,20);

INSERT INTO produk (nama, harga, stok)
VALUES 
	("Headphone Wireless", 500000,30),
	("Smart TV 42 Inch", 4500000,15),
	("Kamera DSLR",7000000,10),
	("Mesin Cuci", 2800000,20),
	("AC Split", 3500000,25);

UPDATE produk
SET harga = harga*0.9
WHERE stok > 20;



DELETE FROM produk;