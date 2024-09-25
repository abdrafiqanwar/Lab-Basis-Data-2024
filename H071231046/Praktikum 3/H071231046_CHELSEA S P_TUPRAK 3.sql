USE library;

SELECT * from authors;
SELECT * FROM books;
SELECT * FROM members;
SELECT * FROM borrowings;

INSERT INTO authors (NAME, nationality)
VALUES ('Tere Liye', 'Indonesian'), ('J. K Rowling', 'British'), ('Andrea Hirata','');

INSERT INTO books (ISBN, title, author_id, published_year, copies_available, genre) 
VALUES ('7040289780375', 'Ayah', 3, 2015, 15, 'Fiction'), 
('9780375704025', 'Bumi',1, 2014,5, 'Fantasy'), 
('8310371703024', 'Bulan', 1, 2015 , 3, 'Fantasy' ), 
('9780747532699', "Harry Potter and the Philosopher's Stone", 2, 1997, 10, ''),
('7210301703022', 'The Running Grave', 2, 2016, 11, 'Finction');

INSERT INTO members (first_name, last_name, email, phone_number, join_date, membership_type)
VALUES ('John', 'Doe', 'John.doe@example.com', null, '2023-04-29', null), 
('Alice', 'Johnson', 'alice.johnson@example.com', '123123231' ,'2023-05-01', 'Standar'),
('Bob', 'Williams', 'bob.williams@example.com', '3213214321', '2023-06-20', 'Premium');


INSERT INTO borrowings (member_id, book_id, borrow_date, return_date)
VALUES  ( 1, 4, '2023-07-10', '2023-07-25'), 
(3, 1, '2023-08-01', NULL), 
(2, 5, '2023-09-08', '2023-09-09'),
(2, 3,'2023-09-08', NULL), 
(3, 2, '2023-09-10', NULL);

#Buku yang hilang
SELECT * FROM borrowings WHERE return_date is NULL;
UPDATE books 
SET copies_available = copies_available - 1
WHERE id = 1 or id = 2 or id = 3;

#Member menghilangkan buku 
SELECT * FROM members WHERE id = 2 OR id =3;
UPDATE members
SET membership_type = 'Standar'
WHERE id = 3;

DELETE FROM members
WHERE id = 2;

#MENURUNKAN MEMBERSHIP TYPE
SHOW CREATE TABLE borrowings;

ALTER TABLE borrowings
DROP FOREIGN KEY borrowings_ibfk_1;

ALTER TABLE borrowings
ADD FOREIGN KEY(member_id) REFERENCES members(id) ON DELETE CASCADE;