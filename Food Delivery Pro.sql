CREATE TABLE restaurants (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    address VARCHAR(255),
    cuisine_category VARCHAR(50),
    rating NUMERIC(2,1) CHECK (rating >= 0 AND rating <= 5)
);

CREATE TABLE menu_items (
    id SERIAL PRIMARY KEY,
    restaurant_id INT REFERENCES restaurants(id) ON DELETE CASCADE,
    name VARCHAR(100) NOT NULL,
    price NUMERIC(8,2) CHECK (price >= 0),
    in_stock BOOLEAN DEFAULT TRUE
);

CREATE TABLE customers (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    phone VARCHAR(20),
    email VARCHAR(100)
);

CREATE TABLE orders (
    id SERIAL PRIMARY KEY,
    customer_id INT REFERENCES customers(id) ON DELETE CASCADE,
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status VARCHAR(20) CHECK (status IN ('Принят', 'Доставлен'))
);

CREATE TABLE order_items (
    order_id INT REFERENCES orders(id) ON DELETE CASCADE,
    menu_item_id INT REFERENCES menu_items(id) ON DELETE CASCADE,
    quantity INT CHECK (quantity > 0),
    PRIMARY KEY (order_id, menu_item_id)
);

INSERT INTO restaurants (name, address, cuisine_category, rating) VALUES
('Пицца-Хата', 'ул. Пиццы, д.1', 'Пицца', 4.5),
('Суши-Мания', 'пр. Суши, д.2', 'Суши', 4.8),
('Бургер-Шоп', 'ул. Бургеров, д.3', 'Бургер', 4.2),
('Taste of India', 'ул. Востока, д.4', 'Индийская', 4.6);


INSERT INTO menu_items (restaurant_id, name, price, in_stock) VALUES
(1, 'Маргарита', 500, TRUE),
(1, 'Пепперони', 700, TRUE),
(1, 'Четыре сыра', 650, TRUE);

INSERT INTO menu_items (restaurant_id, name, price, in_stock) VALUES
(2, 'Набор суши 1', 1200, TRUE),
(2, 'Набор суши 2', 1500, TRUE),
(2, 'Ролл калифорния', 800, TRUE);


INSERT INTO menu_items (restaurant_id, name, price, in_stock) VALUES
(3, 'Классический бургер', 400, TRUE),
(3, 'Биг мак', 600, TRUE),
(3, 'Чизбургер', 350, TRUE);


INSERT INTO menu_items (restaurant_id, name, price, in_stock) VALUES
(4, 'Курица Тика Масала', 900, TRUE),
(4, 'Дал', 550, TRUE),
(4, 'Наан', 300, TRUE);

INSERT INTO customers (name, phone, email) VALUES
('Иван Иванов', '89991234567', 'ivan@example.com'),
('Мария Смирнова', '89997654321', 'maria@example.com'),
('Петр Петров', '89998887766', 'petr@example.com'),
('Алина Кузнецова', '89995553322', 'alina@example.com'),
('Дмитрий Иванов', '89992221100', 'dmitry@example.com');


INSERT INTO orders (customer_id, order_date, status) VALUES
(1, '2024-04-01 12:15:00', 'Доставлен'),
(2, '2024-04-02 13:00:00', 'Принят'),
(3, '2024-04-03 14:30:00', 'Доставлен'),
(4, '2024-04-04 15:45:00', 'Доставлен'),
(1, '2024-04-05 18:20:00', 'Принят');


INSERT INTO order_items VALUES
(1, 1, 2), -- 2 пиццы "Маргарита"
(1, 4, 1); -- 1 набор суши

INSERT INTO order_items VALUES
(2, 2, 1), -- 1 пепперони
(2, 7, 2); -- 2 бургера

INSERT INTO order_items VALUES
(3, 9, 1), -- 1 индийское блюдо
(3, 8, 1); -- 1 ролл
(3, 10, 1); -- 1 Наан

INSERT INTO order_items VALUES
(4, 3, 1), -- 1 пицца "Четыре сыра"
(4, 6, 1); -- 1 ролл

INSERT INTO order_items VALUES
(5, 5, 2), -- 2 бургера
(5, 11, 1); --  1 ролл

SELECT c.name AS "Клиент", r.name AS "Ресторан", o.order_date AS "Дата"
FROM orders o
JOIN customers c ON o.customer_id = c.id
JOIN order_items oi ON o.id = oi.order_id
JOIN menu_items m ON oi.menu_item_id = m.id
JOIN restaurants r ON m.restaurant_id = r.id
GROUP BY o.id, c.name, r.name, o.order_date
ORDER BY o.order_date DESC;


SELECT m.name AS "Блюдо", oi.quantity, (m.price * oi.quantity) AS "Стоимость"
FROM order_items oi
JOIN menu_items m ON oi.menu_item_id = m.id
WHERE oi.order_id = 1;


SELECT c.name, COUNT(*) AS "Количество заказов"
FROM orders o
JOIN customers c ON o.customer_id = c.id
GROUP BY c.id, c.name
ORDER BY COUNT(*) DESC
LIMIT 1;

SELECT r.name AS "Ресторан", SUM(m.price * oi.quantity) AS "Общая выручка"
FROM restaurants r
JOIN menu_items m ON r.id = m.restaurant_id
JOIN order_items oi ON m.id = oi.menu_item_id
JOIN orders o ON oi.order_id = o.id
GROUP BY r.id, r.name;


SELECT r.name AS "Ресторан", AVG(m.price * oi.quantity) AS "Средний чек"
FROM restaurants r
JOIN menu_items m ON r.id = m.restaurant_id
JOIN order_items oi ON m.id = oi.menu_item_id
JOIN orders o ON oi.order_id = o.id
GROUP BY r.id, r.name
HAVING AVG(m.price * oi.quantity) > 500;

