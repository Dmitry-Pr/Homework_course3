# Practice 5 по базам данных

## Работу выполнил

Мухин Дмитрий БПИ228


Для работы поднял образ mssql в докере и запросы писал в PyCharm (там же подключился к бд)

### Task 1

Создаем бд и таблицу файлом `create_task1.sql`

Далее будут пункты Task 1 и результаты каждого пункта с комментариями.

-- 1. Удалить все записи из таблицы [dbo].Students

DELETE FROM Students;

![image](https://github.com/user-attachments/assets/3e56f803-c48b-43ba-af81-c8c640e3a5c6)

При попытке вывести всю таблицу ничего не выводится


-- 2. Удалить одну запись из таблицы [dbo].Students , где st_id = 2

DELETE FROM Students WHERE st_id = 2;

![image](https://github.com/user-attachments/assets/003ebbd5-c4f6-4418-9553-8f77e74e9fc0)

Отсутствует только запись с st_id = 2

-- 3. Удалить две записи из таблицы [dbo].Students где  st_id = 2 и st_id = 3

DELETE FROM Students WHERE st_id IN (2, 3);

DELETE FROM Students WHERE st_id = 2 OR st_id = 3;

![image](https://github.com/user-attachments/assets/bf31ebc2-98f5-43c9-8363-d703e8e9f5c6)

Для этих двух запросов результат одинаковый

-- 4. Обновить одно поле в таблице [dbo].Students вместо Ленский написать Онегин

UPDATE Students SET LastName = 'Онегин' WHERE LastName = 'Ленский';

![image](https://github.com/user-attachments/assets/ba72a586-818b-4f05-b7fd-82ca38dd53d5)

Теперь Ленский, а не Онегин

-- 5. Обновить два поля в таблице [dbo].Students вместо Владимир Ленский написать Евгений Онегин

UPDATE Students
SET FirstName = 'Евгений', LastName = 'Онегин'
WHERE LastName = 'Ленский' AND FirstName = 'Владимир';

![image](https://github.com/user-attachments/assets/04a1c155-11e3-4edc-8faf-e74cecb63183)

Обновились оба поля

-- 6. Выбрать из таблицы [dbo].Students запись, где фамилия Раскольников.

SELECT * FROM Students WHERE LastName = 'Раскольников';

![image](https://github.com/user-attachments/assets/b1b4496d-4466-46e0-873b-dca3777a8673)

Такая запись только одна

-- 7. Напишите скрипт создания таблицы test с тремя переменными типа int, char(20), varchar(50).Наименования переменных могут быть любыми.

CREATE TABLE test (
    id INT,
    name CHAR(20),
    description VARCHAR(50)
);

![image](https://github.com/user-attachments/assets/c2c83613-ea94-4408-b5af-bbd715c5664e)

Появилась таблица test

-- 8. Заполните таблицу test данными, хотя бы три записи.

INSERT INTO test (id, name, description) VALUES (1, 'Item1', 'Description1');

INSERT INTO test (id, name, description) VALUES (2, 'Item2', 'Description2');

INSERT INTO test (id, name, description) VALUES (3, 'Item3', 'Description3');


-- 9. Выберите инструкцией SELECT все поля(колонки) из таблицы test

SELECT * FROM test;

![image](https://github.com/user-attachments/assets/6ac2fd5f-36a0-4fee-8e04-eed99d5ef09e)

Появились три записи

-- 10. Для чего используется инструкция USE?

-- USE используется для переключения контекста на другую базу данных.
-- Пример: USE Task1;

-- 11. Выбрать из таблицы Employees базы данных TSQL2012 все поля для сотрудника
-- с фамилией Buck(Бак) и именем Sven(Свен).

USE TSQL2012

SELECT * FROM HR.Employees WHERE lastname = N'Бак' AND firstname = N'Свен';

![image](https://github.com/user-attachments/assets/750dafa4-14ba-43a9-bea8-d8f2a88f78c9)

Нашел одного такого сотрудника

-- 12. Выбрать из таблицы Employees базы данных TSQL2012 всех сотрудников

-- у которых empid больше или равен 3 и меньше или равен 7.

SELECT * FROM HR.Employees WHERE empid BETWEEN 3 AND 7;

-- 13. Выбрать из таблицы hr.employees сотрудников, у которых

--        empid <= 3 и empid >= 6

SELECT * FROM HR.Employees WHERE empid <= 3 OR empid >= 6;


-- 14. Выбрать из таблицы Employees базы данных TSQL2012 всех сотрудников

-- у которых empid больше или равен 3 и меньше или равен 7 но не равен 5.

SELECT * FROM HR.Employees WHERE empid BETWEEN 3 AND 7 AND empid <> 5;

