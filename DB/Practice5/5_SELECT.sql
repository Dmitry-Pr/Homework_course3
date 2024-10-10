USE TSQL2012
--SELECT с различной логикой запроса

--Выбрать из таблицы hr.employees информацию о сотруднике с empid = 4
SELECT * FROM HR.Employees WHERE empid = 4

--Выбрать из таблицы hr.employees информацию о сотруднике с empid = 3 и о сотруднике с empid = 8
SELECT * FROM HR.Employees WHERE empid in (3, 8)
SELECT * FROM HR.Employees WHERE empid = 3 OR empid = 8

--Выбрать из таблицы hr.employees информацию о сотрудниках,
-- у которых  empid >= 2 и empid <= 6
SELECT * FROM HR.Employees WHERE empid BETWEEN 2 AND 6
SELECT * FROM HR.Employees WHERE empid >= 2 AND empid <= 6

--Выбрать из таблицы hr.employees информацию о сотрудниках,
-- у которых  empid <= 3 и empid >= 6
SELECT * FROM HR.Employees WHERE empid <= 3 OR empid >= 6

--Выбрать из таблицы hr.employees информацию о сотрудниках,
-- у которых  empid >= 3 и empid <= 7 и empid <> 4
SELECT * FROM HR.Employees WHERE empid >= 3 AND empid <= 7 AND empid <> 4
SELECT * FROM HR.Employees WHERE empid BETWEEN 3 AND 7 AND empid <> 4

--Выбрать из таблицы hr.employees информацию о сотрудниках,
-- у которых  empid >= 3 и empid <= 7 и empid <> 4 и(или) empid = 9
SELECT * FROM HR.Employees WHERE empid >= 3 AND empid <= 7 AND empid <> 4 OR empid = 9
SELECT * FROM HR.Employees WHERE empid BETWEEN 3 AND 7 AND empid <> 4 OR empid = 9

--Выбрать из таблицы hr.employees информацию о сотрудниках,
--которые родились в 1971 году
SELECT * FROM HR.Employees WHERE YEAR(birthdate) = 1971

--Выбрать из таблицы hr.employees информацию о сотрудниках,
--которые родились в январе
SELECT * FROM HR.Employees WHERE MONTH(birthdate) = 1

-- Пример , который показывает, что порядок выполнения инструкций
-- в SQL запросах отличается от последовательности инструкций
-- написанных в запросе

 SELECT *, qty*unitprice*(1-od.discount) AS cost FROM sales.OrderDetails od
 ORDER BY cost

 SELECT *, qty*unitprice*(1-od.discount) AS cost FROM sales.OrderDetails od
 WHERE  cost > 26 -- Данный запрос выполняться не будет

 -- Действительный порядок выполнения запросов
 -- происходит в следующей последовательности

 --FROM
 --WHERE
 --GROUP BY
 --HAVING
 --SELECT
 --ORDER BY
 --TOP
