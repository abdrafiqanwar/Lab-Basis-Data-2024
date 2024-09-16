create database library;

create table authors(
id int primary key AUTO_INCREMENT,
name varchar(100) NOT NULL
);

create table books(
id int primary key AUTO_INCREMENT,
isbn varchar(13),
title varchar(100) NOT NULL,
author_id int,
FOREIGN KEY (author_id) REFERENCES authors(id)
);


alter table authors
add column nationality varchar(50);

alter table books
ADD CONSTRAINT unique_isbn UNIQUE (isbn);

desc authors;
desc books;

select * from books;

SHOW TABLES;

CREATE TABLE members(
id INT PRIMARY KEY,
ferst_name VARCHAR(50),
last_name VARCHAR(50),
email VARCHAR(100) UNIQUE KEY,
phone_number CHAR(10),
join_date DATE,
membership_type VARCHAR(50)
);

DESC members;

CREATE TABLE borrowings(
   id INT PRIMARY KEY,
   member_id INT,
   book_id INT,
   borrow_date DATE,
   return_date DATE,
   FOREIGN KEY (member_id) REFERENCES members(id),
   FOREIGN KEY (book_id) REFERENCES books(id)
);


DESC borrowings;
