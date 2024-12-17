-- Пример для уровня REPEATABLE READ
-- Вторая транзакция (T2)
-- Выполняется в отдельной сессии
BEGIN TRANSACTION;

UPDATE Products
SET Price = Price + 100;

-- Зафиксировать изменения
COMMIT;



-- Пример для уровня SERIALIZABLE
-- Попытка другой транзакции вставить данные блокируется
BEGIN TRANSACTION;
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

INSERT INTO Products (ProductID, Name, Price)
VALUES (5, 'Product E', 250.00); -- Заблокировано
COMMIT;


-- Пример использования READ UNCOMMITTED
BEGIN TRANSACTION;
UPDATE Products
SET Price = 500
WHERE Name = 'Product A';

-- Выполняем чтение в другой транзакции

-- Конец транзакции
ROLLBACK;