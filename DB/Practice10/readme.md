# Practice 10 по базам данных

## Работу выполнил

Мухин Дмитрий БПИ228


Для работы поднял образ mssql в докере и запросы писал в PyCharm (там же подключился к бд)

## Task1611
```
CREATE TABLE exam
(
    ID       INT,
    [name]   VARCHAR(30),
    class    VARCHAR(10),
    points   INT,
    subjects VARCHAR(30)
)

INSERT INTO exam (ID, [name], class, points, subjects)
VALUES (12, 'Ирина', 'СЭ', 165, 'Математика')
INSERT INTO exam (ID, [name], class, points, subjects)
VALUES (13, 'Дмитрий', 'ФМ', 199, 'Математика')
INSERT INTO exam (ID, [name], class, points, subjects)
VALUES (14, 'Анастасия', 'ХМ', 202, 'Математика')
INSERT INTO exam (ID, [name], class, points, subjects)
VALUES (15, 'Ангелина', 'СЭ', 167, 'Информатика')
INSERT INTO exam (ID, [name], class, points, subjects)
VALUES (16, 'Марк', 'СЭ', 167, 'Математика')
INSERT INTO exam (ID, [name], class, points, subjects)
VALUES (17, 'Александр', 'ФМ', 215, 'Информатика')
INSERT INTO exam (ID, [name], class, points, subjects)
VALUES (18, 'Вера', 'ХМ', 222, 'Информатика')
INSERT INTO exam (ID, [name], class, points, subjects)
VALUES (19, 'Егор', 'ФМ', 179, 'Информатика')
INSERT INTO exam (ID, [name], class, points, subjects)
VALUES (20, 'Арсений', 'ФМ', 179, 'Математика')
```

