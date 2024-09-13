CREATE DATABASE library;

USE library;

CREATE TABLE authors(
	id INT AUTO_INCREMENT PRIMARY KEY,
	name VARCHAR(100) NOT NULL
)

CREATE TABLE books(
	id INT AUTO_INCREMENT PRIMARY KEY,
	ISBN VARCHAR(13),
	title VARCHAR(100) NOT NULL,
	author_id INT,
	FOREIGN KEY(author_id) REFERENCES authors(id)
)

ALTER TABLE authors
ADD nationality VARCHAR(50);

ALTER TABLE books
MODIFY ISBN VARCHAR(13) UNIQUE;

DESCRIBE authors;

DESCRIBE books;

SHOW TABLES;

CREATE TABLE members (
	id INT AUTO_INCREMENT PRIMARY KEY,
	first_name VARCHAR(50) NOT NULL,
	last_name VARCHAR(50) NOT NULL,
	email VARCHAR(100) UNIQUE NOT NULL,
	phone_number CHAR(10),
	join_date DATE NOT NULL,
	membership_type VARCHAR(50) NOT NULL 
)

ALTER TABLE books
MODIFY title VARCHAR(150) NOT NULL, 
MODIFY ISBN VARCHAR(13) UNIQUE,
MODIFY author_id INT NOT NULL,
ADD published_year YEAR NOT NULL,
ADD copies_available INT NOT NULL; 


CREATE TABLE borrowings (
	id INT PRIMARY KEY AUTO_INCREMENT, 
	member_id INT,
	book_id INT, 
	borrow_date DATE NOT NULL,
	return_date DATE,
	FOREIGN KEY(member_id) REFERENCES members(id),
	FOREIGN KEY(book_id) REFERENCES books(id),
)

DROP TABLE authors;

DESCRIBE authors;

DESCRIBE books;

DESCRIBE borrowings;

SHOW TABLES;