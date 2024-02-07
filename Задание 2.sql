--Задание 2 - заполнение базы
Truncate table accomodation RESTART IDENTITY cascade ;
Truncate table kind RESTART IDENTITY cascade;
Truncate table room RESTART IDENTITY cascade;
Truncate table habitat RESTART IDENTITY cascade;
Truncate table family RESTART IDENTITY cascade;
Truncate table complex RESTART IDENTITY cascade;

INSERT INTO complex (complex_name) VALUES
    ('Комплекс 1'),
    ('Комплекс 2'),
    ('Комплекс 3');
	
INSERT INTO family (family_name) VALUES
    ('Семейство 1'),
    ('Семейство 2'),
    ('Семейство 3');

INSERT INTO habitat (habitat_name) VALUES
    ('Среда обитания 1'),
    ('Среда обитания 2'),
    ('Среда обитания 3'),
	('Среда обитания 4');
	
INSERT INTO room (square, water, complex_id_fk) VALUES
    (100, true, 1),
    (200, false, 2),
    (150, true, 3),
	(200, false, 2),
	(100, true, 2);

INSERT INTO kind (kind_name, kind_life_duration, habitat_id_fk, family_id_fk) VALUES
    ('Вид 1', 10, 1, 1),
    ('Вид 2', 5, 2, 2),
    ('Вид 3', 15, 2, 1),
	('Вид 4', 3, 4, 2),
	('Вид 5', 30, 3, 3);

INSERT INTO accomodation (accomodation_count, room_id_fk, kind_id_fk) VALUES
    (5, 1, 1),
    (10, 2, 2),
    (3, 3, 5),
	(5, 1, 3),
	(5, 2, 4);
