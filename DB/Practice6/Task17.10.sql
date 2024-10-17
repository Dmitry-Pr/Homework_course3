--1 Создать таблицы Workers , Events и Operations в соответствии с ER
-- диаграммой. Соответственно создаются первичные и внешние ключи
-- W_id - первичный ключ для Workers  , Op_id первичный ключ для
-- Operations, Ev_id первичный ключ для Events.
-- W_id и Op_id внешние (FOREIGN KEY) для таблицы Events, которые
-- ссылаются на таблицы Workers , Events и Operations


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

-- 2. Проверить вставку и удаление записей в таблицы
-- Events, Operations и Workers при наличии ограничений по
-- ссылочной целостности (наличия FOREIGN KEY) и без
-- ограничения по ссылочной целостности.

INSERT INTO Workers (W_id, lastname, firstname) VALUES (1, 'Ivanov', 'Ivan');
INSERT INTO Operations (Op_id, opname, cost) VALUES (1, 'Operation A', 100.00);
INSERT INTO Events (Ev_id, W_id, Op_id, [Date], Number) VALUES (1, 1, 1, '2024-01-01', 10);

-- Попробуем удалить запись из Workers, что вызовет ошибку, так как запись используется в Events
DELETE FROM Workers WHERE W_id = 1;  -- Это вызовет ошибку из-за FOREIGN KEY

-- Удалим ограничение ссылочной целостности и повторим удаление без них
ALTER TABLE Events NOCHECK CONSTRAINT FK__Events__W_id__4D94879B;

-- Теперь можно удалить запись без ошибок
DELETE FROM Workers WHERE W_id = 1;

-- Вернем ограничение
ALTER TABLE Events CHECK CONSTRAINT FK__Events__W_id__4D94879B;

-- 3. Создать ограничения для поля Number в таблице Events
-- как Check , больше нуля и меньше 300 и как default(20)
ALTER TABLE Events
ADD CONSTRAINT chk_number CHECK (Number > 0 AND Number < 300);

ALTER TABLE Events
ADD CONSTRAINT df_number DEFAULT 20 FOR Number;

-- 4. Создать таблицы и ограничения при помощи дизайнера
-- Создали таблицу Tools

-- 5. Добавить поле в таблицу Workers
ALTER TABLE Workers
ADD birthdate DATE;

-- 6. Добавить внешний ключ в таблицу Events

-- Создадим сначала поле
ALTER TABLE Events
ADD T_id INT;

-- Добавим внешний ключ
ALTER TABLE Events
ADD CONSTRAINT FK__Events__Tools FOREIGN KEY (T_id) REFERENCES Tools(T_id);

-- 7. Изменение типа колонки Number в таблице Events

-- Сначала уберем значения по умолчанию и ограничения
ALTER TABLE Events DROP CONSTRAINT df_number;
ALTER TABLE Events DROP CONSTRAINT chk_number;

-- Изменим тип
ALTER TABLE Events
ALTER COLUMN Number DECIMAL(5, 2);
