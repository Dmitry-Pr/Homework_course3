-- 1 Сделать копии таблиц Production.Categories и Production.Products из базы данных tsql2012
-- в dbo.Categories и dbo.Products тремя способами
-- a) При помощи инструкции SELECT INTO с подзапросом
-- b) При помощи инструкции SELECT INTO без подзапроса (просто из таблицы)
-- c) При помощи INSERT INTO в итоговую таблицу

-- a)
USE testdatabase;

IF object_id('Categories', 'u') IS NOT NULL
    DROP TABLE Categories

IF object_id('Products', 'u') IS NOT NULL
    DROP TABLE Products

SELECT *
INTO dbo.Categories
FROM (SELECT * FROM tsql2012.Production.Categories) AS SubQuery;

SELECT *
INTO dbo.Products
FROM (SELECT * FROM tsql2012.Production.Products) AS SubQuery;


-- b)
IF object_id('Categories', 'u') IS NOT NULL
    DROP TABLE Categories

IF object_id('Products', 'u') IS NOT NULL
    DROP TABLE Products

SELECT *
INTO dbo.Categories
FROM tsql2012.Production.Categories;

SELECT *
INTO dbo.Products
FROM tsql2012.Production.Products;


--c)
IF object_id('Categories', 'u') IS NOT NULL
    DROP TABLE Categories

IF object_id('Products', 'u') IS NOT NULL
    DROP TABLE Products

CREATE TABLE dbo.Categories
(
    CategoryID   INT,
    CategoryName NVARCHAR(50),
    Description  NVARCHAR(200)
);

CREATE TABLE dbo.Products
(
    ProductID    INT,
    ProductName  NVARCHAR(50),
    SupplierID   INT,
    CategoryID   INT,
    UnitPrice    DECIMAL(10, 2),
    Discontinued BIT
);

INSERT INTO dbo.Categories
SELECT *
FROM tsql2012.Production.Categories;

INSERT INTO dbo.Products
SELECT *
FROM tsql2012.Production.Products;

-- Для следующих четырех задач требуется создать таблицы orders orderdetails employees
-- копированием таблиц из базы данных tsql2012 tsql2012.sales.orders tsql2012.sales.orderdetails
-- и tsql2012.hr.employees

IF object_id('orders', 'u') IS NOT NULL
    DROP TABLE orders

IF object_id('orderdetails', 'u') IS NOT NULL
    DROP TABLE orderdetails

IF object_id('employees', 'u') IS NOT NULL
    DROP TABLE employees

-- Создание таблицы orders
SELECT *
INTO dbo.orders
FROM tsql2012.sales.orders;

-- Создание таблицы orderdetails
SELECT *
INTO dbo.orderdetails
FROM tsql2012.sales.orderdetails;

-- Создание таблицы employees
SELECT *
INTO dbo.employees
FROM tsql2012.hr.employees;


-- 2. Обновить цену unitprice в таблице orderdetails для работника по фамилии Пелед
-- Увеличить ее на 20% при помощи соединения(JOIN) с таблицами employees и orders

UPDATE od
SET od.unitprice = od.unitprice * 1.2
FROM dbo.orderdetails od
         JOIN dbo.orders o ON od.orderid = o.orderid
         JOIN dbo.employees e ON e.empid = o.empid
WHERE e.lastname = N'Пелед';


-- 3. Обновить цену unitprice в таблице orderdetails для работника по фамилии Пелед
-- Увеличить ее на 20% при помощи коррелированного подзапроса  с участием таблицм
-- employees и orders

UPDATE dbo.orderdetails
SET unitprice = unitprice * 1.2
WHERE orderid IN (SELECT o.orderid
                  FROM dbo.orders o
                  WHERE o.empid = (SELECT e.empid FROM dbo.employees e WHERE e.lastname = N'Пелед'));


-- 4. Удалить записи в таблице orderdetails для работника по фамилии Пелед
--    при помощи соединения(JOIN) с таблицами employees и orders
DELETE od
FROM dbo.orderdetails od
         JOIN dbo.orders o ON od.orderid = o.orderid
         JOIN dbo.employees e ON e.empid = o.empid
WHERE e.lastname = N'Пелед';

-- 5. Удалить записи в таблице orderdetails для работника по фамилии Пелед
--    при помощи коррелированного подзапроса и таблиц  employees и orders
DELETE
FROM dbo.orderdetails
WHERE orderid IN (SELECT o.orderid
                  FROM dbo.orders o
                  WHERE o.empid = (SELECT e.empid FROM dbo.employees e WHERE e.lastname = N'Пелед'));


