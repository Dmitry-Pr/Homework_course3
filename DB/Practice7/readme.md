# Practice 6 по базам данных

## Работу выполнил

Мухин Дмитрий БПИ228


Для работы поднял образ mssql в докере и запросы писал в PyCharm (там же подключился к бд)

## Task 1 (из файла)
```
USE Task2410
IF object_id('dbo.Students','U') IS NOT NULL
DROP TABLE Students
IF object_id('dbo.Groups','U') IS NOT NULL
DROP TABLE Groups

CREATE TABLE [dbo].[Groups]
(
  gr_id INT,
  GroupName NVARCHAR(40)
  PRIMARY KEY (gr_id)
)

CREATE TABLE [dbo].[Students]
(
  st_id INT not null,
  gr_id INT,
  LastName NVARCHAR(60),
  FirstName NVARCHAR(60),
  Patronimic NVARCHAR(60),
  StTicketNumber NVARCHAR(40),
  PRIMARY KEY (st_id),
)

INSERT INTO [dbo].[Groups] (gr_id,GroupName) VALUES (1,'ДКИ-201');
INSERT INTO [dbo].[Groups] (gr_id,GroupName) VALUES (2,'ДКИ-202');


INSERT INTO [dbo].[Students] (st_id, gr_id, LastName, FirstName, Patronimic, StTicketNumber  )
VALUES (1,1,'Дубровский','Владимир','Андреевич','H201')

INSERT INTO [dbo].[Students] (st_id, gr_id, LastName, FirstName, Patronimic, StTicketNumber  )
VALUES (2,1,'Карамазов','Алексей','Федорович','Н203');


INSERT INTO [dbo].[Students] (st_id, gr_id, LastName, FirstName, Patronimic, StTicketNumber  )
VALUES (3,1,'Гринев','Петр','Андреевич','Н202');


INSERT INTO [dbo].[Students] (st_id, gr_id, LastName, FirstName, Patronimic, StTicketNumber  )
VALUES (4,1,'Ларина','Татьяна','Дмитриевна','Н204');

INSERT INTO [dbo].[Students] (st_id, gr_id, LastName, FirstName, Patronimic, StTicketNumber  )
VALUES (5,2,'Ленский','Владимир','Без отчества','Н205');

INSERT INTO [dbo].[Students] (st_id, gr_id, LastName, FirstName, Patronimic, StTicketNumber  )
VALUES (6,2,'Раскольников','Родион','Без отчества','Н206');

INSERT INTO [dbo].[Students] (st_id, gr_id, LastName, FirstName, Patronimic, StTicketNumber  )
VALUES (7,2,'Ростова','Наталья','Ильинична','Н207');

INSERT INTO [dbo].[Students] (st_id, gr_id, LastName, FirstName, Patronimic, StTicketNumber  )
VALUES (8,1,'Карамазов','Иван','Федорович','Н208');

INSERT INTO [dbo].[Students] (st_id, gr_id, LastName, FirstName, Patronimic, StTicketNumber  )
VALUES (9,1,'Карамазов','Дмитрий','Федорович','Н208');


CREATE TABLE [dbo].[Subjects]
(
  s_id BIGINT,
  Discipline NVARCHAR(40)
  PRIMARY KEY (s_id)
)

CREATE TABLE [dbo].[StudentSubject]
(
  st_id BIGINT,
  s_id BIGINT
  PRIMARY KEY (st_id,s_id)
)


INSERT INTO [dbo].[Subjects] (s_id, discipline) VALUES (1,'Математика')
INSERT INTO [dbo].[Subjects] (s_id, discipline) VALUES (2,'Физика')
INSERT INTO [dbo].[Subjects] (s_id, discipline) VALUES (3,'Физкультура')
INSERT INTO [dbo].[Subjects] (s_id, discipline) VALUES (4,'Программирование')



INSERT INTO [dbo].[StudentSubject] (st_id, s_id) VALUES (1,1)
INSERT INTO [dbo].[StudentSubject] (st_id, s_id) VALUES (1,2)
INSERT INTO [dbo].[StudentSubject] (st_id, s_id) VALUES (1,3)

INSERT INTO [dbo].[StudentSubject] (st_id, s_id) VALUES (2,1)
INSERT INTO [dbo].[StudentSubject] (st_id, s_id) VALUES (2,2)
INSERT INTO [dbo].[StudentSubject] (st_id, s_id) VALUES (2,3)

INSERT INTO [dbo].[StudentSubject] (st_id, s_id) VALUES (3,4)
INSERT INTO [dbo].[StudentSubject] (st_id, s_id) VALUES (3,3)


INSERT INTO [dbo].[StudentSubject] (st_id, s_id) VALUES (4,1)
INSERT INTO [dbo].[StudentSubject] (st_id, s_id) VALUES (4,2)

INSERT INTO [dbo].[StudentSubject] (st_id, s_id) VALUES (5,1)
INSERT INTO [dbo].[StudentSubject] (st_id, s_id) VALUES (5,4)
INSERT INTO [dbo].[StudentSubject] (st_id, s_id) VALUES (5,3)

INSERT INTO [dbo].[StudentSubject] (st_id, s_id) VALUES (6,3)
INSERT INTO [dbo].[StudentSubject] (st_id, s_id) VALUES (6,4)

INSERT INTO [dbo].[StudentSubject] (st_id, s_id) VALUES (7,3)
INSERT INTO [dbo].[StudentSubject] (st_id, s_id) VALUES (7,4)
```
#### -- 1. Проверить запросом к таблицам groups и students
-- нет ли в таблице groups групп, в которых не занимается
-- ни один студент.
```
SELECT g.gr_id, g.groupname
FROM groups g
LEFT JOIN students s ON g.gr_id = s.gr_id
WHERE s.gr_id IS NULL;
```

