# Practice 6 по базам данных

## Работу выполнил

Мухин Дмитрий БПИ228


Для работы поднял образ mssql в докере и запросы писал в PyCharm (там же подключился к бд)

## Task_for_students

### -- 1. Для каждого сотрудника получить количество сделанных заказов на
--    каждую дату. Ожидается , что сотрудники делают по одному
--    заказу на каждую дату, но могут быть исключения
--    Вывести empid сотрудника , дату orderdate и количество заказов
--    на данную дату. Использовать таблицу sales.orders.

USE tsql2012
SELECT empid, orderdate, COUNT(orderid) AS order_count
FROM sales.orders
GROUP BY empid, orderdate
ORDER BY empid, orderdate;


### -- 2. Определить сотрудников, которые на одну дату оформили
--    два или более заказов. Вывести empid сотрудников
--    и соответствующие даты

SELECT empid, orderdate
FROM sales.orders
GROUP BY empid, orderdate
HAVING COUNT(orderid) >= 2
ORDER BY empid, orderdate;

### -- 3. Для каждого сотрудника получить количество сделанных заказов на
--    каждую дату. Ожидается , что сотрудники делают по одному
--    заказу на каждую дату, но могут быть исключения
--    Вывести empid сотрудника , lastname сотрудника , дату orderdate и количество заказов
--    на данную дату. Использовать таблицу hr.employees и sales.orders.

SELECT o.empid, e.lastname, o.orderdate, COUNT(o.orderid) AS order_count
FROM sales.orders AS o
JOIN hr.employees AS e ON o.empid = e.empid
GROUP BY o.empid, e.lastname, o.orderdate
ORDER BY o.empid, o.orderdate;


### -- 4. Определить сотрудников, которые на одну дату оформили
--    два или более заказов. Вывести empid сотрудников, lastname
--    и соответствующие даты

SELECT o.empid, e.lastname, o.orderdate
FROM sales.orders as o
JOIN hr.employees as e ON o.empid = e.empid
GROUP BY o.empid, e.lastname, o.orderdate
HAVING COUNT(o.orderid) >= 2
ORDER BY o.empid, o.orderdate

### -- 5. Решить задачи 1-4 при условии, что вместо сотрудника
--    мы имеем дело с заказчиком(клиентом таблица sales.cusomers)
#### -- Задание 1 для клиентов

SELECT custid, orderdate, COUNT(orderid) AS order_count
FROM sales.orders
GROUP BY custid, orderdate
ORDER BY custid, orderdate;

#### -- Задание 2 для клиентов

SELECT custid, orderdate
FROM sales.orders
GROUP BY custid, orderdate
HAVING COUNT(orderid) >= 2
ORDER BY custid, orderdate;

#### -- Задание 3 для клиентов

SELECT o.custid, c.contactname, o.orderdate, COUNT(o.orderid) AS order_count
FROM sales.orders AS o
JOIN sales.customers AS c ON o.custid = c.custid
GROUP BY o.custid, c.contactname, o.orderdate
ORDER BY o.custid, o.orderdate;

#### -- Задание 4 для клиентов

SELECT o.custid, c.contactname, o.orderdate
FROM sales.orders AS o
JOIN sales.customers AS c ON o.custid = c.custid
GROUP BY o.custid, c.contactname, o.orderdate
HAVING COUNT(o.orderid) >= 2
ORDER BY o.custid, o.orderdate;


### -- 6. Подсчитать среднее выражение для произведения qty * unitprice *(1-discount) в
--    таблице Sales.OrderDetails для сотрудника по фамилии Peled (Пелед) (база tsql2012)
--    Указание: Сделать JOIN таблицы Sales.Orders Sales.OrderDetails HR.Employees

SELECT AVG(od.qty * od.unitprice * (1 - od.discount)) AS avg_sales
FROM sales.orderdetails AS od
JOIN sales.orders AS o ON od.orderid = o.orderid
JOIN hr.employees AS e ON o.empid = e.empid
WHERE e.lastname = N'Пелед';

### -- 7. Найти максимальное значение выражения qty * unitprice *(1-discount)
--    в таблице Sales.OrderDetails для клиента у которого contactname = "Ray, Mike"(база tsql2012)
--    Указание: Сделать JOIN таблицы Sales.Orders Sales.OrderDetails Sales.Customers

SELECT MAX(od.qty * od.unitprice * (1 - od.discount)) AS max_sales
FROM sales.orderdetails AS od
JOIN sales.orders AS o ON od.orderid = o.orderid
JOIN sales.customers AS c ON o.custid = c.custid
WHERE c.contactname = 'Ray, Mike';

### -- 8. Определить по таблице sales.orders количество заказов ,
--    сделанных за каждый год при помощи группировки

SELECT YEAR(orderdate) AS order_year, COUNT(orderid) AS order_count FROM sales.Orders
GROUP BY YEAR(orderdate)
ORDER BY YEAR(orderdate)

### -- 9. Определить по таблице sales.orders количество заказов ,
--    сделанных за каждый день 2008 года при помощи группировки

SELECT orderdate, COUNT(orderid) AS order_count
FROM sales.orders
WHERE YEAR(orderdate) = 2008
GROUP BY orderdate
ORDER BY orderdate;

### -- 10. Определить количество клиентов для empid каждого сотрудника
-- из таблицы sales.orders

SELECT empid, COUNT(DISTINCT custid) AS client_count
FROM sales.orders
GROUP BY empid;

### -- Та же самая задача, но не повторять в учете одного и того же клиента

SELECT empid, COUNT(DISTINCT custid) AS unique_client_count
FROM sales.orders
GROUP BY empid;
    
### -- 11. Определить количество клиентов для каждого сотрудника
 -- для каждого года работы

SELECT empid, YEAR(orderdate) AS order_year, COUNT(DISTINCT custid) AS client_count
FROM sales.orders
GROUP BY empid, YEAR(orderdate)
ORDER BY empid, order_year;

### -- Та же самая задача, но не повторять в учете одного и того же клиента

SELECT empid, YEAR(orderdate) AS order_year, COUNT(DISTINCT custid) AS unique_client_count
FROM sales.orders
GROUP BY empid, YEAR(orderdate)
ORDER BY empid, order_year;
