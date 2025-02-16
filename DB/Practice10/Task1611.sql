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


-- 1. Ранжировать учеников по баллам всех экзаменов испльзуя функцию DENDE_RANK()

SELECT ID,
       [name],
       class,
       points,
       subjects,
       DENSE_RANK() OVER (ORDER BY points DESC) as rank
FROM exam;

-- 2. Ранжировать учеников по баллам всех экзаменов испльзуя функцию RANK()

SELECT ID,
       [name],
       class,
       points,
       subjects,
       RANK() OVER (ORDER BY points DESC) as rank
FROM exam;

-- 3. Если хотим ранжировать всех учеников по классам

SELECT ID,
       [name],
       class,
       points,
       subjects,
       DENSE_RANK() OVER (PARTITION BY class ORDER BY points DESC) as rank
FROM exam;

-- 4. Решить предыдущую задачу если мы хотим сделать сортировку,
-- разбив по предметам(subjects) и в каждом предмете расположить
-- учеников по возрастанию результатов

SELECT ID,
       [name],
       class,
       points,
       subjects,
       RANK() OVER (PARTITION BY subjects ORDER BY points) AS rank
FROM exam;

-- 5. Разбить учащихся на 3 группы в зависимости от набранных
-- баллов (функция NTILE)

SELECT ID,
       [name],
       class,
       points,
       subjects,
       NTILE(3) OVER (ORDER BY points DESC) AS group_number
FROM exam;

-- 6. Разбить учащихся на две группы для каждого из предметов(subjects),
-- группы в порядке возрастания баллов

SELECT ID,
       [name],
       class,
       points,
       subjects,
       NTILE(2) OVER (PARTITION BY subjects ORDER BY points DESC) AS group_number
FROM exam;

-- 7. Найти в каждом классе(class) одного лучшего по баллам ученика
-- выыессти для них class, points,subjects, id, name

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

-- 8. Решить задачу предыдущую задачу но уже найти лучших
-- не по классу , а по предмету(subjects)

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

-- 9. Показать результаты предыдущего и следующего
-- ученика при сортировке по баллам(функции LAG() и LEAD())

SELECT ID,
       [name],
       class,
       points,
       subjects,
       LAG(points) OVER (ORDER BY points DESC)  as previous_points,
       LEAD(points) OVER (ORDER BY points DESC) as next_points
FROM exam;

-- 10. Найти насколько при отсортированных данных следующие
-- результаты отличаются от предыдущих по баллам в процентах ,
-- использовать функцию LAG()

SELECT ID,
       [name],
       class,
       points,
       subjects,
       LAG(points) OVER (ORDER BY points DESC) AS previous_points,
       (points - LAG(points) OVER (ORDER BY points DESC)) * 100.0 /
       LAG(points) OVER (ORDER BY points DESC) AS diff_percent
FROM exam;


-- 11. Найти насколько при отсортированных данных следующие
-- результаты отличаются от предыдущих по баллам в процентах ,
-- использовать функцию LEAD()

SELECT ID,
       [name],
       class,
       points,
       subjects,
       LEAD(points) OVER (ORDER BY points DESC)                             AS next_points,
       (LEAD(points) OVER (ORDER BY points DESC) - points) * 100.0 / points AS diff_percent
FROM exam;


-- 12. Определить баллы для каждого ученика и данные лучшего и самого отстающего
-- по сравнению с рассматриваемым учеником для каждого предмета(Функции FIRST_VALUE и LAST_VALUE)

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


-- 13.Решить предыдущую задачу без оконных функций.
-- Определить баллы для каждого ученика и данные лучшего и самого отстающего
-- по сравнению с рассматриваемым учеником для каждого предмета без
-- оконных функций традиционным методом

SELECT e.ID,
       e.[name],
       e.class,
       e.points,
       e.subjects,
       (SELECT TOP 1 [name] FROM exam WHERE subjects = e.subjects ORDER BY points DESC) AS best_student,
       (SELECT TOP 1 [name] FROM exam WHERE subjects = e.subjects ORDER BY points)      AS worst_student
FROM exam e
ORDER BY subjects, points DESC;

-- 14. Определить баллы для каждого ученика и разницу между лучшим и самым отстающим
-- по сравнению с рассматриваемым учеником для каждого класса

SELECT ID,
       [name],
       class,
       points,
       subjects,
       points - MAX(points) OVER (PARTITION BY class) as difference_with_best,
       points - MIN(points) OVER (PARTITION BY class) as difference_with_worst
FROM exam
ORDER BY class, points DESC;

-- 15. Определить разницу в процентах для каждого ученика между его результатом и
-- и лучшим результатом по его предмету

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

-- 16. Определить по каждому предмету сумму баллов и долю каждого ученика по отношению
-- к данной сумме по каждому предмету

SELECT ID,
       [name],
       class,
       points,
       subjects,
       SUM(points) OVER (PARTITION BY subjects)                    AS total_points,
       (points * 100.0 / SUM(points) OVER (PARTITION BY subjects)) AS contribution_percentage
FROM exam
ORDER BY subjects, points DESC;

-- 17. Определить по каждому классу сумму баллов и долю каждого ученика по отношению
-- к данной сумме по каждому классу

SELECT ID,
       [name],
       class,
       points,
       subjects,
       SUM(points) OVER (PARTITION BY class)                    AS total_points,
       (points * 100.0 / SUM(points) OVER (PARTITION BY class)) AS contribution_percentage
FROM exam
ORDER BY class, points DESC;

-- 18. Определить сколько учеников сдавало экзамен по каждому предмету,
-- средний балл по каждому предмету
-- отношение баллов каждого ученика к среднему баллу по каждому предмету

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

-- 19. БЕЗ ОКОННЫХ ФУНКЦИЙ. Определить сколько учеников сдавало экзамен по каждому предмету,
-- средний балл по каждому предмету
-- отношение баллов каждого ученика к среднему баллу по каждому предмету

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


-- 20. Определить доход и расход с нарастающим итогом

SELECT [Date],
       inmoney,
       outmoney,
       SUM(inmoney) OVER (ORDER BY [Date])  AS cumulative_income,
       SUM(outmoney) OVER (ORDER BY [Date]) AS cumulative_expense
FROM [money]
ORDER BY [Date];


-- 21. Определить разницу дохода с нарастающим итогом и расхода с нарастающим итогом

SELECT [Date],
       inmoney,
       outmoney,
       SUM(inmoney) OVER (ORDER BY [Date])                                        AS cumulative_income,
       SUM(outmoney) OVER (ORDER BY [Date])                                       AS cumulative_expense,
       SUM(inmoney) OVER (ORDER BY [Date]) - SUM(outmoney) OVER (ORDER BY [Date]) AS cumulative_difference
FROM [money]
ORDER BY [Date];

-- 22. Определить разницу дохода с нарастающим итогом и расхода с нарастающим итогом
-- для каждого года

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

-- 23. Определить среднее значение за каждые три года дохода и расхода

SELECT ((YEAR([Date]) - 1) / 3) * 3 + 1 AS start_year,
       ((YEAR([Date]) - 1) / 3) * 3 + 3 AS end_year,
       AVG(inmoney)                     AS avg_income,
       AVG(outmoney)                    AS avg_expense
FROM [money]
GROUP BY ((YEAR([Date]) - 1) / 3)
ORDER BY start_year;
