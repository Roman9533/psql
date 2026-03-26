CREATE TABLE books (
    id SERIAL PRIMARY KEY,
    title VARCHAR(150) NOT NULL,
    price NUMERIC(10, 2)
);

CREATE TABLE categories (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) UNIQUE NOT NULL
);

CREATE TABLE book_categories (
    book_id INT REFERENCES books(id),
    category_id INT REFERENCES categories(id),
    added_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (book_id, category_id)
);

INSERT INTO categories (name) VALUES
('Фантастика'),
('Детектив'),
('Роман'),
('Психология'),
('Бизнес'),
('Программирование'),
('История'),
('Триллер'),
('Детское'),
('Классика');

INSERT INTO books (title, price) VALUES
('Властелин колец', 1200),
('Убийство в Восточном экспрессе', 800),
('Гарри Поттер', 1500),
('Как завести друзей и влиять на людей', 1100),
('7 навыков высокоэффективных людей', 1300),
('Война и мир', 2000),
('Детская энциклопедия', 1000),
('Программирование на Python', 1700),
('Стив Джобс. Биография', 1800),
('Тень ветра', 900);

-- Властелин колец: Фантастика, История, Классика
INSERT INTO book_categories VALUES (1, 1);
INSERT INTO book_categories VALUES (1, 7);
INSERT INTO book_categories VALUES (1, 10);

-- Убийство в Восточном экспрессе: Детектив, Триллер
INSERT INTO book_categories VALUES (2, 2);
INSERT INTO book_categories VALUES (2, 8);

-- Гарри Поттер: Фантастика, Детское
INSERT INTO book_categories VALUES (3, 1);
INSERT INTO book_categories VALUES (3, 9);

-- Как завести друзей и влиять на людей: Психология
INSERT INTO book_categories VALUES (4, 4);

-- 7 навыков высокоэффективных людей: Психология, Бизнес (пусть Бизнес будет пустым, его не добавляем)
INSERT INTO book_categories VALUES (5, 4);

-- Война и мир: Роман, История
INSERT INTO book_categories VALUES (6, 3);
INSERT INTO book_categories VALUES (6, 7);

-- Детская энциклопедия: Детское, История
INSERT INTO book_categories VALUES (7, 9);
INSERT INTO book_categories VALUES (7, 7);

-- Программирование на Python: Программирование, Бизнес (пусть Бизнес пустым - его не добавляем)
INSERT INTO book_categories VALUES (8, 6);

-- Стив Джобс. Биография: История
INSERT INTO book_categories VALUES (9, 7);

-- Тень ветра: Роман, Детектив, Классика
INSERT INTO book_categories VALUES (10, 3);
INSERT INTO book_categories VALUES (10, 2);
INSERT INTO book_categories VALUES (10, 10);

SELECT b.title AS "Название книги", c.name AS "Жанр"
FROM books b
JOIN book_categories bc ON b.id = bc.book_id
JOIN categories c ON c.id = bc.category_id
ORDER BY b.title, c.name;

SELECT b.title AS "Название книги", b.price AS "Цена"
FROM books b
JOIN book_categories bc ON b.id = bc.book_id
JOIN categories c ON c.id = bc.category_id
WHERE c.name = 'Программирование';

SELECT c.name AS "Название жанра", COUNT(bc.book_id) AS "Количество книг"
FROM categories c
LEFT JOIN book_categories bc ON c.id = bc.category_id
GROUP BY c.id, c.name
HAVING COUNT(bc.book_id) > 2;

SELECT c.name AS "Название жанра", ROUND(AVG(b.price), 2) AS "Средняя цена"
FROM categories c
JOIN book_categories bc ON c.id = bc.category_id
JOIN books b ON b.id = bc.book_id
GROUP BY c.id, c.name
ORDER BY AVG(b.price) DESC;

SELECT b.title AS "Название книги", COUNT(bc.category_id) AS "Количество категорий"
FROM books b
JOIN book_categories bc ON b.id = bc.book_id
GROUP BY b.id, b.title
HAVING COUNT(bc.category_id) > 2;