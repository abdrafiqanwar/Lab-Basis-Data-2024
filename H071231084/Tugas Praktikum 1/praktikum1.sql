-- Khalika Tsabitah Malik
-- H071231084

-- NO 1
CREATE DATABASE library;
USE library;

CREATE TABLE authors (
	id INT PRIMARY KEY AUTO_INCREMENT,
	name VARCHAR(100) NOT NULL
);

CREATE TABLE books (
	id INT PRIMARY KEY AUTO_INCREMENT,
	isbn VARCHAR(13),
	title VARCHAR(100) NOT NULL,
	author_id INT,
	FOREIGN KEY (author_id) REFERENCES authors(id)
);

-- NO 2
ALTER TABLE authors
ADD nationality VARCHAR(50);

-- NO 3
ALTER TABLE books
MODIFY isbn VARCHAR(13) UNIQUE;

-- NO 4
DESCRIBE authors;
DESCRIBE books;

-- NO 5
CREATE TABLE members(
	id INT PRIMARY KEY AUTO_INCREMENT,
	first_name VARCHAR(50) NOT NULL,
	last_name VARCHAR(50) NOT NULL,
	email VARCHAR(100) UNIQUE NOT NULL,
	phone_number CHAR(10),
	join_date DATE NOT NULL,
	membership_types VARCHAR(50) NOT NULL
);

CREATE TABLE borrowings(
	id INT PRIMARY KEY AUTO_INCREMENT,
	member_id INT,
	book_id INT,
	borrow_date DATE NOT NULL,
	return_date DATE,
	FOREIGN KEY(member_id) REFERENCES members(id),
	FOREIGN KEY(book_id) REFERENCES books(id)
);

ALTER TABLE books
ADD published_year YEAR NOT NULL,
ADD genre VARCHAR(50) NOT NULL,
ADD copies_value INT NOT NULL,
MODIFY title VARCHAR(150) NOT NULL;