```
CREATE TABLE Authors
(
  au_id int,
  au_lastname varchar(30)
)
CREATE TABLE books
(
  b_id int,
  au_id int,
  b_name varchar(60)
)
INSERT INTO Authors (au_id, au_lastname) VALUES (1,'Диккенс')
INSERT INTO Authors (au_id, au_lastname) VALUES (2,'Лондон')
INSERT INTO Authors (au_id, au_lastname) VALUES (3,'Голсуорси')

INSERT INTO books (b_id, au_id, b_name) VALUES (1,1,'Дэвид Коперфилд')
INSERT INTO books (b_id, au_id, b_name) VALUES (2,1,'Оливер Твист')
INSERT INTO books (b_id, au_id, b_name) VALUES (3,2,'Мартин Иден')
INSERT INTO books (b_id, au_id, b_name) VALUES (4,2,'Маленькая хозяйка большого дома')
INSERT INTO books (b_id, au_id, b_name) VALUES (5,3,'Сага о Форсайтах')
```

#### -- 2. Объединить запросом две таблицы и вывести авторов и названия книг
```
SELECT a.au_lastname, b.b_name
FROM Authors a
JOIN books b ON a.au_id = b.au_id;
```

```
CREATE TABLE [dbo].Classik
(
  classik_id bigint
  ,lastname nvarchar(40)
  , firstname nvarchar (40)
);

CREATE TABLE [dbo].Phrases
(
  phrase_id bigint
  ,classik_id bigint
  ,phrase nvarchar(100)
)

INSERT INTO Classik (classik_id , firstname, lastname ) VALUES (1, 'Михаил','Горбачев')
INSERT INTO Classik (classik_id , firstname, lastname ) VALUES (2, 'Остап','Бендер')
INSERT INTO Classik (classik_id , firstname, lastname ) VALUES (3, 'Генерал','Зайцев')

INSERT INTO [dbo].Phrases (phrase_id, classik_id, phrase) VALUES (1, 1, 'Процесс пошел');
INSERT INTO [dbo].Phrases (phrase_id, classik_id, phrase) VALUES (2, 1, 'Нужно начать с целью углубить, чтобы сформировать');

INSERT INTO [dbo].Phrases (phrase_id, classik_id, phrase) VALUES (3, 2, 'Лед тронулся господа присяжные заседатели. Командовать парадом буду я');
INSERT INTO [dbo].Phrases (phrase_id, classik_id, phrase) VALUES (4, 2, 'Может, тебе еще ключ от квартиры, где деньги лежат?');
INSERT INTO [dbo].Phrases (phrase_id, classik_id, phrase) VALUES (5, 2, 'Кто скажет, что Киса девочка - пусть первый кинет в меня камень');

INSERT INTO [dbo].Phrases (phrase_id, classik_id, phrase) VALUES (6, 3, 'Документ будет показан узкому кругу ограниченных лиц');
INSERT INTO [dbo].Phrases (phrase_id, classik_id, phrase) VALUES (7, 3, 'От меня до следующего столба шагом марш');
INSERT INTO [dbo].Phrases (phrase_id, classik_id, phrase) VALUES (8, 3, 'Зашел к солдатам, открыл тумбочку, а там стоят кеды, грязные по колено');
```

