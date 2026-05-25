create database librarysystem;
use librarysystem;

create table authors (author_id int primary key,
                      name varchar(100),
                      bio text);
insert into authors values
(1, 'Naseef', 'Fiction writer'),
(2, 'Razin', 'Science writer'),
(3, 'Nihal', 'Autobiography writer');

create table genres (genre_id int primary key,
                     name varchar(50));
insert into genres values
(1, 'Fiction'),
(2, 'Science'),
(3, 'Autobiography');

create table members (member_id int primary key,
                      name varchar(100),
                      email varchar(100),
                      phone varchar(15));
insert into members values
(1, 'Shahin', 'shahin@gmail.com', '9876543210'),
(2, 'Rizwan', 'rizwan@gmail.com', '8765432109');

create table books (book_id int primary key,
                    title varchar(200),
                    author_id int,
                    genre_id int,
                    publication_date date,
                    isbn varchar(20),
					foreign key (author_id) references authors(author_id),
                    foreign key (genre_id) references genres(genre_id));
    insert into books values
(1, 'The Great Adventure', 1, 1, '2004-08-18', '1234567890'),
(2, 'Interstellar', 2, 2, '2022-12-18', '2345678901'),
(3, 'Goat Life', 3, 3, '2026-04-07', '3456789012');

    create table borrowings (borrowing_id int primary key,
                             book_id int,
                             member_id int,
                             issue_date date,
                             return_date date,
                             due_date date,
                             fine decimal(5,2),
                             foreign key (book_id) references books(book_id),
                             foreign key (member_id) references members(member_id));
insert into borrowings values
(1, 1, 1, '2026-01-01', '2026-01-10', '2026-01-15', 0.00),
(2, 2, 2, '2026-02-01', null, '2026-02-10', 5.00);

-- queries

-- Get all books by a author
select b.title, g.name as genre
from books b
join authors a on b.author_id = a.author_id
join genres g on b.genre_id = g.genre_id
where a.name = 'Naseef';

-- Find all books borrowed by a member
select b.title, m.name as borrowed_by, bo.issue_date
from borrowings bo
join books b on bo.book_id = b.book_id
join members m on bo.member_id = m.member_id
where m.name = 'Shahin';

-- members who borrowed a book
select m.name, bo.issue_date
from borrowings bo
join members m on bo.member_id = m.member_id
where bo.book_id = 1;

-- Add a new book
insert into books values
(4, 'New Book', 1, 1, '2026-03-01', '4567890123');

-- Update a member's phone number
update members
set phone = '9999999999'
where member_id = 1;

select * from members
where member_id = 1;

-- Find books by genre
select b.title, a.name as author
from books b
join genres g on b.genre_id = g.genre_id
join authors a on b.author_id = a.author_id
where g.name = 'Fiction';

-- Get total fine collected
select sum(fine) as total_fine
from borrowings;

-- Delete a book (if not borrowed)
delete from books
where book_id = 4 and book_id not in (select book_id from borrowings);

select * from books;
