use library;


#NOMOR 1 
insert into authors (name, nationality)
values ("Tera Liye", "Indonesia"),
("J.K Rowling", "British"),
("Andrea Hirata", NULL);

insert into books (isbn, title, author_id, published_year, genre, copies_available)
values ('7040289780375', "Ayah", 10, 2015, "Fiction", 15),
('9780375704025', "Bumi", 8, 2014, "Fantasy", 5),
('8310372703024', "Bulan", 8, 2015, "Fantasy", 3),
('9780747532688', "Harry Potter adn the Philosopher's Stone", 9, 1997, "", 10),
('7210301703022', "The Running Grave", 9, 2016 , "Fiction", 11);

insert into members (first_name, last_name, email, phone_number, join_date, membership_type)
values ("John", "Doe", "john.doe@example.com", NULL, '2023-04-29',""),
("Alice", "Johnson", "alice.johnson@example.com", 1231231231, "2023-05-01","Standar"),
("Bob", "Williams", "bob.williams@example.com", 3213214321, '2023-06-20',"Premium");

insert into borrowings (member_id, book_id, borrow_date, return_date)
values (1, 58, '2023-07-10', '2023-07-25'),
(3, 55, '2023-08-01', NULL),
(2, 59, '2023-09-06', '2023-07-25'),
(2, 57, '2023-09-08', NULL),
(3, 56, '2023-09-10', NULL);


#NOMOR 2 
select book_id from borrowings
where return_date IS NULL;

update books
set copies_available = copies_available-1
where id = 55 or 56 or 57;


#NOMOR 3 
select member_id from borrowings
where return_date IS NULL;

update members 
set membership_type = "Standar"
where id=3;

show create table borrowings;

ALTER TABLE borrowings DROP FOREIGN KEY borrowings_ibfk_1;
ALTER TABLE borrowings ADD FOREIGN KEY (member_id) REFERENCES members(id) ON DELETE CASCADE;

delete from members
where id=2;


# TAMPILKAN ISI TABLE 
select * from authors;
select * from books;
select * from members;
select * from borrowings;



