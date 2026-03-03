CREATE TABLE departments (
    id SERIAL PRIMARY KEY,
    dept_name VARCHAR(100) NOT NULL
);

CREATE TABLE specialties (
    id SERIAL PRIMARY KEY,
    spec_name VARCHAR(100) NOT NULL,
    dept_id INTEGER REFERENCES departments(id)
);

INSERT INTO departments (dept_name) VALUES
('Кафедра ИТ'),
('Кафедра Физики'),
('Кафедра Математики');


INSERT INTO specialties (spec_name, dept_id) VALUES
('Разработка ПО', 1),  -- привязка к кафедре ИТ
('Квантовая механика', 2),   -- привязка к кафедре Физики
('Теория чисел', NULL),-- без привязки к кафедре
('Вычислительная математика', 99);-- привязка к несуществующему ID


SELECT d.dept_name, s.spec_name
FROM specialties s
INNER JOIN departments d ON s.dept_id = d.id;


SELECT d.dept_name, s.spec_name
FROM departments d
LEFT JOIN specialties s ON s.dept_id = d.id;


SELECT s.spec_name, d.dept_name
FROM specialties s
RIGHT JOIN departments d ON s.dept_id = d.id;


SELECT d.dept_name, s.spec_name
FROM departments d
FULL OUTER JOIN specialties s ON s.dept_id = d.id;