### -- 1. Ранжировать учеников по баллам всех экзаменов испльзуя функцию DENDE_RANK()
```
SELECT ID,
       [name],
       class,
       points,
       subjects,
       DENSE_RANK() OVER (ORDER BY points DESC) as rank
FROM exam;
```
![image](https://github.com/user-attachments/assets/f5d0269c-50e3-4b37-a974-710a1d936427)

### -- 2. Ранжировать учеников по баллам всех экзаменов испльзуя функцию RANK()
```
SELECT ID,
       [name],
       class,
       points,
       subjects,
       RANK() OVER (ORDER BY points DESC) as rank
FROM exam;
```
![image](https://github.com/user-attachments/assets/491b5d00-9587-4174-b991-244483b06f7c)

### -- 3. Если хотим ранжировать всех учеников по классам
```
SELECT ID,
       [name],
       class,
       points,
       subjects,
       DENSE_RANK() OVER (PARTITION BY class ORDER BY points DESC) as rank
FROM exam;
```
![image](https://github.com/user-attachments/assets/ff881213-4efc-4ce9-bc56-9b561ca7cb2e)

### -- 4. Решить предыдущую задачу если мы хотим сделать сортировку,
-- разбив по предметам(subjects) и в каждом предмете расположить
-- учеников по возрастанию результатов
```
SELECT ID,
       [name],
       class,
       points,
       subjects,
       RANK() OVER (PARTITION BY subjects ORDER BY points) AS rank
FROM exam;
```
![image](https://github.com/user-attachments/assets/e0bad526-27ec-4156-a360-f1007aaad731)

### -- 5. Разбить учащихся на 3 группы в зависимости от набранных
-- баллов (функция NTILE)
```
SELECT ID,
       [name],
       class,
       points,
       subjects,
       NTILE(3) OVER (ORDER BY points DESC) AS group_number
FROM exam;
```
![image](https://github.com/user-attachments/assets/39cd239f-7737-4912-be3f-24f95a6f6443)

### -- 6. Разбить учащихся на две группы для каждого из предметов(subjects),
-- группы в порядке возрастания баллов
```
SELECT ID,
       [name],
       class,
       points,
       subjects,
       NTILE(2) OVER (PARTITION BY subjects ORDER BY points DESC) AS group_number
FROM exam;
```
![image](https://github.com/user-attachments/assets/f022fb5b-9430-4a7d-9ebb-a36f1bd671c4)

### -- 7. Найти в каждом классе(class) одного лучшего по баллам ученика
-- выыессти для них class, points,subjects, id, name
```
SELECT ID,
       [name],
       class,
       points,
       subjects
FROM (SELECT ID,
             [name],
             class,
             points,
             subjects,
             ROW_NUMBER() over (PARTITION BY class ORDER BY points DESC) as row_number
      FROM exam) as ranked
WHERE row_number = 1;
```
![image](https://github.com/user-attachments/assets/16f06cec-bf69-44a5-a641-d3384b1afa02)

### -- 8. Решить задачу предыдущую задачу но уже найти лучших
-- не по классу , а по предмету(subjects)
```
SELECT ID,
       [name],
       class,
       points,
       subjects
FROM (SELECT ID,
             [name],
             class,
             points,
             subjects,
             ROW_NUMBER() over (PARTITION BY subjects ORDER BY points DESC) as row_number
      FROM exam) as ranked
WHERE row_number = 1;
```
![image](https://github.com/user-attachments/assets/d4a7f80b-c0ef-4ba9-859b-4594fee32576)

### -- 9. Показать результаты предыдущего и следующего
-- ученика при сортировке по баллам(функции LAG() и LEAD())
```
SELECT ID,
       [name],
       class,
       points,
       subjects,
       LAG(points) OVER (ORDER BY points DESC)  as previous_points,
       LEAD(points) OVER (ORDER BY points DESC) as next_points
FROM exam;
```
![image](https://github.com/user-attachments/assets/924afa1a-85ff-45aa-afa7-117ded593b33)

### -- 10. Найти насколько при отсортированных данных следующие
-- результаты отличаются от предыдущих по баллам в процентах ,
-- использовать функцию LAG()
```
SELECT ID,
       [name],
       class,
       points,
       subjects,
       LAG(points) OVER (ORDER BY points DESC) AS previous_points,
       (points - LAG(points) OVER (ORDER BY points DESC)) * 100.0 /
       LAG(points) OVER (ORDER BY points DESC) AS diff_percent
FROM exam;
```
![image](https://github.com/user-attachments/assets/133a2bac-5cdb-4a72-8a03-7d0032882171)

### -- 11. Найти насколько при отсортированных данных следующие
-- результаты отличаются от предыдущих по баллам в процентах ,
-- использовать функцию LEAD()
```
SELECT ID,
       [name],
       class,
       points,
       subjects,
       LEAD(points) OVER (ORDER BY points DESC)                             AS next_points,
       (LEAD(points) OVER (ORDER BY points DESC) - points) * 100.0 / points AS diff_percent
FROM exam;
```
![image](https://github.com/user-attachments/assets/d9c5093b-cae8-449f-8af2-a6f08f23e229)

### -- 12. Определить баллы для каждого ученика и данные лучшего и самого отстающего
-- по сравнению с рассматриваемым учеником для каждого предмета(Функции FIRST_VALUE и LAST_VALUE)
```
SELECT ID,
       [name],
       class,
       points,
       subjects,
       FIRST_VALUE([name])
                   OVER (PARTITION BY subjects ORDER BY points DESC ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS best_points,
       LAST_VALUE([name])
                  OVER (PARTITION BY subjects ORDER BY points DESC ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)  AS worst_points
FROM exam;
```
![image](https://github.com/user-attachments/assets/7ef79899-6c15-4486-80b8-6cca2e9a1f74)

### -- 13.Решить предыдущую задачу без оконных функций.
-- Определить баллы для каждого ученика и данные лучшего и самого отстающего
-- по сравнению с рассматриваемым учеником для каждого предмета без
-- оконных функций традиционным методом
```
SELECT e.ID,
       e.[name],
       e.class,
       e.points,
       e.subjects,
       (SELECT TOP 1 [name] FROM exam WHERE subjects = e.subjects ORDER BY points DESC) AS best_student,
       (SELECT TOP 1 [name] FROM exam WHERE subjects = e.subjects ORDER BY points)      AS worst_student
FROM exam e
ORDER BY subjects, points DESC;
```
![image](https://github.com/user-attachments/assets/5bd2c58c-4964-4183-a0f8-a9f1968fefde)

### -- 14. Определить баллы для каждого ученика и разницу между лучшим и самым отстающим
-- по сравнению с рассматриваемым учеником для каждого класса
```
SELECT ID,
       [name],
       class,
       points,
       subjects,
       points - MAX(points) OVER (PARTITION BY class) as difference_with_best,
       points - MIN(points) OVER (PARTITION BY class) as difference_with_worst
FROM exam
ORDER BY class, points DESC;
```
![image](https://github.com/user-attachments/assets/19d8956e-bf24-4b7d-ae41-da84dd8c0baa)

### -- 15. Определить разницу в процентах для каждого ученика между его результатом и
-- и лучшим результатом по его предмету
```
SELECT ID,
       [name],
       class,
       points,
       subjects,
       MAX(points) OVER (PARTITION BY subjects) as best_points,
       (points - MAX(points) OVER (PARTITION BY subjects)) * 100.0 /
       MAX(points) OVER (PARTITION BY subjects) as difference_with_best
FROM exam
ORDER BY subjects, points DESC;
```
![image](https://github.com/user-attachments/assets/053c9d4e-7c7f-4d46-9550-e58f1939df41)

### -- 16. Определить по каждому предмету сумму баллов и долю каждого ученика по отношению
-- к данной сумме по каждому предмету
```
SELECT ID,
       [name],
       class,
       points,
       subjects,
       SUM(points) OVER (PARTITION BY subjects)                    AS total_points,
       (points * 100.0 / SUM(points) OVER (PARTITION BY subjects)) AS contribution_percentage
FROM exam
ORDER BY subjects, points DESC;
```
![image](https://github.com/user-attachments/assets/f5aaa032-1a7f-413e-bb0a-b55e237a43f1)

### -- 17. Определить по каждому классу сумму баллов и долю каждого ученика по отношению
-- к данной сумме по каждому классу
```
SELECT ID,
       [name],
       class,
       points,
       subjects,
       SUM(points) OVER (PARTITION BY class)                    AS total_points,
       (points * 100.0 / SUM(points) OVER (PARTITION BY class)) AS contribution_percentage
FROM exam
ORDER BY class, points DESC;
```
![image](https://github.com/user-attachments/assets/461a4b0e-d135-48d9-a027-24f658e740e5)

### -- 18. Определить сколько учеников сдавало экзамен по каждому предмету,
-- средний балл по каждому предмету
-- отношение баллов каждого ученика к среднему баллу по каждому предмету
```
SELECT ID,
       [name],
       class,
       points,
       subjects,
       COUNT(points) OVER (PARTITION BY subjects)              AS exam_taken_count,
       AVG(points) OVER (PARTITION BY subjects)                AS avg_points,
       points * 1.0 / AVG(points) OVER (PARTITION BY subjects) AS relation_to_avg
FROM exam
ORDER BY subjects, points DESC;
```
![image](https://github.com/user-attachments/assets/0d29b4fc-06f1-4db2-8b8d-fd757238ae4a)

### -- 19. БЕЗ ОКОННЫХ ФУНКЦИЙ. Определить сколько учеников сдавало экзамен по каждому предмету,
-- средний балл по каждому предмету
-- отношение баллов каждого ученика к среднему баллу по каждому предмету
```
SELECT e.ID,
       e.[name],
       e.class,
       e.points,
       e.subjects,
       s.exam_taken_count,
       s.avg_points,
       e.points * 1.0 / s.avg_points AS relation_to_avg
FROM exam e
         JOIN
     (SELECT subjects,
             COUNT(*)    AS exam_taken_count,
             AVG(points) AS avg_points
      FROM exam
      GROUP BY subjects) s
     ON
         e.subjects = s.subjects
ORDER BY e.subjects, e.points DESC;
```
![image](https://github.com/user-attachments/assets/43429e76-a1f5-40a2-889d-9d427d82e5f9)

```
DROP TABLE [dbo].[money]
-- Таблица доходов и расходов
CREATE TABLE [dbo].[money]
(
    [Date]     [datetime],
    [inmoney]  [money] NULL,
    [outmoney] [money] NULL
)

INSERT INTO [money] ([Date], inmoney, outmoney)
VALUES ('2021-01-15', 100, 89)
INSERT INTO [money] ([Date], inmoney, outmoney)
VALUES ('2021-02-15', 100, 78)
INSERT INTO [money] ([Date], inmoney, outmoney)
VALUES ('2021-03-15', 103, 110)
INSERT INTO [money] ([Date], inmoney, outmoney)
VALUES ('2021-04-15', 135, 115)
INSERT INTO [money] ([Date], inmoney, outmoney)
VALUES ('2021-05-15', 135, 86)
INSERT INTO [money] ([Date], inmoney, outmoney)
VALUES ('2021-06-15', 135, 98)
INSERT INTO [money] ([Date], inmoney, outmoney)
VALUES ('2021-07-15', 142, 140)
INSERT INTO [money] ([Date], inmoney, outmoney)
VALUES ('2021-08-15', 150, 142)
INSERT INTO [money] ([Date], inmoney, outmoney)
VALUES ('2021-09-15', 155, 130)
INSERT INTO [money] ([Date], inmoney, outmoney)
VALUES ('2021-10-15', 154, 144)
INSERT INTO [money] ([Date], inmoney, outmoney)
VALUES ('2021-11-15', 160, 120)
INSERT INTO [money] ([Date], inmoney, outmoney)
VALUES ('2021-12-15', 163, 145)


INSERT INTO [money] ([Date], inmoney, outmoney)
VALUES ('2022-01-15', 170, 160)
INSERT INTO [money] ([Date], inmoney, outmoney)
VALUES ('2022-02-15', 172, 154)
INSERT INTO [money] ([Date], inmoney, outmoney)
VALUES ('2022-03-15', 183, 167)
INSERT INTO [money] ([Date], inmoney, outmoney)
VALUES ('2022-04-15', 182, 170)
INSERT INTO [money] ([Date], inmoney, outmoney)
VALUES ('2022-05-15', 175, 176)
INSERT INTO [money] ([Date], inmoney, outmoney)
VALUES ('2022-06-15', 187, 167)
INSERT INTO [money] ([Date], inmoney, outmoney)
VALUES ('2022-07-15', 190, 182)
INSERT INTO [money] ([Date], inmoney, outmoney)
VALUES ('2022-08-15', 188, 175)
INSERT INTO [money] ([Date], inmoney, outmoney)
VALUES ('2022-09-15', 178, 167)
INSERT INTO [money] ([Date], inmoney, outmoney)
VALUES ('2022-10-15', 190, 178)
INSERT INTO [money] ([Date], inmoney, outmoney)
VALUES ('2022-11-15', 199, 183)
INSERT INTO [money] ([Date], inmoney, outmoney)
VALUES ('2022-12-15', 205, 179)
```

### -- 20. Определить доход и расход с нарастающим итогом
```
SELECT [Date],
       inmoney,
       outmoney,
       SUM(inmoney) OVER (ORDER BY [Date])  AS cumulative_income,
       SUM(outmoney) OVER (ORDER BY [Date]) AS cumulative_expense
FROM [money]
ORDER BY [Date];
```
![image](https://github.com/user-attachments/assets/33d648cc-542a-4f4a-8f23-b53984b17950)

### -- 21. Определить разницу дохода с нарастающим итогом и расхода с нарастающим итогом
```
SELECT [Date],
       inmoney,
       outmoney,
       SUM(inmoney) OVER (ORDER BY [Date])                                        AS cumulative_income,
       SUM(outmoney) OVER (ORDER BY [Date])                                       AS cumulative_expense,
       SUM(inmoney) OVER (ORDER BY [Date]) - SUM(outmoney) OVER (ORDER BY [Date]) AS cumulative_difference
FROM [money]
ORDER BY [Date];
```
![image](https://github.com/user-attachments/assets/3ae2eae3-694e-4962-8f1d-e29b53bfcffd)

### -- 22. Определить разницу дохода с нарастающим итогом и расхода с нарастающим итогом
-- для каждого года
```
SELECT [year],
       inmoney,
       outmoney,
       SUM(inmoney) OVER (ORDER BY [year])  AS cumulative_income,
       SUM(outmoney) OVER (ORDER BY [year]) AS cumulative_expense,
       SUM(inmoney) OVER (ORDER BY [year]) -
       SUM(outmoney) OVER (ORDER BY [year]) AS cumulative_difference
FROM (SELECT YEAR([Date])  as [year],
             SUM(inmoney)  as inmoney,
             SUM(outmoney) as outmoney
      FROM [money]
      GROUP BY YEAR([Date])) as money_year;
```
![image](https://github.com/user-attachments/assets/5818f28e-6568-4f30-a702-9a765d38f3de)

### -- 23. Определить среднее значение за каждые три года дохода и расхода
```
SELECT ((YEAR([Date]) - 1) / 3) * 3 + 1 AS start_year,
       ((YEAR([Date]) - 1) / 3) * 3 + 3 AS end_year,
       AVG(inmoney)                     AS avg_income,
       AVG(outmoney)                    AS avg_expense
FROM [money]
GROUP BY ((YEAR([Date]) - 1) / 3)
ORDER BY start_year;
```
![image](https://github.com/user-attachments/assets/d7985fcf-0e01-4a31-8355-4292a22050bb)
