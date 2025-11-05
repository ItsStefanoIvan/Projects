CREATE TABLE authors (
  id Int PRIMARY Key,
  name text not null,
  country text
);

CREATE TABLE books (
  id INT PRIMARY KEY,
  title TEXT NOT NULL,
  author_id INT NOT NULL,
  year INT CHECK (year >= 2000),
  status TEXT DEFAULT 'available' CHECK (status IN ('available', 'archived')),
  FOREIGN KEY (author_id) REFERENCES authors(id)
);

CREATE TABLE members (
  id int PRIMARY KEY,
  full_name text not NULL,
  email text UNIQUE,
  joined_at DATE DEFAULT (DATE('now'))
);

CREATE TABLE loans (
  id int PRIMARY key,
  book_id int NOt NULL,
  member_id int not NULL,
  loan_date DATE NOT NULL DEFAULT (DATE('now')),
  due_date DATE NOT NULL,
  return_date DATE,
  FOREIGN KEY (book_id) REFERENCES books(id),
  FOREIGN KEY (member_id) REFERENCES members(id)
);

CREATE TABLE categories (
  id INT PRIMARY KEy,
  name TEXT NOT NULL UNIQUE
);

CREATE TABLE book_categories (
  book_id INT NOT NULL,
  category_id INT NOT NULL,
  PRIMARY KEY (book_id, category_id),
  FOREIGN KEY (book_id) REFERENCES books(id),
  FOREIGN KEY (category_id) REFERENCES categories(id)
);

CREATE INDEX idx_books_author_id ON books(author_id);
CREATE INDEX idx_loans_member_id ON loans(member_id);
CREATE INDEX idx_loans_book_id ON loans(book_id);

INSERT INTO authors (id, name, country) VALUES
(1, 'Sarah J. Maas', 'USA'),
(2, 'Alex Michalides', 'Cyprus'),
(3, 'Colleen Hoover', 'USA'),
(4, 'H. D. Carlton', 'USA'),
(5, 'Somme Sketchers', 'Unknown');

INSERT INTO books (id, title, author_id, year, status) VALUES
(1, 'Throne of Glass', 1, 2012, 'available'),
(2, 'The Silent Patient', 2, 2019, 'available'),
(3, 'It Ends With Us', 3, 2016, 'available'),
(4, 'Haunting Adeline', 4, 2022, 'available'),
(5, 'Sinners Anonymous', 5, 2019, 'available');

INSERT INTO members (id, full_name, email) VALUES
(1, 'Anna Petrova', 'anna@example.com'),
(2, 'Ben Ivanov', 'ben@example.com'),
(3, 'Clara Dimitrova', 'clara@example.com');

INSERT INTO categories (id, name) VALUES
(1, 'Fantasy'),
(2, 'Thriller'),
(3, 'Romance'),
(4, 'Dark Romance');

INSERT INTO book_categories (book_id, category_id) VALUES
(1,1),
(2,2),
(3,3),
(4,4),
(5,4);  -- fixed (was 5,5)

INSERT INTO loans (book_id, member_id, due_date) VALUES (2, 2, DATE('now','+14 day'));
INSERT INTO loans (book_id, member_id, due_date, return_date) VALUES (3, 1, DATE('now','+7 day'), DATE('now','+5 day'));
INSERT INTO loans (book_id, member_id, due_date) VALUES (4, 3, DATE('now','-2 day'));

CREATE VIEW current_loans AS
SELECT
  l.id AS loan_id,
  b.title,
  m.full_name AS membr,
  l.loan_date,
  l.due_date
FROM loans l 
JOIN books b ON b.id = l.book_id
JOIN members m ON m.id = l.member_id
WHERE l.return_date IS NULL;

CREATE VIEW overdue_loans AS
SELECT 
  l.id AS loan_id,
  b.title,
  m.full_name AS member,
  l.loan_date,
  l.due_date,
  (julianday('now') - julianday(l.due_date)) AS days_overdue
FROM loans l
JOIN books b ON b.id = l.book_id
JOIN members m ON m.id = l.member_id
WHERE l.return_date IS NULL
  AND DATE('now') > l.due_date;

SELECT b.id, b.title, a.name AS author, b.year, b.status
FROM books b 
JOIN authors a ON a.id = b.author_id
ORDER BY b.year DESC;

SELECT c.name AS category, COUNT(*) AS total
FROM categories c 
JOIN book_categories bc ON bc.category_id = c.id
GROUP BY c.name
ORDER BY total DESC, c.name ASC;

SELECT AVG(year) AS avg_year, MIN(year) AS oldest, MAX(year) AS newest
FROM books;

SELECT * FROM current_loans;
SELECT * FROM overdue_loans;

SELECT b.title, a.name AS author, a.country
FROM books b 
JOIN authors a ON a.id = b.author_id
WHERE a.country = 'USA';
