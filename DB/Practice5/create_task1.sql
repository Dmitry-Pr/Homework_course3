USE master;
CREATE DATABASE Task1;
ALTER DATABASE Task1 COLLATE Cyrillic_General_CI_AS;
USE Task1;

CREATE TABLE [dbo].[Students]
(
  st_id int,
  gr_id int,
  LastName VARCHAR(60),
  FirstName VARCHAR(60),
  Patronimic VARCHAR(60),
  StTicketNumber VARCHAR(40)
)

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
