# Practice 5 по базам данных

## Работу выполнил

Мухин Дмитрий БПИ228


Для работы поднял образ mssql в докере и запросы писал в PyCharm (там же подключился к бд)

## Task 1 (из файла)

#### -- 1. Создать таблицы Workers , Events и Operations в соответствии с ER
-- диаграммой. Соответственно создаются первичные и внешние ключи
-- W_id - первичный ключ для Workers  , Op_id первичный ключ для
-- Operations, Ev_id первичный ключ для Events.
-- W_id и Op_id внешние (FOREIGN KEY) для таблицы Events, которые
-- ссылаются на таблицы Workers , Events и Operations

```
CREATE TABLE Workers (
    W_id INT PRIMARY KEY,
    lastname VARCHAR(50),
    firstname VARCHAR(50)
);

CREATE TABLE Operations (
    Op_id INT PRIMARY KEY,
    opname VARCHAR(50),
    cost DECIMAL(10, 2)
);

CREATE TABLE Events (
    Ev_id INT PRIMARY KEY,
    W_id INT FOREIGN KEY REFERENCES Workers(W_id),  -- Ограничение FOREIGN KEY
    Op_id INT FOREIGN KEY REFERENCES Operations(Op_id),  -- Ограничение FOREIGN KEY
    [Date] DATE,
    Number INT
);
```
![image](https://github.com/user-attachments/assets/2d341ede-67f3-4ad8-b24a-b6fa42cb684a)

Создаем таблицы из задания, с помощью Foreign key задаем внешние ключи в таблице Events

#### -- 2. Проверить вставку и удаление записей в таблицы
```
-- Events, Operations и Workers при наличии ограничений по

-- ссылочной целостности (наличия FOREIGN KEY) и без

-- ограничения по ссылочной целостности.

INSERT INTO Workers (W_id, lastname, firstname) VALUES (1, 'Ivanov', 'Ivan');

INSERT INTO Operations (Op_id, opname, cost) VALUES (1, 'Operation A', 100.00);

INSERT INTO Events (Ev_id, W_id, Op_id, [Date], Number) VALUES (1, 1, 1, '2024-01-01', 10);
```
![image](https://github.com/user-attachments/assets/f4dfd934-6d85-40f5-8ee7-27396c8bf55f)


![image](https://github.com/user-attachments/assets/fdec0f39-12e4-4d5c-b669-56555b5c3557)

![image](https://github.com/user-attachments/assets/a7dc686c-b70b-452d-92f7-67165a953b77)

Вставили значения, все появилось в таблицах

-- Попробуем удалить запись из Workers, что вызовет ошибку, так как запись используется в Events
```
DELETE FROM Workers WHERE W_id = 1;  -- Это вызовет ошибку из-за FOREIGN KEY
```
![image](https://github.com/user-attachments/assets/53a8f7ac-349f-4a52-8926-75883c24e560)
```
-- Удалим ограничение ссылочной целостности и повторим удаление без них

ALTER TABLE Events NOCHECK CONSTRAINT FK__Events__W_id__4D94879B;

-- Теперь можно удалить запись без ошибок

DELETE FROM Workers WHERE W_id = 1;
```
![image](https://github.com/user-attachments/assets/e00e527b-af12-4a7d-928f-740f57fc2948)

Убрали ограничение и получилось удалить
```
-- Вернем ограничение

ALTER TABLE Events CHECK CONSTRAINT FK__Events__W_id__4D94879B;
```
#### -- 3. Создать ограничения для поля Number в таблице Events
```
-- как Check , больше нуля и меньше 300 и как default(20)

ALTER TABLE Events

ADD CONSTRAINT chk_number CHECK (Number > 0 AND Number < 300);

ALTER TABLE Events

ADD CONSTRAINT df_number DEFAULT 20 FOR Number;
```
![image](https://github.com/user-attachments/assets/fc43ec43-80fe-4274-8588-b818da267c0a)

Видим, что создалось одно дефолтное значение и одна проверка

#### -- 4. Создать таблицы и ограничения при помощи дизайнера
```
-- Создали таблицу Tools
```
![image](https://github.com/user-attachments/assets/3ca2b735-9999-406f-99b1-7c862f7863d1)

#### -- 5. Добавить поле в таблицу Workers
```
ALTER TABLE Workers

ADD birthdate DATE;
```
![image](https://github.com/user-attachments/assets/0dde45ca-922c-4e7a-a4fa-770167891263)

Поле появилось

#### -- 6. Добавить внешний ключ в таблицу Events
```
-- Создадим сначала поле

ALTER TABLE Events

ADD T_id INT;

-- Добавим внешний ключ

ALTER TABLE Events

ADD CONSTRAINT FK__Events__Tools FOREIGN KEY (T_id) REFERENCES Tools(T_id);
```
![image](https://github.com/user-attachments/assets/739d74a9-b53f-482a-8ca8-6c39f508bc9f)


#### -- 7. Изменение типа колонки Number в таблице Events
```
-- Сначала уберем значения по умолчанию и ограничения

ALTER TABLE Events DROP CONSTRAINT df_number;

ALTER TABLE Events DROP CONSTRAINT chk_number;

-- Изменим тип

ALTER TABLE Events

ALTER COLUMN Number DECIMAL(5, 2);
```
![image](https://github.com/user-attachments/assets/8ceeee3b-caff-419a-9169-3a16e32e1ec4)

Видно, что значение поменялось

## Task 2

```
-- Создание таблиц groups и students
CREATE TABLE groups
(
  gr_id INT PRIMARY KEY,
  groupname VARCHAR(30)
);

CREATE TABLE students
(
  st_id INT PRIMARY KEY,
  gr_id INT,
  lastname VARCHAR(30),
  firstname VARCHAR(30),
  ticketnumber INT,
  FOREIGN KEY (gr_id) REFERENCES groups (gr_id)
);

-- Создание таблиц Subjects и StudentSubject
CREATE TABLE Subjects
(
  s_id INT PRIMARY KEY,
  subjectname VARCHAR(50)
);

CREATE TABLE StudentSubject
(
  st_id INT,
  s_id INT,
  PRIMARY KEY (st_id, s_id),
  FOREIGN KEY (st_id) REFERENCES students (st_id),
  FOREIGN KEY (s_id) REFERENCES Subjects (s_id)
);
```

![image](https://github.com/user-attachments/assets/739c9077-478b-431e-89f1-1148d3eab99a)

Создалось 4 таблички

```
-- Пример вставки данных
INSERT INTO groups (gr_id, groupname) VALUES (1, 'Group A');
INSERT INTO students (st_id, gr_id, lastname, firstname, ticketnumber)
VALUES (1, 1, 'Smith', 'John', 12345);

INSERT INTO Subjects (s_id, subjectname) VALUES (1, 'Math');
INSERT INTO StudentSubject (st_id, s_id) VALUES (1, 1);
```

![image](https://github.com/user-attachments/assets/922e7de9-1d38-45b2-a5f3-360f4d9521a3)

![image](https://github.com/user-attachments/assets/4c526fa2-5ee8-480c-9558-e4ddd1516099)

![image](https://github.com/user-attachments/assets/cd8c3868-1bf0-4947-90f6-94d7f8e6c083)

![image](https://github.com/user-attachments/assets/be3b300f-a95a-4b2f-b929-a6650c7ac60a)

```
-- Пример удаления данных
DELETE FROM StudentSubject WHERE st_id = 1 AND s_id = 1;
DELETE FROM Subjects WHERE s_id = 1;
```

![image](https://github.com/user-attachments/assets/c7f6c98c-a379-46a4-b79d-7ace0c6824d6)
![image](https://github.com/user-attachments/assets/53be04cb-82cf-47e6-b584-c0a50bd16ae4)

Все как обычно вставилось и удалилось, как надо

```
-- Зададим каскадное удаление для связанных записей
ALTER TABLE students
ADD CONSTRAINT students_gr_id_fkey
FOREIGN KEY (gr_id) REFERENCES groups (gr_id)
ON DELETE CASCADE;

-- Теперь удаление группы будет автоматически удалять всех студентов, связанных с этой группой.

DELETE FROM groups WHERE gr_id = 1;
```

![image](https://github.com/user-attachments/assets/742b4dd9-9b6f-4480-b3ad-7e5642efdd46)
![image](https://github.com/user-attachments/assets/8f33876d-4576-4841-bfec-9f321b763f1b)

Студент, связанный с этой группой тоже удалился
