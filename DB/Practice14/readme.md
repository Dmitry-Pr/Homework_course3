# Practice 14 по базам данных

## Работу выполнил

Мухин Дмитрий БПИ228


Для работы поднял образ mssql в докере и запросы писал в PyCharm (там же подключился к бд)

Чтобы тестировать уровни, запускал транзакции в разных сессиях (каждый sql файл соответствует сессии)

## Task1412
### 1. Какие уровни изоляции гарантируют неповторяющееся чтение и непоявление фантомных записей для всех случаев жизни? Создать таблицы и написать примеры.

#### Уровень SERIALIZABLE предотвращает как фантомные записи, так и неповторяющееся чтение.
#### Уровень REPEATABLE READ предотвращает только неповторяющееся чтение.
```sql
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
```
### Пример для уровня REPEATABLE READ
```sql
-- Первая транзакция (T1)
BEGIN TRANSACTION;
SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;

-- Первый запрос: чтение данных
SELECT *
FROM Products
WHERE Price > 150;
```
![image](https://github.com/user-attachments/assets/5c204e5f-9602-48f3-bfeb-cd5484541c20)

```sql
-- Вторая транзакция (T2)
-- Выполняется в отдельной сессии
BEGIN TRANSACTION;

UPDATE Products
SET Price = Price + 100;

COMMIT;
-- конец T2
```
```sql
-- Повторный запрос в T1
SELECT *
FROM Products
WHERE Price > 150;

-- Завершение T1
COMMIT;
```
![image](https://github.com/user-attachments/assets/11929c6a-389d-462f-91e1-1a6db4dc35ee)

### Пример для уровня SERIALIZABLE
```sql
BEGIN TRANSACTION;
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

-- Чтение данных
SELECT *
FROM Products
WHERE Price > 150;
```
![image](https://github.com/user-attachments/assets/4be7e966-374d-4eb5-bfb8-0056f86e164c)

```sql
-- Попытка другой транзакции вставить данные блокируется
BEGIN TRANSACTION;
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

INSERT INTO Products (ProductID, Name, Price)
VALUES (5, 'Product E', 250.00); -- Заблокировано
COMMIT;
```
```sql
SELECT *
FROM Products
WHERE Price > 150;
COMMIT;
```
![image](https://github.com/user-attachments/assets/7c01df37-0366-4f47-8752-7e8b1a3dec99)


### 2. Какой уровень изоляции гарантирует чтение всех неподтвержденных транзакциями вставок и обновлений. Привести пример

#### Уровень изоляции READ UNCOMMITTED
#### Гарантирует чтение неподтвержденных данных (грязное чтение)

```sql
-- Пример использования READ UNCOMMITTED
-- Обновление баланса в первой транзакции
BEGIN TRANSACTION;
UPDATE Products
SET Price = 500
WHERE Name = 'Product A';
```
```sql
-- Чтение в другой транзакции
BEGIN TRANSACTION;
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

-- Грязное чтение: видим изменения, хотя они не подтверждены
SELECT *
FROM Products
WHERE Name = 'Product A';

ROLLBACK; -- Откат изменений в первой транзакции
ROLLBACK; -- Завершение второй транзакции
```
![image](https://github.com/user-attachments/assets/e0fbf7fb-3fcc-46ac-9937-61c21a1f60ac)
