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