#### --3. Объединить при помощи JOIN таблицы [dbo].Classik и [dbo].Phrases и вывести все поля
```
SELECT c.*, p.*
FROM [dbo].Classik c
JOIN [dbo].Phrases p ON c.classik_id = p.classik_id;
```


#### --4. Вывести на экран при джойне двух таблиц Classik и Phrases крылатые выражения Горбачева
```
SELECT p.phrase
FROM [dbo].Classik c
JOIN [dbo].Phrases p ON c.classik_id = p.classik_id
WHERE c.firstname = 'Михаил' AND c.lastname = 'Горбачев';
```

#### --5. Вывести на экран при соединении двух таблиц из задачи 2
--   выражения Горбачева и Зайцева
```
SELECT p.phrase
FROM [dbo].Classik c
JOIN [dbo].Phrases p ON c.classik_id = p.classik_id
WHERE (c.firstname = 'Михаил' AND c.lastname = 'Горбачев')
OR (c.firstname = 'Генерал' AND c.lastname = 'Зайцев');
```

```
CREATE TABLE cities
(
  city_id bigint
  ,city_name nvarchar(40)
);

CREATE TABLE regions
(
  region_id bigint
  ,city_id bigint
  ,region_name nvarchar(60)
);

CREATE TABLE streets
(
 street_id bigint
 ,region_id bigint
 ,street_name nvarchar(60)
);


INSERT INTO cities (city_id, city_name) VALUES (1,'Тьма Таракань');
INSERT INTO cities (city_id, city_name) VALUES (2,'Семьбедуполь');

INSERT INTO regions (region_id, city_id, region_name) VALUES (1,1,'Район процветания');
INSERT INTO regions (region_id, city_id, region_name) VALUES (2,1,'Район бардака');
INSERT INTO regions (region_id, city_id, region_name) VALUES (3,1,'Район любителей рэпа');

INSERT INTO regions (region_id, city_id, region_name) VALUES (4,2,'Район спортивный');
INSERT INTO regions (region_id, city_id, region_name) VALUES (5,2,'Район железнодорожников');
INSERT INTO regions (region_id, city_id, region_name) VALUES (6,2,'Район влюбленных');


INSERT INTO streets (street_id, region_id, street_name) VALUES (1,1,'ул. Тридевятого царства');
INSERT INTO streets (street_id, region_id, street_name) VALUES (2,1,'ул. Несмеяны');
INSERT INTO streets (street_id, region_id, street_name) VALUES (3,1,'ул. Турандот спохмелья');
INSERT INTO streets (street_id, region_id, street_name) VALUES (4,1,'ул. Ленина');

INSERT INTO streets (street_id, region_id, street_name) VALUES (5,2,'ул. Слава КПСС');
INSERT INTO streets (street_id, region_id, street_name) VALUES (6,2,'ул. 1-й пятилетки');
INSERT INTO streets (street_id, region_id, street_name) VALUES (7,2,'ул. 20-го съезда партии');

INSERT INTO streets (street_id, region_id, street_name) VALUES (8,3,'ул. Пляски вприсядку');
INSERT INTO streets (street_id, region_id, street_name) VALUES (9,3,'ул. Пьянки вповалку');
INSERT INTO streets (street_id, region_id, street_name) VALUES (10,3,'ул. Даешь ля третьей октавы');

INSERT INTO streets (street_id, region_id, street_name) VALUES (11,4,'ул. Э. Стрельцова');
INSERT INTO streets (street_id, region_id, street_name) VALUES (12,4,'ул. Спартак чемпион');
INSERT INTO streets (street_id, region_id, street_name) VALUES (13,4,'ул. ЦСКА кони');

INSERT INTO streets (street_id, region_id, street_name) VALUES (14,5,'ул. Виноватых стрелочников');
INSERT INTO streets (street_id, region_id, street_name) VALUES (15,5,'ул. Красная стрела');
INSERT INTO streets (street_id, region_id, street_name) VALUES (16,5,'ул. Сапсан');

INSERT INTO streets (street_id, region_id, street_name) VALUES (17,6,'ул. С первого взгляда');
INSERT INTO streets (street_id, region_id, street_name) VALUES (18,6,'ул. Только после ЗАГСа');
INSERT INTO streets (street_id, region_id, street_name) VALUES (19,6,'ул. Лучше съесть свой паспорт');
```

