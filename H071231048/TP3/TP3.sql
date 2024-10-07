USE library;
-- nomor 1
SELECT * FROM authors;
INSERT INTO authors (NAME, nationality) 
VALUES ('Tare Liye', 'indonesia'),
		('J.K Rowling', 'British'), 
		('Andrea Hirate',null);

ALTER TABLE authors
AUTO_INCREMENT=1
		
DESC authors
DESC books;
SELECT * FROM books;
INSERT INTO books (isbn, title, author_id, published_year, genre, copies_avaliable)
VALUES (7040289780375, 'Ayah', 3, 2015, 'fiction', 15),
		 (9780375704025, 'Bumi', 1, 2014, 'fantasy', 5),
		 (8310371703024, 'Bulan', 1, 2015, 'fantasy', 3),
		 (9780747532699, 'Harry Potter and the', 2, 1997, null, 10);
		 
INSERT INTO books (isbn, title, author_id, published_year, genre, copies_avaliable)
VALUES (7210301703022, 'The Running Grave', 2, 2016, 'fiction', 11);
		 
ALTER TABLE books
AUTO_INCREMENT=1

DESC members;
SELECT * FROM members;
INSERT INTO members (ferst_name, last_name, email, phone_number, join_date, membership_type)
VALUES ('John', 'Doe', 'John.doe@example.com', NULL, 2023-04-29, NULL ),
		 ('Alice', 'Johnson', 'alice.johnson@example.com', 1231231231, 2023-05-01, 'Standar'),
		 ('Bob', 'Williams', 'bob.williams@example.com', 3213214321, 2023-06-20, 'Premium');

ALTER TABLE members
AUTO_INCREMENT=1

DESC borrowings;
SELECT * FROM borrowings;
INSERT INTO borrowings (member_id, book_id, borrow_date, return_date)
VALUES (1, 4, '2023-07-10', '2023-07-25'),
		 (3, 1, '2023-08-01', NULL),
		 (2, 5, '2023-09-06', '2023-09-09'),
		 (2, 3, '2023-09-08', NULL),
		 (3, 2, '2023-09-10', NULL);

ALTER TABLE borrowings
AUTO_INCREMENT=1


-- nomor 2
select book_id from borrowings
where return_date IS NULL;


UPDATE books
SET copies_avaliable=copies_avaliable-1
WHERE id=1 OR 3 OR 2

SELECT * FROM books

-- nomor 3
select member_id from borrowings
where return_date IS NULL;

SELECT * FROM members
UPDATE members
SET membership_type = 'standar'
WHERE id=3;
 
DESC members

DELETE FROM members
WHERE id=2

SHOW CREATE TABLE borrowings
ALTER TABLE borrowings 
DROP CONSTRAINT borrowings_ibfk_1

ALTER TABLE borrowings 
ADD FOREIGN KEY (member_id) REFERENCES members(id) ON DELETE CASCADE 
		
