-- A.M.Yusran Mazidan
-- H071231064
CREATE DATABASE library;

USE library;

CREATE TABLE authors (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    nationality VARCHAR(50) NOT NULL
);

CREATE TABLE books (
    id INT AUTO_INCREMENT PRIMARY KEY,
    isbn VARCHAR(13) UNIQUE,
    title VARCHAR(100) NOT NULL,
    author_id INT,
    published_year YEAR NOT NULL,
	genre VARCHAR(50) NOT NULL,
	copies_available INT NOT NULL,
    FOREIGN KEY (author_id) REFERENCES authors(id) ON DELETE SET NULL
);

CREATE TABLE members (
    id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    phone_number CHAR(10),
    join_date DATE NOT NULL,
    membership_type VARCHAR(50) NOT NULL
);

CREATE TABLE borrowings (
    id INT AUTO_INCREMENT PRIMARY KEY,
    member_id INT NOT NULL,
    book_id INT NOT NULL,
    borrow_date DATE NOT NULL,
    return_date DATE,
    FOREIGN KEY (member_id) REFERENCES members(id) ON DELETE CASCADE,
    FOREIGN KEY (book_id) REFERENCES books(id) ON DELETE CASCADE
);

INSERT INTO authors (name, nationality) VALUES('Tere Liye', 'Indonesian'), ('J.K.Rowling', 'British'), ('Andrea Hirata', '');

INSERT INTO books (isbn, title, author_id, published_year, genre, copies_available) 
VALUES 
('7040289780375', 'Ayah', 3, 2015, 'Fiction', 15),
('9780375704025', 'Bumi', 1, 2014, 'Fantasy', 5),
('9780375704024', 'Bulan', 1, 2015, 'Fantasy', 3),
('9780375704099', 'Harry Potter', 2, 1997, '', 10),
('9780375704022', 'The Running Grave', 2, 2016, 'Fiction', 11);

INSERT INTO members (first_name, last_name, email, phone_number, join_date, membership_type) 
VALUES
('John', 'Doe', 'john.doe@example.com', NULL, '2023-04-29', ''),
('Alice', 'Johnson', 'alice.johnson@example.com', 1231231231, '2023-05-01', 'Standar'),
('Bob', 'Williams', 'bob.williams@example.com', 321321321, '2023-06-20', 'Premium');

INSERT INTO borrowings (member_id, book_id, borrow_date, return_date) 
VALUES 
(1, 4, '2023-07-10', '2023-07-25'),
(3, 1, '2023-07-10', NULL),
(2, 5, '2023-09-06', '2023-09-09'),
(2, 3, '2023-09-08', NULL),
(3, 2, '2023-09-10', NULL);

SELECT CONCAT(first_name ,' ', last_name) AS full_name, email, phone_number, join_date, membership_type FROM members;

SELECT CONCAT(m.first_name, ' ', m.last_name) AS member_name, bk.title AS book_title, b.borrow_date, b.return_date
FROM borrowings b, members m, books bk
WHERE b.member_id = m.id
AND b.book_id = bk.id;

													SELECT * FROM books;
                                                    SELECT * FROM borrowings;
                                                    SELECT * FROM members;

SELECT book_id FROM borrowings WHERE return_date IS NULL;

UPDATE books 
SET copies_available = copies_available - 1
WHERE id = 1 OR 2 OR 3;
-- IN (SELECT book_id FROM borrowings WHERE return_date IS NULL);

SELECT member_id FROM borrowings WHERE return_date IS NULL;

UPDATE members 
SET membership_type = 'Standar'
WHERE id = 3;
-- AND membership_type = 'Premium';

SHOW CREATE TABLE borrowings;

ALTER TABLE borrowings
DROP CONSTRAINT borrowings_ibfk_1;

ALTER TABLE borrowings
ADD FOREIGN KEY (member_id) REFERENCES members(id) ON DELETE CASCADE;

DELETE FROM members
WHERE id = 2;