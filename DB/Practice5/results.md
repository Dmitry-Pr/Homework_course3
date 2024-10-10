# Practice 5 по базам данных

## Работу выполнил

Мухин Дмитрий БПИ228


Для работы поднял образ mssql в докере и запросы писал в PyCharm (там же подключился к бд)

### Task 1

Создаем бд и таблицу файлом `create_task1.sql`

Далее будут пункты Task 1 и результаты каждого пункта с комментариями.

#### -- 1. Удалить все записи из таблицы [dbo].Students

DELETE FROM Students;

![image](https://github.com/user-attachments/assets/3e56f803-c48b-43ba-af81-c8c640e3a5c6)

При попытке вывести всю таблицу ничего не выводится


#### -- 2. Удалить одну запись из таблицы [dbo].Students , где st_id = 2

DELETE FROM Students WHERE st_id = 2;

![image](https://github.com/user-attachments/assets/003ebbd5-c4f6-4418-9553-8f77e74e9fc0)

Отсутствует только запись с st_id = 2

#### -- 3. Удалить две записи из таблицы [dbo].Students где  st_id = 2 и st_id = 3

DELETE FROM Students WHERE st_id IN (2, 3);

DELETE FROM Students WHERE st_id = 2 OR st_id = 3;

![image](https://github.com/user-attachments/assets/bf31ebc2-98f5-43c9-8363-d703e8e9f5c6)

Для этих двух запросов результат одинаковый

#### -- 4. Обновить одно поле в таблице [dbo].Students вместо Ленский написать Онегин

UPDATE Students SET LastName = 'Онегин' WHERE LastName = 'Ленский';

![image](https://github.com/user-attachments/assets/ba72a586-818b-4f05-b7fd-82ca38dd53d5)

Теперь Ленский, а не Онегин

#### -- 5. Обновить два поля в таблице [dbo].Students вместо Владимир Ленский написать Евгений Онегин

UPDATE Students
SET FirstName = 'Евгений', LastName = 'Онегин'
WHERE LastName = 'Ленский' AND FirstName = 'Владимир';

![image](https://github.com/user-attachments/assets/04a1c155-11e3-4edc-8faf-e74cecb63183)

Обновились оба поля

#### -- 6. Выбрать из таблицы [dbo].Students запись, где фамилия Раскольников.

SELECT * FROM Students WHERE LastName = 'Раскольников';

![image](https://github.com/user-attachments/assets/b1b4496d-4466-46e0-873b-dca3777a8673)

Такая запись только одна

#### -- 7. Напишите скрипт создания таблицы test с тремя переменными типа int, char(20), varchar(50).Наименования переменных могут быть любыми.

CREATE TABLE test (
    id INT,
    name CHAR(20),
    description VARCHAR(50)
);

![image](https://github.com/user-attachments/assets/c2c83613-ea94-4408-b5af-bbd715c5664e)

Появилась таблица test

#### -- 8. Заполните таблицу test данными, хотя бы три записи.

INSERT INTO test (id, name, description) VALUES (1, 'Item1', 'Description1');

INSERT INTO test (id, name, description) VALUES (2, 'Item2', 'Description2');

INSERT INTO test (id, name, description) VALUES (3, 'Item3', 'Description3');


#### -- 9. Выберите инструкцией SELECT все поля(колонки) из таблицы test

SELECT * FROM test;

![image](https://github.com/user-attachments/assets/6ac2fd5f-36a0-4fee-8e04-eed99d5ef09e)

Появились три записи

#### -- 10. Для чего используется инструкция USE?

-- USE используется для переключения контекста на другую базу данных.
-- Пример: USE Task1;

#### -- 11. Выбрать из таблицы Employees базы данных TSQL2012 все поля для сотрудника
-- с фамилией Buck(Бак) и именем Sven(Свен).

USE TSQL2012

SELECT * FROM HR.Employees WHERE lastname = N'Бак' AND firstname = N'Свен';

![image](https://github.com/user-attachments/assets/750dafa4-14ba-43a9-bea8-d8f2a88f78c9)

Нашел одного такого сотрудника

#### -- 12. Выбрать из таблицы Employees базы данных TSQL2012 всех сотрудников

-- у которых empid больше или равен 3 и меньше или равен 7.

SELECT * FROM HR.Employees WHERE empid BETWEEN 3 AND 7;

SELECT * FROM HR.Employees WHERE empid >= 3 AND empid <= 7;

![image](https://github.com/user-attachments/assets/2bfca397-08c1-4bdf-bab6-c08824043290)

Для двух этих запросов резальтат одинаковый

#### -- 13. Выбрать из таблицы hr.employees сотрудников, у которых

--        empid <= 3 и(или) empid >= 6

SELECT * FROM HR.Employees WHERE empid <= 3 OR empid >= 6;

![image](https://github.com/user-attachments/assets/bbdd9f04-881d-427b-ab2a-6e40c22f5aaf)

Если строго по заданию, таких результатов не может существовать. Но если заменить и на или, то вот так получается

#### -- 14. Выбрать из таблицы Employees базы данных TSQL2012 всех сотрудников

-- у которых empid больше или равен 3 и меньше или равен 7 но не равен 5.

SELECT * FROM HR.Employees WHERE empid BETWEEN 3 AND 7 AND empid <> 5;

SELECT * FROM HR.Employees WHERE empid >= 3 AND empid <= 7 AND empid <> 5;

![image](https://github.com/user-attachments/assets/b8c92b2f-6103-4311-9f75-9fe4bb63884e)

Для этих двух зарпосов результат будет одинаковым

### Task 2

#### -- 1. Из базы данных TSQL 2012 из таблицы [Production].[Suppliers]

-- показать  все записи, где поле region равно NULL

SELECT * FROM Production.Suppliers WHERE region IS NULL;

![image](https://github.com/user-attachments/assets/7a6c604a-2198-485b-b0df-f8a9812be589)

Видно, что регион везде null

#### -- 2. Из базы данных TSQL 2012 из таблицы [Production].[Suppliers]

-- показать все записи где поле region не равно NULL

SELECT * FROM Production.Suppliers WHERE region IS NOT NULL;

![image](https://github.com/user-attachments/assets/6de741c9-495a-4c3a-8dc5-718154e62ccb)

Видно, что регион везде не null

#### -- 3. Найти все фамилии в таблице [HR].Employees базы данных TSQL 2012,

-- состоящие из четырех букв (Указание - любая буква это подчеркивание)

SELECT lastname FROM HR.Employees WHERE LEN(lastname) = 4;

SELECT lastname FROM HR.Employees WHERE lastname LIKE N'____';

![image](https://github.com/user-attachments/assets/aa3fc2b3-d42f-4ee8-a305-b07ab13603b7)

Эти два запроса дают одинаковый результат

#### -- 4. Найти все фамилии в таблице [HR].Employees базы данных TSQL 2012,

-- начинающиеся с Ca(Ка).

SELECT lastname FROM HR.Employees WHERE lastname LIKE N'Ка%';

![image](https://github.com/user-attachments/assets/49f56a9f-4d53-46ce-b7d0-e8113ba8b8ba)

Такая запись только одна 

#### -- 5. Найти все фамилии в таблице [HR].Employees базы данных TSQL 2012,

-- заканчивающиеся на ed(ед).

SELECT lastname FROM HR.Employees WHERE lastname LIKE N'%ед';

![image](https://github.com/user-attachments/assets/02947325-cf37-44ea-a845-581f2f502539)

Такая тоже только одна

#### -- 6. Найти все фамилии в таблице [HR].Employees базы данных TSQL 2012,

-- содержащие ele(еле).

SELECT lastname FROM HR.Employees WHERE lastname LIKE N'%еле%';

![image](https://github.com/user-attachments/assets/f97f745e-fa3e-4624-ac4c-06afd2272349)

Эта же фамилия подходит под условие

#### -- 7. Найти все фамилии в таблице [HR].Employees базы данных TSQL 2012,

-- которые не начинаются с букв ABCDE(АБВГД).

SELECT lastname FROM HR.Employees WHERE lastname NOT LIKE N'[АБВГД]%';

![image](https://github.com/user-attachments/assets/7fd807da-a502-4554-8ecd-2b64983a3dd4)

Используем NOT в сочетании с LIKE, где указываем на какую буквку должно начаться слово

#### -- 8

CREATE TABLE Task
(
  orderid int,
  price decimal(7,2)
)

INSERT INTO Task  (orderid, price) VALUES (1,1.5)

INSERT INTO Task  (orderid, price) VALUES (2,2.5)

INSERT INTO Task  (orderid, price) VALUES (3,20.5)

INSERT INTO Task  (orderid, price) VALUES (4,2.5)

INSERT INTO Task (orderid) VALUES (5);

#### -- 8.0 Выбрать из таблицы Task значения price так, чтобы они не повторялись

SELECT DISTINCT price FROM Task;

![image](https://github.com/user-attachments/assets/ab3eb641-78eb-46e6-bc7a-399b4aa5efd1)

Действительно все уникальные

#### -- 8.1 Получить сумму значений в таблице task для поля price

SELECT SUM(price) AS TotalPrice FROM Task;

![image](https://github.com/user-attachments/assets/7d40b10a-2dd2-49a2-8b9a-635392810899)

Получили сумму

#### -- 8.2 Получить среднее значение в таблице task для поля price

SELECT AVG(price) AS AveragePrice FROM Task;

![image](https://github.com/user-attachments/assets/2c853510-8833-41b2-b7c2-58e7714f6ef9)

Получили среднее

#### -- 8.3 Выбрать все значения из таблицы task и отсортировать их по полю price в порядке убывания

SELECT * FROM Task ORDER BY price DESC;

![image](https://github.com/user-attachments/assets/deebf707-d60c-442a-85ec-9334576555eb)

Действительно по убыванию

#### -- 9. Подсчитать максимальное значение в таблице Sales.OrderDetails

-- для выражения qty * unitprice *(1-discount) для orderid = 10250

SELECT MAX(qty * unitprice * (1 - discount)) AS MaxValue

FROM Sales.OrderDetails

WHERE orderid = 10250;

![image](https://github.com/user-attachments/assets/3babd786-40ad-45de-8ff9-de7fbc59aebb)

Получаем максимальное значение

#### -- 10. Для базы данных tsql2012 в таблице sales.orderdetails

-- посчитать сумму значений qty для orderid = 10248

SELECT SUM(qty) AS TotalQty FROM Sales.OrderDetails WHERE orderid = 10248;

![image](https://github.com/user-attachments/assets/d198160e-1b9d-4217-898c-f375bbaaacd0)

Вот сумма

#### -- 11. Для таблицы hr.employees определить всех работников, которые родились

-- в 1970 и 1973 годах

SELECT * FROM HR.Employees WHERE YEAR(birthdate) IN (1970, 1973);

SELECT * FROM HR.Employees WHERE YEAR(birthdate) = 1970 OR YEAR(birthdate) = 1973;

![image](https://github.com/user-attachments/assets/aea5cde9-7a6a-4ab4-8c05-5a70d750519e)

Эти два запроса дают одинаковый результат
