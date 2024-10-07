CREATE DATABASE universitas;
USE universitas;

CREATE TABLE  prodi(
	id INT PRIMARY KEY AUTO_INCREMENT,
	nama VARCHAR (100) NOT NULL 
);

CREATE TABLE mahasiswa(
	id INT PRIMARY KEY AUTO_INCREMENT ,
	nama VARCHAR (100) NOT NULL,
	nilai INT DEFAULT 0,
	id_prodi INT,
	FOREIGN KEY (id_prodi) REFERENCES prodi(id)
);

DESC mahasiswa;
DESC prodi;

INSERT INTO prodi(id, nama) VALUES (1, "sisfo");
INSERT INTO prodi(id, nama) VALUES (2, "ucup");

INSERT INTO mahasiswa (id, nama, nilai, id_prodi) VALUES (1, "andi", 100, 1);

SELECT * FROM prodi;
SELECT * FROM mahasiswa;

#insert tanpa menggunakan nama kolom
INSERT INTO mahasiswa
VALUES (2, "Aisar", 90, 1);

#insert kolom tertentu
INSERT INTO mahasiswa (id, nama)
VALUES (3, "abel");

#insert dgn nilai null
INSERT INTO mahasiswa (id, nama, nilai, id_prodi)
VALUES (4, "akbar", NULL, 1);
#blank
INSERT INTO mahasiswa (id, nama, nilai, id_prodi)
VALUES (5, "", NULL, 1);

INSERT INTO mahasiswa (id, nama, nilai, id_prodi)
VALUES (6, "ucok", 80, 2);

#insert dengan nilai banyak 
INSERT INTO mahasiswa (id, nama, nilai, id_prodi)
VALUES 
	(7, "ilham", 70, 2),
	(8, "adi", 60, 2),
	(9, "anca", 40, 2),
	(10, "ciki", 10, 2);
	
INSERT INTO mahasiswa (nama, nilai, id_prodi)
VALUES ("budi", 100, 2);

#update satu data 
UPDATE mahasiswa 
SET nama="nopal" 
WHERE id=3

#update lebih satu data
UPDATE mahasiswa
SET nilai=99
WHERE nilai=100

#update seluru data 
UPDATE mahasiswa 
SET nilai=200

#delete satu data
DELETE FROM mahasiswa 
WHERE id=3

#delete lebih satu data
DELETE FROM mahasiswa 
WHERE id_prodi=1

#delete semua
DELETE FROM mahasiswa;


#referential constrant action



CREATE DATABASE umi;
USE umi;

CREATE TABLE  prodi(
	id INT PRIMARY KEY AUTO_INCREMENT,
	nama VARCHAR (100) NOT NULL 
);

CREATE TABLE mahasiswa(
	id INT PRIMARY KEY AUTO_INCREMENT ,
	nama VARCHAR (100) NOT NULL,
	nilai INT DEFAULT 0,
	id_prodi INT,
	FOREIGN KEY (id_prodi) REFERENCES prodi(id)
);

INSERT INTO mahasiswa (id, nama, nilai, id_prodi)
VALUES 
	(1, "andi", 70, 2),
	(2, "budi", 60, 2),
	(3, "caca", 40, 2),
	(4, "denis", 10, 2),
	(5, "ervin", 10, 2);
	
INSERT INTO prodi(id, nama) VALUES (1, "sisfo");
	