USE Task1;
SELECT * FROM Students;

-- 1. Удалить все записи из таблицы [dbo].Students
DELETE FROM Students;

-- 2. Удалить одну запись из таблицы [dbo].Students , где st_id = 2
DELETE FROM Students WHERE st_id = 2;

-- 3. Удалить две записи из таблицы [dbo].Students где  st_id = 2 и st_id = 3
DELETE FROM Students WHERE st_id IN (2, 3);
DELETE FROM Students WHERE st_id = 2 OR st_id = 3;

-- 4. Обновить одно поле в таблице [dbo].Students вместо Ленский написать Онегин
UPDATE Students SET LastName = 'Онегин' WHERE LastName = 'Ленский';

-- 5. Обновить два поля в таблице [dbo].Students вместо Владимир Ленский написать Евгений Онегин
UPDATE Students
SET FirstName = 'Евгений', LastName = 'Онегин'
WHERE LastName = 'Ленский' AND FirstName = 'Владимир';

-- 6. Выбрать из таблицы [dbo].Students запись, где фамилия Раскольников.
SELECT * FROM Students WHERE LastName = 'Раскольников';

-- 7. Напишите скрипт создания таблицы test с тремя переменными типа int, char(20), varchar(50).Наименования переменных могут быть любыми.

CREATE TABLE test (
    id INT,
    name CHAR(20),
    description VARCHAR(50)
);

-- 8. Заполните таблицу test данными, хотя бы три записи.
INSERT INTO test (id, name, description) VALUES (1, 'Item1', 'Description1');
INSERT INTO test (id, name, description) VALUES (2, 'Item2', 'Description2');
INSERT INTO test (id, name, description) VALUES (3, 'Item3', 'Description3');

-- 9. Выберите инструкцией SELECT все поля(колонки) из таблицы test
SELECT * FROM test;

-- 10. Для чего используется инструкция USE?
-- USE используется для переключения контекста на другую базу данных.
-- Пример: USE MyDatabase;

-- 11. Выбрать из таблицы Employees базы данных TSQL2012 все поля для сотрудника
-- с фамилией Buck(Бак) и именем Sven(Свен).
USE TSQL2012
SELECT * FROM HR.Employees WHERE lastname = N'Бак' AND firstname = N'Свен';

-- 12. Выбрать из таблицы Employees базы данных TSQL2012 всех сотрудников
-- у которых empid больше или равен 3 и меньше или равен 7.
SELECT * FROM HR.Employees WHERE empid BETWEEN 3 AND 7;
SELECT * FROM HR.Employees WHERE empid >= 3 AND empid <= 7;

-- 13. Выбрать из таблицы hr.employees сотрудников, у которых
--        empid <= 3 и empid >= 6
SELECT * FROM HR.Employees WHERE empid <= 3 OR empid >= 6;

-- 14. Выбрать из таблицы Employees базы данных TSQL2012 всех сотрудников
-- у которых empid больше или равен 3 и меньше или равен 7 но не равен 5.
SELECT * FROM HR.Employees WHERE empid BETWEEN 3 AND 7 AND empid <> 5;
SELECT * FROM HR.Employees WHERE empid >= 3 AND empid <= 7 AND empid <> 5;
