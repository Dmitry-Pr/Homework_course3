# Practice 9 по базам данных

## Работу выполнил

Мухин Дмитрий БПИ228


Для работы поднял образ mssql в докере и запросы писал в PyCharm (там же подключился к бд)

## Task09November

### -- 1. Определить количество клиентов с которыми оформлял заказ каждый сотрудник.
-- Использовать таблицы sales.orders и hr.Employees . Вывести фамилию , имя сотрудника и количество
-- клиентов. Решить задачу тремя способами
-- при помощи изолированного подзапроса, при помощи коррелированного подзапроса,
-- при помощи JOIN и группировки
```
-- Изолированный
USE tsql2012
SELECT
e.lastname,
e.firstname,
tmp.count AS ClientCount
FROM hr.Employees e JOIN
(SELECT empid, COUNT(o.custid) as count
FROM sales.orders o
GROUP BY empid) as tmp
ON tmp.empid = e.empid
ORDER BY e.lastname, e.firstname
```
```
-- Коррелированный
SELECT
e.lastname,
e.firstname,
(SELECT COUNT(o.custid)
FROM sales.orders o
WHERE o.empid = e.empid) AS ClientCount
FROM hr.Employees e
ORDER BY e.lastname, e.firstname
```
```
-- Join + Group By
SELECT
e.lastname,
e.firstname,
COUNT(o.custid) AS ClientCount
FROM hr.Employees e JOIN sales.orders o on o.empid = e.empid
GROUP BY e.lastname, e.firstname
ORDER BY e.lastname, e.firstname
```
![image](https://github.com/user-attachments/assets/541ac801-53a2-43ee-acdf-4588ca2e5ec5)

### -- 2. Та же самая задача, но не повторять в учете одного и того же клиента
```
-- Изолированный
USE tsql2012
SELECT
e.lastname,
e.firstname,
tmp.count AS ClientCount
FROM hr.Employees e JOIN
(SELECT empid, COUNT(DISTINCT o.custid) as count
FROM sales.orders o
GROUP BY empid) as tmp
ON tmp.empid = e.empid
ORDER BY e.lastname, e.firstname
```
```
-- Коррелированный
SELECT
e.lastname,
e.firstname,
(SELECT COUNT(DISTINCT o.custid)
FROM sales.orders o
WHERE o.empid = e.empid) AS ClientCount
FROM hr.Employees e
ORDER BY e.lastname, e.firstname
```
```
-- Join + Group By
SELECT
e.lastname,
e.firstname,
COUNT(DISTINCT o.custid) AS ClientCount
FROM hr.Employees e JOIN sales.orders o on o.empid = e.empid
GROUP BY e.lastname, e.firstname
ORDER BY e.lastname, e.firstname
```
![image](https://github.com/user-attachments/assets/c223e579-9e7a-45b2-ab6e-1f0c6c045725)

### -- 3. Определить количество клиентов для каждого сотрудника
 -- для каждого года работы. Вывести фамилию , имя сотрудника и количество
-- клиентов
```
SELECT
e.lastname,
e.firstname,
o.OrderYear,
(SELECT COUNT(ord.custid)
FROM sales.orders ord
WHERE ord.empid = e.empid
AND YEAR(ord.orderdate) = o.OrderYear) AS ClientCount
FROM hr.Employees e
JOIN (SELECT DISTINCT empid, YEAR(orderdate) AS OrderYear FROM sales.orders) o
ON e.empid = o.empid
ORDER BY e.lastname, e.firstname
```
![image](https://github.com/user-attachments/assets/0925899b-7b59-4450-95d8-2797636d95c6)

Не все влезло в скриншот

###  -- 4. Та же самая задача, но не повторять в учете одного и того же клиента
```
SELECT
e.lastname,
e.firstname,
o.OrderYear,
(SELECT COUNT(DISTINCT ord.custid)
FROM sales.orders ord
WHERE ord.empid = e.empid
AND YEAR(ord.orderdate) = o.OrderYear) AS ClientCount
FROM hr.Employees e
JOIN (SELECT DISTINCT empid, YEAR(orderdate) AS OrderYear FROM sales.orders) o
ON e.empid = o.empid
ORDER BY e.lastname, e.firstname
```
![image](https://github.com/user-attachments/assets/6cff87c4-9c91-4fbb-b0df-b8294068b62e)

Не все влезло в скриншот

### -- 5. Решить задачу на отсутствие определенных чисел в таблице
-- Создаем таблицу непрерывных чисел
```
CREATE TABLE MyNumbers
(
num INT
)

DECLARE @i INT = 1;
WHILE @i <= 100
BEGIN
INSERT INTO MyNumbers (num) VALUES (@i);
SET @i = @i + 1;
END;

SELECT mn.num
FROM MyNumbers mn
LEFT JOIN Production.Products p
ON mn.num = p.productid
WHERE p.productid IS NULL
```
![image](https://github.com/user-attachments/assets/43645020-ddeb-47b7-94de-36e382ad6510)


### -- 6. Определить сумму qty из таблицы sales.OrderDetails и фамилии работников
-- из таблицы hr.employees , у которых есть в фамилии буква 'и'
-- при помощи трех известных методов
```
-- Изолированный
SELECT
e.lastname,
totals.TotalQty
FROM hr.Employees e
JOIN (
SELECT o.empid, SUM(od.qty) AS TotalQty
FROM sales.Orders o
JOIN sales.OrderDetails od ON o.orderid = od.orderid
GROUP BY o.empid
) AS totals
ON e.empid = totals.empid
WHERE e.lastname LIKE N'%и%'
ORDER BY e.lastname
```
```
-- Коррелированный
SELECT
e.lastname,
(SELECT SUM(od.qty)
FROM sales.OrderDetails od
JOIN sales.Orders o ON o.orderid = od.orderid
WHERE o.empid = e.empid) AS TotalQty
FROM hr.Employees e
WHERE e.lastname LIKE N'%и%'
ORDER BY e.lastname
```
```
-- Join + Group By
SELECT
e.lastname,
SUM(od.qty) AS TotalQty
FROM hr.Employees e
JOIN sales.Orders o ON e.empid = o.empid
JOIN sales.OrderDetails od ON o.orderid = od.orderid
WHERE e.lastname LIKE N'%и%'
GROUP BY e.lastname
ORDER BY e.lastname
```

![image](https://github.com/user-attachments/assets/f7604558-3ec3-4752-8a3e-a14c724f18d9)