-- 6. Создать таблицу test

-- Занести в нее несколько записей, некоторые долны быть одинаковыми кроме первичных
-- ключей. Удалить повторяющиеся записи.

IF object_id('test', 'u') IS NOT NULL
    DROP TABLE test

CREATE TABLE dbo.test
(
    ID        INT PRIMARY KEY,
    LastName  NVARCHAR(50),
    FirstName NVARCHAR(50)
);

INSERT INTO dbo.test (ID, LastName, FirstName)
VALUES (1, 'Иван', 'Иванов'),
       (2, 'Петр', 'Петров'),
       (3, 'Иван', 'Иванов'),
       (4, 'Сергей', 'Сергеев'),
       (5, 'Петр', 'Петров');

WITH CTE AS (SELECT *, ROW_NUMBER() OVER (PARTITION BY LastName, FirstName ORDER BY ID) AS RowNum
             FROM dbo.test)
DELETE
FROM dbo.test
WHERE ID IN (SELECT ID
             FROM CTE
             WHERE RowNum > 1);


-- 7. Создать таблицу test и testex следующим способом

IF object_id('test', 'u') IS NOT NULL
    DROP TABLE test

IF object_id('testex', 'u') IS NOT NULL
    DROP TABLE testex


CREATE TABLE test
(
    id        INT PRIMARY KEY,
    lastname  VARCHAR(30),
    firstname VARCHAR(30)
)

INSERT INTO test (id, lastname, firstname)
VALUES (1, 'Байден', 'Джо')
INSERT INTO test (id, lastname, firstname)
VALUES (2, 'Рейган', 'Рональд')
INSERT INTO test (id, lastname, firstname)
VALUES (3, 'Линкольн', 'Авраам')
INSERT INTO test (id, lastname, firstname)
VALUES (4, 'Брежнев', 'Леонид')
INSERT INTO test (id, lastname, firstname)
VALUES (5, 'Сталин', 'Иосиф')
INSERT INTO test (id, lastname, firstname)
VALUES (6, 'Байден', 'Джо')
INSERT INTO test (id, lastname, firstname)
VALUES (7, 'Рейган', 'Рональд')

-- Сделать таблицу testex одинаковой с таблицей test при помощи инструкции MERGE

CREATE TABLE dbo.testex
(
    ID        INT PRIMARY KEY,
    LastName  NVARCHAR(50),
    FirstName NVARCHAR(50)
);

MERGE dbo.testex AS Target
USING dbo.test AS Source
ON Target.ID = Source.ID
WHEN NOT MATCHED THEN
    INSERT (ID, LastName, FirstName)
    VALUES (Source.ID, Source.LastName, Source.FirstName);


-- 8. Объединить таблицы Categories и Products при помощи JOIN по полю
-- categoryid. Создать по данному запросу представление View с именем v1
-- и вывести все поля представления на экран
DROP VIEW IF EXISTS dbo.v1;

CREATE VIEW dbo.v1 AS
SELECT
    p.ProductID,
    p.ProductName,
    p.UnitPrice,
    c.CategoryName
FROM dbo.Products p
JOIN dbo.Categories c ON p.CategoryID = c.CategoryID;

SELECT * FROM dbo.v1;


--9. Определить для каждого работника суммарную стоимость заказа
-- unitprice*qty*(1-discount) за каждый год для таблиц orderdetails, orders, employees .
-- Вывести значения lastname, firstname, год заказа, суммарная стоимость.
-- Решить при помощи подзапроса с последующим соединением этого
-- подзапроса с таблицей employees и созданием из данного
-- подзапроса представления(view).
DROP VIEW IF EXISTS dbo.EmployeeOrderSummary;

CREATE VIEW dbo.EmployeeOrderSummary AS
SELECT
    e.LastName,
    e.FirstName,
    YEAR(o.orderdate) AS OrderYear,
    SUM(od.qty * od.unitprice * (1 - od.discount)) AS TotalOrderValue
FROM dbo.orderdetails od
JOIN dbo.orders o ON od.orderid = o.orderid
JOIN dbo.employees e ON o.empid = e.empid
GROUP BY e.LastName, e.FirstName, YEAR(o.orderdate);

SELECT * FROM dbo.EmployeeOrderSummary;
