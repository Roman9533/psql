CREATE TABLE books (
    id SERIAL PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    author_first_name VARCHAR(50),
    author_last_name VARCHAR(50),
    publication_year INTEGER,
    isbn VARCHAR(13) UNIQUE,
    pages INTEGER CHECK (pages > 0),
    is_borrowed BOOLEAN DEFAULT FALSE
);

INSERT INTO books (title, author_first_name, author_last_name, publication_year, isbn, pages) VALUES
('Кодекс программирования', 'Михаил', 'Иванов', 2010, '9781234567890', 350),
('История России', 'Алексей', 'Петров', 1995, '9789876543210', 600),
('Современная математика', 'Нина', 'Сидорова', 2020, '9781122334455', 420),
('Экология и человека', 'Елена', 'Кузнецова', 2005, '9789988776655', 300),
('Биография Гагарина', 'Игорь', 'Кузьмин', 1961, '9786677889900', 250),
('Основы программирования', 'Дмитрий', 'Левин', 2018, '9784455667788', 480),
('Практика маркетинга', 'Анна', 'Романова', 2015, '9785544332211', 330),
('Философия и культура', 'Сергей', 'Морозов', 2000, '9782233445566', 410);

SELECT CONCAT(author_first_name, ' ', author_last_name) AS full_author_name
FROM books;

SELECT *
FROM books
ORDER BY publication_year DESC
OFFSET 3 LIMIT 3;


WITH author_pages AS (
    SELECT author_first_name, author_last_name, SUM(pages) AS total_pages
    FROM books
    GROUP BY author_first_name, author_last_name
)
SELECT 
    a.author_first_name,
    a.author_last_name,
    MAX(b.pages) AS max_pages
FROM author_pages a
JOIN books b ON a.author_first_name = b.author_first_name
               AND a.author_last_name = b.author_last_name
WHERE a.total_pages > 1000
GROUP BY a.author_first_name, a.author_last_name;


UPDATE books
SET is_borrowed = TRUE
WHERE title = 'Чистый код';


SELECT *
FROM books
WHERE title LIKE '%Программирование%'
  AND publication_year > 2015;