#### --6. Объединить при помощи JOIN две таблицы cities и regions
--   и вывести все значения на экран
```
SELECT ci.*, r.*
FROM cities ci
JOIN regions r ON ci.city_id = r.city_id;
```

#### --7. Вывести на экран запрос предыдущей задачи  для города Тьматаракань
```
SELECT ci.*, r.*
FROM cities ci
JOIN regions r ON ci.city_id = r.city_id
WHERE ci.city_name = 'Тьма Таракань';
```

#### -- 8. Объединить при помощи JOIN две таблицы regions и streets
--   и вывести район и его улицу, для района в котором
--   есть улица похожая на выражение "спартак чемпион"
```
SELECT r.region_name, s.street_name
FROM regions r
JOIN streets s ON r.region_id = s.region_id
WHERE s.street_name LIKE '%спартак чемпион%';
```

#### -- 9. Вывести значение города , его района и улицу , для города
--    района и улицы, где есть выражение в названии улицы похожее на "даешь ля"
```
SELECT ci.city_name, r.region_name, s.street_name
FROM cities ci
JOIN regions r ON ci.city_id = r.city_id
JOIN streets s ON r.region_id = s.region_id
WHERE s.street_name LIKE '%даешь ля%';
```

#### -- 10. Вывести значение города , его района и улицу , для города
--    района и улицы, где есть выражение в названии улицы похожее на "ЗАГС"
```
SELECT ci.city_name, r.region_name, s.street_name
FROM cities ci
JOIN regions r ON ci.city_id = r.city_id
JOIN streets s ON r.region_id = s.region_id
WHERE s.street_name LIKE '%ЗАГС%';
```

#### --11. Подсчитать сумму для поля qty таблицы Sales.OrderDetails
--    базы данных TSQL2012
```
USE TSQL2012
SELECT SUM(qty) AS total_qty
FROM Sales.OrderDetails;
```

#### -- 12. Определить записи со стоимостью , подсчитанную в таблице
--    sales.orderdetails больше чем 50.5
```
SELECT *
FROM Sales.OrderDetails
WHERE qty * unitprice * (1 - discount) > 50.5;
```

#### -- 13. Подсчитать среднее выражение для произведения qty * unitprice *(1-discount) в
--    таблице Sales.OrderDetails для сотрудника по фамилии Peled (база tsql2012)
--    Указание: Сделать JOIN таблицы Sales.Orders Sales.OrderDetails HR.Employees
```
SELECT AVG(qty * unitprice * (1 - discount)) AS avg_value
FROM Sales.OrderDetails od
JOIN Sales.Orders o ON od.orderid = o.orderid
JOIN HR.Employees e ON o.empid = e.empid
WHERE e.lastname = 'Peled';
```

#### -- 14. Найти максимальное значение выражения qty * unitprice *(1-discount)
--    в таблице Sales.OrderDetails для клиента у которого contactname = "Ray, Mike"(база tsql2012)
--    Указание: Сделать JOIN таблицы Sales.Orders Sales.OrderDetails
--	Sales.Customers
```
SELECT MAX(qty * unitprice * (1 - discount)) AS max_value
FROM Sales.OrderDetails od
JOIN Sales.Orders o ON od.orderid = o.orderid
JOIN Sales.Customers c ON o.custid = c.custid
WHERE c.contactname = 'Ray, Mike';
```

#### -- 15. Определить по таблицам sales.customers и sales.orders заказчиков,
-- которые не сделали ни одного заказа(использовать LEFT JOIN)
```
SELECT c.custid, c.contactname
FROM Sales.Customers c
LEFT JOIN Sales.Orders o ON c.custid = o.custid
WHERE o.orderid IS NULL;
```

#### -- 16. Вывести информацию о сотрудниках и их заказах из таблиц hr.employees и
-- sales.orders при помощи JOIN (вывести lastname, firstname, orderdate)
```
SELECT e.lastname, e.firstname, o.orderdate
FROM HR.Employees e
JOIN Sales.Orders o ON e.empid = o.empid;
```

#### -- 17. Вывести информацию о клиентах и их заказах из таблиц sales.customers и
-- sales.orders при помощи JOIN (вывести contactname, orderdate)
```
SELECT c.contactname, o.orderdate
FROM Sales.Customers c
JOIN Sales.Orders o ON c.custid = o.custid;
```

