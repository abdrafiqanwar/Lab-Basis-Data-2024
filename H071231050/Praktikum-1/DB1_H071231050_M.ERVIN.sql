#NO 1 ____

CREATE DATABASE library;

USE library;

CREATE TABLE authors(
	id INT PRIMARY KEY,
	`name` VARCHAR(100) NOT NULL  
);

CREATE TABLE books(
	id INT PRIMARY KEY,
    isbn CHAR(13),
    title VARCHAR(100) NOT NULL,
    author_id INT,
    FOREIGN KEY (author_id) REFERENCES authors(id)
);

ALTER TABLE authors
MODIFY id INT AUTO_INCREMENT;

ALTER TABLE books
MODIFY id INT AUTO_INCREMENT;

DROP TABLE books;

#NO 2 ____
ALTER TABLE authors
ADD nationality VARCHAR(50);

#NO 3 ____
ALTER TABLE books
MODIFY isbn CHAR(13) UNIQUE;

#NO 4 ____
DESCRIBE authors;
DESCRIBE books;

#NO 5 ____

CREATE TABLE borrowings (
	id INT PRIMARY KEY AUTO_INCREMENT,
    member_id INT NOT NULL,
    FOREIGN KEY(member_id) REFERENCES members(id),
    book_id INT NOT NULL,
    FOREIGN KEY(book_id) REFERENCES books(id),
    borrow_date DATE NOT NULL,
    return_date DATE
);

CREATE TABLE members (
	id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone_number CHAR(10),
    join_date DATE NOT NULL,
    membership_type VARCHAR(50) NOT NULL
);

#MENGUBAH DAN MENAMBAHKAN BEBERAPA KOLOM DI DUA TABLE SEBELUMNYA
ALTER TABLE books
ADD published_year YEAR NOT NULL,
ADD genre VARCHAR(50) NOT NULL,
ADD copies_available INT NOT NULL,
MODIFY isbn CHAR(10) NOT NULL,
MODIFY author_id INT NOT NULL;

ALTER TABLE authors
MODIFY nationality VARCHAR(50) NOT NULL;


#MENAMPILKAN TABLE
DESCRIBE authors;
DESCRIBE books; 
DESCRIBE borrowings;
DESCRIBE members;






