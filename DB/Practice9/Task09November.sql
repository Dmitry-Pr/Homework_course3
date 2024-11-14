-- 1. Определить количество клиентов с которыми оформлял заказ каждый сотрудник.
-- Использовать таблицы sales.orders и hr.Employees . Вывести фамилию , имя сотрудника и количество
-- клиентов. Решить задачу тремя способами
-- при помощи изолированного подзапроса, при помощи коррелированного подзапроса,
-- при помощи JOIN и группировки

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

-- Коррелированный
SELECT
e.lastname,
e.firstname,
(SELECT COUNT(o.custid)
FROM sales.orders o
WHERE o.empid = e.empid) AS ClientCount
FROM hr.Employees e
ORDER BY e.lastname, e.firstname


-- Join + Group By
SELECT
e.lastname,
e.firstname,
COUNT(o.custid) AS ClientCount
FROM hr.Employees e JOIN sales.orders o on o.empid = e.empid
GROUP BY e.lastname, e.firstname
ORDER BY e.lastname, e.firstname


-- 2. Та же самая задача, но не повторять в учете одного и того же клиента

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

-- Коррелированный
SELECT
e.lastname,
e.firstname,
(SELECT COUNT(DISTINCT o.custid)
FROM sales.orders o
WHERE o.empid = e.empid) AS ClientCount
FROM hr.Employees e
ORDER BY e.lastname, e.firstname


-- Join + Group By
SELECT
e.lastname,
e.firstname,
COUNT(DISTINCT o.custid) AS ClientCount
FROM hr.Employees e JOIN sales.orders o on o.empid = e.empid
GROUP BY e.lastname, e.firstname
ORDER BY e.lastname, e.firstname

-- 3. Определить количество клиентов для каждого сотрудника
 -- для каждого года работы. Вывести фамилию , имя сотрудника и количество
-- клиентов

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

 -- 4. Та же самая задача, но не повторять в учете одного и того же клиента

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

-- 5. Решить задачу на отсутствие определенных чисел в таблице
-- Создаем таблицу непрерывных чисел

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



-- 6. Определить сумму qty из таблицы sales.OrderDetails и фамилии работников
-- из таблицы hr.employees , у которых есть в фамилии буква 'и'
-- при помощи трех известных методов

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





