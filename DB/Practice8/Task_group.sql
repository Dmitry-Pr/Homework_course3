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

-- 1. Вывести информацию из двух таблиц(firmid , firmname,
-- сумму величины value для каждой фирмы)
-- Firmvalues и Firms при помощи при помощи JOIN и группировки

SELECT f.FirmId, f.FirmName, SUM(fv.Value) AS TotalValue
FROM dbo.Firms AS f
JOIN dbo.FirmValues AS fv ON f.FirmId = fv.FirmId
GROUP BY f.FirmId, f.FirmName
ORDER BY f.FirmId;

USE tsql2012

-- 2. Вывести сумму произведения qty*unitprice*(1-discount) из таблицы
-- sales.orderdetails для каждого работника. Вывести фамилию , имя
-- и сумму. (Не забывать что работники находятcя в таблице hr.employees
-- и их данные связаны с таблицей sales.orderdetails через таблицу
-- sales.orders)

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


-- 3. Упражнение аналогичное предыдущему, только уже данные
--    вычисляются не для сотрудника а для клиента
--    Вывести сумму произведения qty*unitprice*(1-discount) из таблицы
--    sales.orderdetails для каждого клиента. Вывести contactname
--    и сумму. (Не забывать что клиенты находятcя в таблице sales.customers
--    и их данные связаны с таблицей sales.orderdetails через таблицу
--    sales.orders)

SELECT c.contactname, 
SUM(od.qty * od.unitprice * (1 - od.discount)) AS TotalSales
FROM sales.orderdetails AS od
JOIN sales.orders AS o ON od.orderid = o.orderid
JOIN sales.customers AS c ON o.custid = c.custid
GROUP BY c.contactname, c.custid
ORDER BY c.contactname;

-- 4. Вывести сумму произведения qty*unitprice*(1-discount) из таблицы
-- sales.orderdetails для каждого заказа. Вывести еще номер заказа
-- и дату заказа

SELECT o.orderid, o.orderdate,
SUM(od.qty * od.unitprice * (1 - od.discount)) AS TotalSales
FROM sales.orderdetails AS od
JOIN sales.orders AS o ON od.orderid = o.orderid
GROUP BY o.orderid, o.orderdate
ORDER BY o.orderid;

-- 5. Вывести сумму произведения qty*unitprice*(1-discount)
-- из таблицы sales.orderdetails для каждого года, месяца и дня заказа.
-- выводить в запросе qty*unitprice*(1-discount), год, месяц и день

SELECT YEAR(o.orderdate) AS OrderYear,
MONTH(o.orderdate) AS OrderMonth,
DAY(o.orderdate) AS OrderDay,
SUM(od.qty * od.unitprice * (1 - od.discount)) AS TotalSales
FROM sales.orderdetails AS od
JOIN sales.orders AS o ON od.orderid = o.orderid
GROUP BY YEAR(o.orderdate), MONTH(o.orderdate), DAY(o.orderdate)
ORDER BY OrderYear, OrderMonth, OrderDay;



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

--6. Сколько студетов учится в каждой группе?
--	 Вывести id группы, наименование группы и количество студентов
--	 в группе

SELECT g.gr_id AS GroupId, g.GroupName,
COUNT(s.st_id) AS StudentCount
FROM dbo.Groups AS g
LEFT JOIN dbo.Students AS s ON g.gr_id = s.gr_id
GROUP BY g.gr_id, g.GroupName
ORDER BY g.gr_id;






