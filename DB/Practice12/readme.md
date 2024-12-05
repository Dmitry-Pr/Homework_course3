# Practice 12 по базам данных

## Работу выполнил

Мухин Дмитрий БПИ228


Для работы поднял образ mssql в докере и запросы писал в PyCharm (там же подключился к бд)

## Task3011
```
USE testdatabase;
```
### -- 1. Написать функцию вычисления площади прямоугольника
-- функция получает два параметра - длину и ширину прямоугольника
```
CREATE FUNCTION dbo.CalculateRectangleArea(
@Length DECIMAL(10, 2),
@Width DECIMAL(10, 2)
)
RETURNS DECIMAL(10, 2)
AS
BEGIN
RETURN @Length * @Width;
END;

SELECT dbo.CalculateRectangleArea(10.50, 5.25) AS RectangleArea; -- Ожидаемое значение: 55.13
```
![image](https://github.com/user-attachments/assets/e7ed9b02-b94d-49c4-89b4-dee3dd24f8e9)

### --  2. Написать функцию вычисления объема параллелепипеда
-- В функцию передается длина , ширина, высота
-- Функция вычисляет объем
```
CREATE FUNCTION dbo.CalculateParallelepipedVolume(
@Length DECIMAL(10, 2),
@Width DECIMAL(10, 2),
@Height DECIMAL(10, 2)
)
RETURNS DECIMAL(10, 2)
AS
BEGIN
RETURN @Length * @Width * @Height;
END;

SELECT dbo.CalculateParallelepipedVolume(10.50, 5.25, 2.00) AS Volume; -- Ожидаемое значение: 110.25
```
![image](https://github.com/user-attachments/assets/4e32bfc4-e882-43e5-9bc7-6adc13ebc951)

### -- 3. Написать функцию вычисления среднего значения от суммы последовательных чисел от
-- 1 до n. Функция принимает значение n decimal(12,2) и возвращает среднее значение
-- суммы чисел.
```
CREATE FUNCTION dbo.CalculateAverageSum(
@N DECIMAL(12, 2)
)
RETURNS DECIMAL(12, 2)
AS
BEGIN
RETURN (@N * (@N + 1) / 2) / @N;
END;

SELECT dbo.CalculateAverageSum(10) AS AverageSum; -- Ожидаемое значение: 5.5
```
![image](https://github.com/user-attachments/assets/78c9480a-7008-4241-8685-aa9b28550664)

### -- 4. Написать функцию вычисления сложного процента.
-- В функцию передается сумма value типа DECIMAL(12.2),
-- значение процента pers в виде числа с плавающей точкой,
-- например 0.20 и количества лет для вычисления.
```
CREATE FUNCTION dbo.CalculateCompoundInterest(
@Value DECIMAL(12, 2),
@Rate FLOAT,
@Years INT
)
RETURNS DECIMAL(12, 2)
AS
BEGIN
RETURN @Value * POWER(1 + @Rate, @Years);
END;

SELECT dbo.CalculateCompoundInterest(1000.00, 0.05, 3) AS CompoundInterest; -- Ожидаемое значение: 1157.63
```
![image](https://github.com/user-attachments/assets/10e49588-b5ae-4bb9-8903-7aaa09a65031)

### -- 5 Решить задачу 4. при условии, что на второй год проценты
-- возрастают на пятую часть об своего предыдущего значения.
```
CREATE FUNCTION dbo.CalculateDynamicCompoundInterest(
@Value DECIMAL(12, 2),
@Rate FLOAT,
@Years INT
)
RETURNS DECIMAL(12, 2)
AS
BEGIN
DECLARE @Total DECIMAL(12, 2) = @Value;
DECLARE @CurrentRate FLOAT = @Rate;
DECLARE @Year INT = 1;

WHILE @Year <= @Years
BEGIN
SET @Total = @Total * (1 + @CurrentRate);
SET @CurrentRate = @CurrentRate + (@CurrentRate / 5); -- Увеличение на 20%
SET @Year = @Year + 1;
END;

RETURN @Total;
END;

SELECT dbo.CalculateDynamicCompoundInterest(1000.00, 0.05, 3) AS DynamicCompoundInterest; -- Ожидаемое значение: 1193.14
```
![image](https://github.com/user-attachments/assets/eb8ab618-c8e1-4210-8898-b8ce9a43a77d)

### -- 6. Написать функцию, вычисляющую степень числа. В функцию
-- передается число value типа DECIMAL(12,3) и показатель
-- степени n типа INT. Функция возвращает число типа
-- DECIMAL(12,3)
```
CREATE FUNCTION dbo.CalculatePower(
@Value DECIMAL(12, 3),
@Exponent INT
)
RETURNS DECIMAL(12, 3)
AS
BEGIN
RETURN POWER(@Value, @Exponent);
END;

SELECT dbo.CalculatePower(2.5, 3) AS PowerResult; -- Ожидаемое значение: 15.625
```
![image](https://github.com/user-attachments/assets/dfff8dbb-f98e-47ba-8fa1-d2ea20c7b691)

### -- 7. Написать хранимую процедуру получения среднего значения
-- для четных чисел  целого числа n. Среднее значение вычисляется как сумма
-- последовательных четных чисел от 1 до n поделенная на количество
-- цифр, составляющих эту сумму. Алгоритм реализовать при помощи
-- создания временной таблицы и вычисления среднего значения ее поля.
```
USE testdatabase;
CREATE PROCEDURE dbo.CalculateEvenNumbersAverage
(
@N INT
)
AS
BEGIN
CREATE TABLE #TempEvenNumbers
(
EvenNumber INT
);
DECLARE @Counter INT = 2;
WHILE @Counter <= @N
BEGIN
INSERT INTO #TempEvenNumbers (EvenNumber)
VALUES (@Counter);

SET @Counter = @Counter + 2;
END;
SELECT
AVG(EvenNumber) AS AverageValue
FROM
#TempEvenNumbers;
DROP TABLE #TempEvenNumbers;
END;

EXEC dbo.CalculateEvenNumbersAverage @N = 10; -- Ожидаемое значение: 6 (среднее четных чисел 2, 4, 6, 8, 10).
```
![image](https://github.com/user-attachments/assets/6d6e5f83-8ec0-4bc0-8b5d-90bffff55fbb)

### -- 8. Написать хранимую процедуру, которая получает на вход фамилию сотрудника
-- и вычисляет среднее значение произведения qty*unitprice*(1-discount) для
-- таблицы sales.orderdetails базы данных tsql2012
```
USE TSQL2012;
CREATE PROCEDURE dbo.CalculateAverageByEmployee(
@EmployeeLastName NVARCHAR(50)
)
AS
BEGIN
SELECT AVG(qty * unitprice * (1 - discount)) AS AverageValue
FROM sales.orderdetails od
JOIN sales.orders o ON od.orderid = o.orderid
JOIN hr.employees e ON e.empid = o.empid
WHERE e.lastname = @EmployeeLastName;
END;

EXEC dbo.CalculateAverageByEmployee @EmployeeLastName = N'Дэвис';
```
![image](https://github.com/user-attachments/assets/cdcab7bb-4f64-4781-a93d-6a936faa5a92)

### -- 9. Написать триггер типа AFTER для таблицы из трех полей AfterT
```
USE testdatabase;

CREATE TABLE dbo.AfterT
(
ID           INT IDENTITY PRIMARY KEY,
Value        NVARCHAR(100) NOT NULL,
ModifiedDate DATETIME DEFAULT GETDATE()
);


CREATE TRIGGER dbo.AfterInsertTrigger
ON dbo.AfterT
AFTER INSERT
AS
BEGIN
PRINT 'Insert operation detected.';
END;

CREATE TRIGGER dbo.AfterUpdateTrigger
ON dbo.AfterT
AFTER UPDATE
AS
BEGIN
PRINT 'Update operation detected.';
END;

CREATE TRIGGER dbo.AfterDeleteTrigger
ON dbo.AfterT
AFTER DELETE
AS
BEGIN
PRINT 'Delete operation detected.';
END;

```
-- Для проверки триггера dbo.AfterInsertTrigger
```
INSERT INTO dbo.AfterT (Value) VALUES ('Test Value');
```
![image](https://github.com/user-attachments/assets/fbcc0d18-9c2d-4dd3-a25a-7bedb78c4930)

-- Для проверки триггера dbo.AfterUpdateTrigger
```
UPDATE dbo.AfterT SET Value = 'Updated Value' WHERE ID = 1;
```
![image](https://github.com/user-attachments/assets/3e282b34-372a-4598-b56b-3fbbee5a74a1)

-- Для проверки триггера dbo.AfterDeleteTrigger
```
DELETE FROM dbo.AfterT WHERE ID = 1;
```
![image](https://github.com/user-attachments/assets/b109bd90-71d3-4864-b7ec-76c03a0b6ef1)

### --10. Написать хранимую процедуру, которая выводит записи из таблицы
-- sales.orderdetails для диапазона полных стоимостей(qty*unitprice*(1-discount)) от @v1 lj @v2
```
USE TSQL2012;
CREATE PROCEDURE dbo.GetOrdersByCostRange(
@V1 DECIMAL(12, 2),
@V2 DECIMAL(12, 2)
)
AS
BEGIN
SELECT *
FROM sales.orderdetails
WHERE qty * unitprice * (1 - discount) BETWEEN @V1 AND @V2;
END;

EXEC dbo.GetOrdersByCostRange @V1 = 50.00, @V2 = 51.00; -- Ожидаем список заказов с полной стоимостью в указанном диапазоне.
```
![image](https://github.com/user-attachments/assets/377e494e-576c-4499-8177-f6a3812c61c8)

### -- 11. Написать хранимую процедуру постраничного вывода записей из таблицы
-- tsql2012.sales.OrderDetails. В функцию передается начальное смещение
-- для строки и количество выводимых на страницу записей
```
CREATE PROCEDURE dbo.PaginateOrderDetails(
@Offset INT,
@PageSize INT
)
AS
BEGIN
SELECT *
FROM tsql2012.sales.OrderDetails
ORDER BY orderid
OFFSET @Offset ROWS FETCH NEXT @PageSize ROWS ONLY;
END;

EXEC dbo.PaginateOrderDetails @Offset = 0, @PageSize = 10; -- Ожидаем первые 10 записей.
```
![image](https://github.com/user-attachments/assets/37e7dce2-177a-4813-a080-1c980394fc01)

