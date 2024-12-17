-- 1. Какие уровни изоляции гарантируют неповторяющееся чтение
-- и непоявление фантомных записей для всех случаев жизни?
-- Создать таблицы и написать примеры.

-- Уровень SERIALIZABLE предотвращает как фантомные записи, так и неповторяющееся чтение.
-- Уровень REPEATABLE READ предотвращает только неповторяющееся чтение.
IF OBJECT_ID('Products', 'U') IS NOT NULL
    DROP TABLE Products

CREATE TABLE Products
(
    ProductID INT PRIMARY KEY,
    Name      NVARCHAR(50)   NOT NULL,
    Price     DECIMAL(10, 2) NOT NULL
);

-- Вставка данных
INSERT INTO Products (ProductID, Name, Price)
VALUES (1, 'Product A', 100.00),
       (2, 'Product B', 200.00),
       (3, 'Product C', 300.00);

-- Пример для уровня REPEATABLE READ
-- Первая транзакция (T1)
BEGIN TRANSACTION;
SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;

-- Первый запрос: чтение данных
SELECT *
FROM Products
WHERE Price > 150;



-- Вторая транзакция (T2)
-- Выполняется в отдельной сессии
BEGIN TRANSACTION;

UPDATE Products
SET Price = Price + 100;

COMMIT;
-- конец T2


-- Повторный запрос в T1
SELECT *
FROM Products
WHERE Price > 150;

-- Завершение T1
COMMIT;


-- Пример для уровня SERIALIZABLE
BEGIN TRANSACTION;
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

-- Чтение данных
SELECT *
FROM Products
WHERE Price > 150;


-- Попытка другой транзакции вставить данные блокируется
BEGIN TRANSACTION;
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

INSERT INTO Products (ProductID, Name, Price)
VALUES (5, 'Product E', 250.00); -- Заблокировано
COMMIT;


SELECT *
FROM Products
WHERE Price > 150;

COMMIT;


-- 2. Какой уровень изоляции гарантирует чтение всех неподтвержденных
-- транзакциями вставок и обновлений.
-- Привести пример

-- Уровень изоляции READ UNCOMMITTED
-- Гарантирует чтение неподтвержденных данных (грязное чтение)


-- Пример использования READ UNCOMMITTED
-- Обновление баланса в первой транзакции
BEGIN TRANSACTION;
UPDATE Products
SET Price = 500
WHERE Name = 'Product A';

-- Чтение в другой транзакции
BEGIN TRANSACTION;
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

-- Грязное чтение: видим изменения, хотя они не подтверждены
SELECT *
FROM Products
WHERE Name = 'Product A';

ROLLBACK; -- Откат изменений в первой транзакции
ROLLBACK; -- Завершение второй транзакции
