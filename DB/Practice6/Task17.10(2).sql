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

-- Пример вставки данных
INSERT INTO groups (gr_id, groupname) VALUES (1, 'Group A');
INSERT INTO students (st_id, gr_id, lastname, firstname, ticketnumber)
VALUES (1, 1, 'Smith', 'John', 12345);

INSERT INTO Subjects (s_id, subjectname) VALUES (1, 'Math');
INSERT INTO StudentSubject (st_id, s_id) VALUES (1, 1);

-- Пример удаления данных
DELETE FROM StudentSubject WHERE st_id = 1 AND s_id = 1;
DELETE FROM Subjects WHERE s_id = 1;

-- Зададим каскадное удаление для связанных записей
ALTER TABLE students
ADD CONSTRAINT students_gr_id_fkey
FOREIGN KEY (gr_id) REFERENCES groups (gr_id)
ON DELETE CASCADE;

-- Теперь удаление группы будет автоматически удалять всех студентов, связанных с этой группой.

DELETE FROM groups WHERE gr_id = 1;
