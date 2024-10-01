CREATE DATABASE library1;

USE library1;

CREATE TABLE authors (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    nationality VARCHAR(100)
);

CREATE TABLE books (
    id INT AUTO_INCREMENT PRIMARY KEY,
    isbn VARCHAR(20) UNIQUE NOT NULL,
    title VARCHAR(255) NOT NULL,
    author_id INT,
    published_year YEAR,
    genre VARCHAR(100),
    copies_available INT DEFAULT 0,
    FOREIGN KEY (author_id) REFERENCES authors(id)
);

CREATE TABLE members (
    id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    email VARCHAR(255),
    phone_number VARCHAR(15),
    join_date DATE,
    membership_type ENUM('Standar', 'Premium')
);

CREATE TABLE borrowings (
    id INT AUTO_INCREMENT PRIMARY KEY,
    member_id INT,
    book_id INT,
    borrow_date DATE,
    return_date DATE,
    FOREIGN KEY (member_id) REFERENCES members(id),
    FOREIGN KEY (book_id) REFERENCES books(id)
);
-- No.1: Insert ke tabel authors
INSERT INTO authors (name, nationality)
VALUES 
    ('Tere Liye', 'Indonesian'),
    ('J.K. Rowling', 'British'),
    ('Andrea Hirata', null);

INSERT INTO books (ISBN, title, author_id, published_year, copies_available, genre) 
VALUES 	('7040289780375', 'Ayah', 3, 2015, 15, 'Fiction'), 
			('9780375704025', 'Bumi',1, 2014,5, 'Fantasy'), 
			('8310371703024', 'Bulan', 1, 2015 , 3, 'Fantasy' ), 
			('9780747532699', "Harry Potter and the Philosopher's Stone", 2, 1997, 10, null),
			('7210301703022', 'The Running Grave', 2, 2016, 11, 'Finction');
			
SELECT * FROM books;
DELETE FROM books;

INSERT INTO members (first_name, last_name, email, phone_number, join_date, membership_type)
VALUES 	('John', 'Doe', 'John.doe@example.com', null, '2023-04-29', null), 
			('Alice', 'Johnson', 'alice.johnson@example.com', '123123231' ,'2023-05-01', 'Standar'),
			('Bob', 'Williams', 'bob.williams@example.com', '3213214321', '2023-06-20', 'Premium');

SELECT * FROM members;
DELETE FROM members;

INSERT INTO borrowings (member_id, book_id, borrow_date, return_date)
VALUES 	( 1, 4, '2023-07-10', '2023-07-25'), 
			(3, 1, '2023-08-01', NULL),
			(2, 5, '2023-09-08', '2023-09-09'),
			(2, 3,'2023-09-08', NULL), 
			(3, 2, '2023-09-10', NULL);
			
SELECT * FROM borrowings;
DELETE FROM borrowings;

-- No.2: Mengurangi jumlah buku yang tersedia pada tabel books

SELECT * FROM borrowings
WHERE return_date IS NULL;

UPDATE books 
SET copies_available = copies_Available-1
WHERE id = 1;

UPDATE books 
SET copies_available = copies_available-1
WHERE id = 2;

UPDATE books 
SET copies_available = copies_available-1
WHERE id = 3;

-- No.3: Mengubah membership_type Bob Williams menjadi 'Standar' dan hapus member dengan membership 'Standar'
UPDATE members
SET membership_type = 'Standar'
WHERE id = 3;

DELETE FROM members
WHERE id = 2;

SHOW CREATE TABLE borrowings
ALTER TABLE borrowings
DROP FOREIGN KEY borrowings_ibfk_1;

ALTER TABLE borrowings
ADD FOREIGN KEY (member_id) REFERENCES members(id) ON DELETE CASCADE





