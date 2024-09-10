-- Nama = Jevon Ivander Thomas
-- NIM  = H071231067
-- Praktikum 1

-- Soal 1
CREATE DATABASE library;
USE library;

CREATE TABLE authors(
	id INT PRIMARY KEY AUTO_INCREMENT,
	NAME VARCHAR(100) NOT NULL
);
CREATE TABLE books(
	id INT PRIMARY KEY AUTO_INCREMENT,
	isbn VARCHAR(13) NOT NULL,
	title VARCHAR(100) NOT NULL,
	author_id INT NOT NULL,
	FOREIGN KEY (author_id) REFERENCES authors(id)
);

-- -- SOAL 2
ALTER TABLE authors
ADD nationality VARCHAR(50) NOT NULL;

-- -- SOAL 3
ALTER TABLE books
MODIFY isbn VARCHAR(13) UNIQUE;

-- -- SOAL 4
SHOW TABLES;
DESCRIBE authors;
DESCRIBE books;

-- SOAL 5
-- Modifikasi tabel `books`
ALTER TABLE books
MODIFY title VARCHAR(150) NOT NULL,
ADD published_year YEAR NOT NULL,
ADD genre VARCHAR(50) NOT NULL,
ADD copies_available INT NOT NULL;

-- Membuat tabel `members`
CREATE TABLE members(
	id INT AUTO_INCREMENT PRIMARY KEY,
	first_name VARCHAR(50) NOT NULL,
	last_name VARCHAR(50) NOT NULL ,
	email VARCHAR(100) UNIQUE,
	phone_number CHAR(10),
	join_date DATE NOT NULL,
	membership_type VARCHAR(50) NOT NULL 
);
	
-- Membuat tabel `borrowings`
CREATE TABLE borrowings(
	id INT AUTO_INCREMENT PRIMARY KEY,
	member_id INT NOT NULL ,
	book_id INT NOT NULL ,
	borrow_date DATE NOT NULL ,
	return_date DATE,
	FOREIGN KEY (member_id) REFERENCES members(id),
	FOREIGN KEY (book_id) REFERENCES books(id)
);