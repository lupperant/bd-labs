--Задание 3 - запросы к базе
--1. Получить список всех животных, которые находятся в конкретном помещении:

SELECT kind.kind_name, accomodation.accomodation_count
FROM kind
JOIN accomodation ON kind.kind_id = accomodation.kind_id_fk
JOIN room ON accomodation.room_id_fk = room.room_id
WHERE room.room_id = <id_помещения>;


--2. Получить список всех животных, которые относятся к определенному виду:

SELECT kind.kind_name, family.family_name, habitat.habitat_name
FROM kind
JOIN family ON kind.family_id_fk = family.family_id
JOIN habitat ON kind.habitat_id_fk = habitat.habitat_id
WHERE kind.kind_name = '<название_вида>';


--3. Получить список всех видов животных и их среднюю продолжительность жизни в каждом местообитании:

SELECT kind_name, habitat_name, kind_life_duration, AVG(kind_life_duration) OVER (PARTITION BY habitat_id_fk) AS avg_life_duration
FROM kind
JOIN habitat ON kind.habitat_id_fk = habitat.habitat_id;

--4. Получить список всех вольеров, в которых есть вода:

WITH cte_water_rooms AS (
  SELECT *
  FROM room
  WHERE water = true
)
SELECT *
FROM cte_water_rooms;

--5. Вставка данных в таблицы «complex» и «room»:

WITH complex_insert AS (
  INSERT INTO complex (complex_name)
  VALUES ('Zoo Complex')
  RETURNING complex_id
)
INSERT INTO room (square, water, complex_id_fk)
VALUES (100, true, (SELECT complex_id FROM complex_insert));

--6. Вставка данных в таблицы «family» и «habitat»:

WITH family_insert AS (
  INSERT INTO family (family_name)
  VALUES ('Felidae')
  RETURNING family_id
), habitat_insert AS (
  INSERT INTO habitat (habitat_name)
  VALUES ('Jungle')
  RETURNING habitat_id
)
INSERT INTO kind (kind_life_duration, habitat_id_fk, family_id_fk, kind_name)
VALUES (10, (SELECT habitat_id FROM habitat_insert), (SELECT family_id FROM family_insert), 'Tiger');

--7. Увеличить площадь всех комнат в комплексе "Комплекс 2" на 10, если в комнате нет воды, в ней содержится более одного животного из семейства "Вид 1" с продолжительностью жизни более 2 лет.
UPDATE room
SET square = square + 10
WHERE complex_id_fk = (
    SELECT complex_id
    FROM complex
    WHERE complex_name = ‘Комплекс 1’
)
AND water = false
AND room_id IN (
    SELECT room_id_fk
    FROM accomodation
    WHERE kind_id_fk IN (
        SELECT kind_id
        FROM kind
        WHERE family_id_fk = (
            SELECT family_id
            FROM family
            WHERE family_name = 'Вид 1'
        )
        AND kind_life_duration > 2
    )
    GROUP BY room_id_fk
    HAVING COUNT(*) > 1
);

--8. Обновить данные в таблицах room, kind и accomodation
WITH room_update AS (
  UPDATE room
  SET square = 100, water = false
  WHERE room_id = 2
  RETURNING room_id
), kind_update AS (
  UPDATE kind
  SET kind_life_duration = 8, kind_name = 'New Penguin Kind Name'
  WHERE kind_id = 2
  RETURNING kind_id
)
UPDATE accomodation
SET accomodation_count = 15
WHERE room_id_fk = (SELECT room_id FROM room_update) AND kind_id_fk = (SELECT kind_id FROM kind_update);
