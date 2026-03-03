ALTER TABLE inventory ADD COLUMN price DECIMAL(10,2);

INSERT INTO inventory (item_name, quantity, category, is_available, price) VALUES
('Монитор Samsung', 10, 'Оргтехника', TRUE, 15000),
('Стол офисный', 5, 'Мебель', TRUE, 7000),
('Клейкая лента', 50, 'Канцтовары', TRUE, 100),
('Печать картридж', 8, 'Расходные материалы', TRUE, 2500),
('Монитор Dell', 3, 'Оргтехника', TRUE, 20000),
('Кресло офисное', 2, 'Мебель', FALSE, 12000),
('Блок бумаги A4', 100, 'Канцтовары', TRUE, 300),
('Картридж картридж HP', 4, 'Расходные материалы', TRUE, 3500);

SELECT item_name, quantity FROM inventory;

SELECT item_name, quantity FROM inventory WHERE quantity < 5;

SELECT item_name, category, price FROM inventory WHERE price BETWEEN 1000 AND 10000;

SELECT * FROM inventory WHERE category IN ('Мебель', 'Оргтехника');

SELECT * FROM inventory WHERE item_name ILIKE '%Монитор%';

SELECT * FROM inventory WHERE is_available = FALSE;

SELECT * FROM inventory ORDER BY price DESC LIMIT 3;

SELECT * FROM inventory ORDER BY category ASC, item_name ASC;