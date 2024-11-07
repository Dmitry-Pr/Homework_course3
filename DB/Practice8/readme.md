# Practice 8 по базам данных

## Работу выполнил

Мухин Дмитрий БПИ228


Для работы поднял образ mssql в докере и запросы писал в PyCharm (там же подключился к бд)

## Task_for_students

### -- 1. Для каждого сотрудника получить количество сделанных заказов на
--    каждую дату. Ожидается , что сотрудники делают по одному
--    заказу на каждую дату, но могут быть исключения
--    Вывести empid сотрудника , дату orderdate и количество заказов
--    на данную дату. Использовать таблицу sales.orders.
```
USE tsql2012
SELECT empid, orderdate, COUNT(orderid) AS order_count
FROM sales.orders
GROUP BY empid, orderdate
ORDER BY empid, orderdate;
```

![image](https://github.com/user-attachments/assets/36e54c9b-d8b6-422c-b196-d56ac2d012ee)


### -- 2. Определить сотрудников, которые на одну дату оформили
--    два или более заказов. Вывести empid сотрудников
--    и соответствующие даты
```
SELECT empid, orderdate
FROM sales.orders
GROUP BY empid, orderdate
HAVING COUNT(orderid) >= 2
ORDER BY empid, orderdate;
```

![image](https://github.com/user-attachments/assets/38ae8fba-bd7b-41eb-8c98-3c696e45367f)

Having позволяет проверить условие после Group By

### -- 3. Для каждого сотрудника получить количество сделанных заказов на
--    каждую дату. Ожидается , что сотрудники делают по одному
--    заказу на каждую дату, но могут быть исключения
--    Вывести empid сотрудника , lastname сотрудника , дату orderdate и количество заказов
--    на данную дату. Использовать таблицу hr.employees и sales.orders.
```
SELECT o.empid, e.lastname, o.orderdate, COUNT(o.orderid) AS order_count
FROM sales.orders AS o
JOIN hr.employees AS e ON o.empid = e.empid
GROUP BY o.empid, e.lastname, o.orderdate
ORDER BY o.empid, o.orderdate;
```

![image](https://github.com/user-attachments/assets/48f52063-1340-457c-aaca-b3aebcdca41b)


### -- 4. Определить сотрудников, которые на одну дату оформили
--    два или более заказов. Вывести empid сотрудников, lastname
--    и соответствующие даты
```
SELECT o.empid, e.lastname, o.orderdate
FROM sales.orders as o
JOIN hr.employees as e ON o.empid = e.empid
GROUP BY o.empid, e.lastname, o.orderdate
HAVING COUNT(o.orderid) >= 2
ORDER BY o.empid, o.orderdate
```

![image](https://github.com/user-attachments/assets/bca7307c-473e-4ec0-9b37-c85ce65c539f)


### -- 5. Решить задачи 1-4 при условии, что вместо сотрудника
--    мы имеем дело с заказчиком(клиентом таблица sales.cusomers)
#### -- Задание 1 для клиентов
```
SELECT custid, orderdate, COUNT(orderid) AS order_count
FROM sales.orders
GROUP BY custid, orderdate
ORDER BY custid, orderdate;
```

![image](https://github.com/user-attachments/assets/bd17e706-13a1-45f4-ad8d-bfb9d157dc4c)

#### -- Задание 2 для клиентов
```
SELECT custid, orderdate
FROM sales.orders
GROUP BY custid, orderdate
HAVING COUNT(orderid) >= 2
ORDER BY custid, orderdate;
```

![image](https://github.com/user-attachments/assets/abf1b0f5-673e-43e5-a558-26741d4812bd)

#### -- Задание 3 для клиентов
```
SELECT o.custid, c.contactname, o.orderdate, COUNT(o.orderid) AS order_count
FROM sales.orders AS o
JOIN sales.customers AS c ON o.custid = c.custid
GROUP BY o.custid, c.contactname, o.orderdate
ORDER BY o.custid, o.orderdate;
```

![image](https://github.com/user-attachments/assets/27a8be6d-a28f-4a19-a885-ce7bddcf30be)

#### -- Задание 4 для клиентов
```
SELECT o.custid, c.contactname, o.orderdate
FROM sales.orders AS o
JOIN sales.customers AS c ON o.custid = c.custid
GROUP BY o.custid, c.contactname, o.orderdate
HAVING COUNT(o.orderid) >= 2
ORDER BY o.custid, o.orderdate;
```

![image](https://github.com/user-attachments/assets/022af40e-5517-499a-a1be-f620974fb0c6)

### -- 6. Подсчитать среднее выражение для произведения qty * unitprice *(1-discount) в
--    таблице Sales.OrderDetails для сотрудника по фамилии Peled (Пелед) (база tsql2012)
--    Указание: Сделать JOIN таблицы Sales.Orders Sales.OrderDetails HR.Employees
```
SELECT AVG(od.qty * od.unitprice * (1 - od.discount)) AS avg_sales
FROM sales.orderdetails AS od
JOIN sales.orders AS o ON od.orderid = o.orderid
JOIN hr.employees AS e ON o.empid = e.empid
WHERE e.lastname = N'Пелед';
```

![image](https://github.com/user-attachments/assets/e26887eb-3e90-49be-875e-504d10dc15e3)

### -- 7. Найти максимальное значение выражения qty * unitprice *(1-discount)
--    в таблице Sales.OrderDetails для клиента у которого contactname = "Ray, Mike"(база tsql2012)
--    Указание: Сделать JOIN таблицы Sales.Orders Sales.OrderDetails Sales.Customers
```
SELECT MAX(od.qty * od.unitprice * (1 - od.discount)) AS max_sales
FROM sales.orderdetails AS od
JOIN sales.orders AS o ON od.orderid = o.orderid
JOIN sales.customers AS c ON o.custid = c.custid
WHERE c.contactname = 'Ray, Mike';
```

![image](https://github.com/user-attachments/assets/e2b6ab0d-572e-457a-b411-bb528187897a)


### -- 8. Определить по таблице sales.orders количество заказов ,
--    сделанных за каждый год при помощи группировки
```
SELECT YEAR(orderdate) AS order_year, COUNT(orderid) AS order_count FROM sales.Orders
GROUP BY YEAR(orderdate)
ORDER BY YEAR(orderdate)
```

![image](https://github.com/user-attachments/assets/36c3c602-ea9a-43f2-b7c4-17fb5db29924)


### -- 9. Определить по таблице sales.orders количество заказов ,
--    сделанных за каждый день 2008 года при помощи группировки
```
SELECT orderdate, COUNT(orderid) AS order_count
FROM sales.orders
WHERE YEAR(orderdate) = 2008
GROUP BY orderdate
ORDER BY orderdate;
```

![image](https://github.com/user-attachments/assets/84ea71f7-a30b-408c-8a43-dab1d62162a2)

### -- 10. Определить количество клиентов для empid каждого сотрудника
-- из таблицы sales.orders
```
SELECT empid, COUNT(DISTINCT custid) AS client_count
FROM sales.orders
GROUP BY empid;
```

![image](https://github.com/user-attachments/assets/ec2ef27f-09f4-4af3-a708-500511ce908d)

### -- Та же самая задача, но не повторять в учете одного и того же клиента
```
SELECT empid, COUNT(DISTINCT custid) AS unique_client_count
FROM sales.orders
GROUP BY empid;
 ```

![image](https://github.com/user-attachments/assets/bc3a5d87-6eb3-419c-b9a2-51575df58c56)


### -- 11. Определить количество клиентов для каждого сотрудника
 -- для каждого года работы
```
SELECT empid, YEAR(orderdate) AS order_year, COUNT(DISTINCT custid) AS client_count
FROM sales.orders
GROUP BY empid, YEAR(orderdate)
ORDER BY empid, order_year;
```

![image](https://github.com/user-attachments/assets/dc8fc0bc-9024-4259-aa38-2324f310d687)


### -- Та же самая задача, но не повторять в учете одного и того же клиента
```
SELECT empid, YEAR(orderdate) AS order_year, COUNT(DISTINCT custid) AS unique_client_count
FROM sales.orders
GROUP BY empid, YEAR(orderdate)
ORDER BY empid, order_year;
```

![image](https://github.com/user-attachments/assets/326597af-f88c-468e-905f-c9d763aa6661)

## Task_group
```
USE testdatabase

IF object_id('dbo.Firms','U') IS NOT NULL
DROP TABLE dbo.Firms

CREATE TABLE [dbo].Firms
(
  FirmId int,
  FirmName NVARCHAR(40)
)

INSERT INTO Firms (FirmId, FirmName) VALUES (1,'Рога и копыта')
INSERT INTO Firms (FirmId, FirmName) VALUES (2,'Црулна Ибрагим Оглы')
INSERT INTO Firms (FirmId, FirmName) VALUES (3,'No kiya')

IF object_id('dbo.FirmValues','U') IS NOT NULL
DROP TABLE dbo.FirmValues

CREATE TABLE [dbo].[FirmValues]
(
    [Id] [bigint]  NOT NULL,
    [FirmId] [int] NOT NULL,
    [ProductId] [bigint] NOT NULL,
    [Value] [numeric](18, 2) NOT NULL
    PRIMARY KEY (Id)
)


INSERT INTO FirmValues (Id,FirmId,ProductId,[Value]) VALUES (1,1,1,2.00)
INSERT INTO FirmValues (Id,FirmId,ProductId,[Value]) VALUES (2,1,1,3.00)
INSERT INTO FirmValues (Id,FirmId,ProductId,[Value]) VALUES (3,1,2,3.50)
INSERT INTO FirmValues (Id,FirmId,ProductId,[Value]) VALUES (4,1,2,3.80)
INSERT INTO FirmValues (Id,FirmId,ProductId,[Value]) VALUES (5,1,2,10.70)
INSERT INTO FirmValues (Id,FirmId,ProductId,[Value]) VALUES (6,2,1,5.80)
INSERT INTO FirmValues (Id,FirmId,ProductId,[Value]) VALUES (7,2,1,7.70)
INSERT INTO FirmValues (Id,FirmId,ProductId,[Value]) VALUES (8,2,1,9.00)
INSERT INTO FirmValues (Id,FirmId,ProductId,[Value]) VALUES (9,2,2,7.80)
INSERT INTO FirmValues (Id,FirmId,ProductId,[Value]) VALUES (10,2,2,9.60)
INSERT INTO FirmValues (Id,FirmId,ProductId,[Value]) VALUES (11,3,1,1.10)
INSERT INTO FirmValues (Id,FirmId,ProductId,[Value]) VALUES (12,3,1,2.30)
INSERT INTO FirmValues (Id,FirmId,ProductId,[Value]) VALUES (13,3,2,1.40)
INSERT INTO FirmValues (Id,FirmId,ProductId,[Value]) VALUES (14,3,2,1.70)
```
### -- 1. Вывести информацию из двух таблиц(firmid , firmname,
-- сумму величины value для каждой фирмы)
-- Firmvalues и Firms при помощи при помощи JOIN и группировки
```
SELECT f.FirmId, f.FirmName, SUM(fv.Value) AS TotalValue
FROM dbo.Firms AS f
JOIN dbo.FirmValues AS fv ON f.FirmId = fv.FirmId
GROUP BY f.FirmId, f.FirmName
ORDER BY f.FirmId;
```

![image](https://github.com/user-attachments/assets/b42043da-97d6-4715-8b50-b6820451f695)

### -- 2. Вывести сумму произведения qty*unitprice*(1-discount) из таблицы
-- sales.orderdetails для каждого работника. Вывести фамилию , имя
-- и сумму. (Не забывать что работники находятcя в таблице hr.employees
-- и их данные связаны с таблицей sales.orderdetails через таблицу
-- sales.orders)
```
USE tsql2012
SELECT e.lastname, e.firstname,
SUM(od.qty * od.unitprice * (1 - od.discount)) AS TotalSales
FROM sales.orderdetails AS od
JOIN sales.orders AS o ON od.orderid = o.orderid
JOIN hr.employees AS e ON o.empid = e.empid
GROUP BY e.lastname, e.firstname, e.empid
ORDER BY e.lastname, e.firstname;

-- Замечание: здесь в группировку необходимо включать empid
-- просто потому, что группировка по lastname может включать
-- в одну группу много сотрудников, у которых совпадают фамилии.
```

![image](https://github.com/user-attachments/assets/668f1853-dc8e-4960-b716-f52b1cf3d002)

### -- 3. Упражнение аналогичное предыдущему, только уже данные
--    вычисляются не для сотрудника а для клиента
--    Вывести сумму произведения qty*unitprice*(1-discount) из таблицы
--    sales.orderdetails для каждого клиента. Вывести contactname
--    и сумму. (Не забывать что клиенты находятcя в таблице sales.customers
--    и их данные связаны с таблицей sales.orderdetails через таблицу
--    sales.orders)
```
SELECT c.contactname, 
SUM(od.qty * od.unitprice * (1 - od.discount)) AS TotalSales
FROM sales.orderdetails AS od
JOIN sales.orders AS o ON od.orderid = o.orderid
JOIN sales.customers AS c ON o.custid = c.custid
GROUP BY c.contactname, c.custid
ORDER BY c.contactname;
```

![image](https://github.com/user-attachments/assets/4d04e73b-920a-4719-82b0-e90743c09587)

### -- 4. Вывести сумму произведения qty*unitprice*(1-discount) из таблицы
-- sales.orderdetails для каждого заказа. Вывести еще номер заказа
-- и дату заказа
```
SELECT o.orderid, o.orderdate,
SUM(od.qty * od.unitprice * (1 - od.discount)) AS TotalSales
FROM sales.orderdetails AS od
JOIN sales.orders AS o ON od.orderid = o.orderid
GROUP BY o.orderid, o.orderdate
ORDER BY o.orderid;
```

![image](https://github.com/user-attachments/assets/3daa8aa1-8072-4956-b3ff-2171ecb981e6)

### -- 5. Вывести сумму произведения qty*unitprice*(1-discount)
-- из таблицы sales.orderdetails для каждого года, месяца и дня заказа.
-- выводить в запросе qty*unitprice*(1-discount), год, месяц и день
```
SELECT YEAR(o.orderdate) AS OrderYear,
MONTH(o.orderdate) AS OrderMonth,
DAY(o.orderdate) AS OrderDay,
SUM(od.qty * od.unitprice * (1 - od.discount)) AS TotalSales
FROM sales.orderdetails AS od
JOIN sales.orders AS o ON od.orderid = o.orderid
GROUP BY YEAR(o.orderdate), MONTH(o.orderdate), DAY(o.orderdate)
ORDER BY OrderYear, OrderMonth, OrderDay;
```

![image](https://github.com/user-attachments/assets/d898b16c-a1c5-46ab-8c7e-fda582f9e918)


```
USE testdatabase;

IF object_id('[dbo].[Groups]')
IS NOT NULL DROP TABLE [dbo].[Groups]

CREATE TABLE [dbo].[Groups]
(
  gr_id INT NOT NULL,
  GroupName NVARCHAR(40)
  PRIMARY KEY (gr_id)
)

IF object_id('[dbo].[Students]')
IS NOT NULL DROP TABLE [dbo].[Students]


CREATE TABLE [dbo].[Students]
(
  st_id INT NOT NULL,
  gr_id INT,
  LastName NVARCHAR(60),
  FirstName NVARCHAR(60),
  Patronimic NVARCHAR(60),
  StTicketNumber NVARCHAR(40)
  PRIMARY KEY (st_id)
)

INSERT INTO [dbo].[Groups] (gr_id,GroupName) VALUES (1,'ДКИ-201');
INSERT INTO [dbo].[Groups] (gr_id,GroupName) VALUES (2,'ДКИ-202');


INSERT INTO [dbo].[Students] (st_id, gr_id, LastName, FirstName, Patronimic, StTicketNumber  )
VALUES (1,1,'Дубровский','Владимир','Андреевич','H201')

INSERT INTO [dbo].[Students] (st_id, gr_id, LastName, FirstName, Patronimic, StTicketNumber  )
VALUES (2,1,'Гринев','Петр','Андреевич','Н202');

INSERT INTO [dbo].[Students] (st_id, gr_id, LastName, FirstName, Patronimic, StTicketNumber  )
VALUES (3,1,'Карамазов','Алексей','Федорович','Н203');

INSERT INTO [dbo].[Students] (st_id, gr_id, LastName, FirstName, Patronimic, StTicketNumber  )
VALUES (4,1,'Ларина','Татьяна','Дмитриевна','Н204');

INSERT INTO [dbo].[Students] (st_id, gr_id, LastName, FirstName, Patronimic, StTicketNumber  )
VALUES (5,2,'Ленский','Владимир','Без отчества','Н205');

INSERT INTO [dbo].[Students] (st_id, gr_id, LastName, FirstName, Patronimic, StTicketNumber  )
VALUES (6,2,'Раскольников','Родион','Романович','Н206');

INSERT INTO [dbo].[Students] (st_id, gr_id, LastName, FirstName, Patronimic, StTicketNumber  )
VALUES (7,2,'Ростова','Наталья','Ильинична','Н207');
```
### --6. Сколько студетов учится в каждой группе?
--	 Вывести id группы, наименование группы и количество студентов
--	 в группе
```
SELECT g.gr_id AS GroupId, g.GroupName,
COUNT(s.st_id) AS StudentCount
FROM dbo.Groups AS g
LEFT JOIN dbo.Students AS s ON g.gr_id = s.gr_id
GROUP BY g.gr_id, g.GroupName
ORDER BY g.gr_id;
```

![image](https://github.com/user-attachments/assets/b58a729f-92fe-486a-9c5a-14b8d8ec5204)




