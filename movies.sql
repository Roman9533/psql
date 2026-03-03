CREATE TABLE movies (
    id SERIAL PRIMARY KEY,
    title VARCHAR(150) NOT NULL,
    genre VARCHAR(50),
    duration_min INTEGER CHECK (duration_min > 0),
    ticket_price NUMERIC(10,2) DEFAULT 0.00,
    rating VARCHAR(10),
    is_3d BOOLEAN DEFAULT FALSE,
    release_date DATE
);


INSERT INTO movies (title, genre, duration_min, ticket_price, rating, is_3d, release_date) VALUES
('Интерстеллар', 'Фантастика', 169, 500.00, '12+', FALSE, '2014-11-06'),
('Мстители', 'Боевик', 142, 600.00, '12+', TRUE, '2012-05-04'),
('Малыш и Карлсон', 'Мультфильм', 75, 200.00, '0+', FALSE, '2018-12-20'),
('Человек-паук', 'Боевик', 130, 550.00, '12+', TRUE, '2017-07-07'),
('Ледниковый период', 'Мультфильм', 81, 250.00, '0+', FALSE, '2002-03-15'),
('Гравитация', 'Фантастика', 91, 450.00, '12+', FALSE, '2013-10-04');

UPDATE movies
SET ticket_price = ticket_price + 50
WHERE genre = 'Фантастика';


DELETE FROM movies WHERE id = 3;


UPDATE movies
SET rating = '16+'
WHERE title = 'Интерстеллар';


SELECT title, ticket_price
FROM movies
WHERE duration_min > 120;



SELECT * FROM movies
ORDER BY ticket_price ASC;


SELECT COUNT(*) AS total_films FROM movies;


SELECT AVG(ticket_price) AS average_price FROM movies;


SELECT genre, COUNT(*) AS count_by_genre
FROM movies
GROUP BY genre;

SELECT genre, AVG(ticket_price) AS avg_price
FROM movies
GROUP BY genre
HAVING AVG(ticket_price) > 350;