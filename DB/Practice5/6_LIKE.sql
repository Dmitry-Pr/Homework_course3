-- 1. Из базы данных TSQL 2012 из таблицы [Production].[Suppliers]
-- показать  все записи, где поле region равно NULL
SELECT * FROM Production.Suppliers WHERE region IS NULL;

-- 2. Из базы данных TSQL 2012 из таблицы [Production].[Suppliers]
-- показать все записи где поле region не равно NULL
SELECT * FROM Production.Suppliers WHERE region IS NOT NULL;

-- 3. Найти все фамилии в таблице [HR].Employees базы данных TSQL 2012,
-- состоящие из четырех букв (Указание - любая буква это подчеркивание)
SELECT lastname FROM HR.Employees WHERE LEN(lastname) = 4;
SELECT lastname FROM HR.Employees WHERE lastname LIKE N'____';

-- 4. Найти все фамилии в таблице [HR].Employees базы данных TSQL 2012,
-- начинающиеся с Ca(Ка).
SELECT lastname FROM HR.Employees WHERE lastname LIKE N'Ка%';

-- 5. Найти все фамилии в таблице [HR].Employees базы данных TSQL 2012,
-- заканчивающиеся на ed(ед).
SELECT lastname FROM HR.Employees WHERE lastname LIKE N'%ед';

-- 6. Найти все фамилии в таблице [HR].Employees базы данных TSQL 2012,
-- содержащие ele(еле).
SELECT lastname FROM HR.Employees WHERE lastname LIKE N'%еле%';

-- 7. Найти все фамилии в таблице [HR].Employees базы данных TSQL 2012,
-- которые не начинаются с букв ABCDE(АБВГД).
SELECT lastname FROM HR.Employees WHERE lastname NOT LIKE N'[АБВГД]%';