--Задание 1 - база данных «Зоопарк»
create table if not exists complex
(
    complex_id   serial
        primary key,
    complex_name name not null
);

alter table complex
    owner to postgres;

create table if not exists family
(
    family_id   serial
        primary key,
    family_name name not null
);

alter table family
    owner to postgres;

create table if not exists habitat
(
    habitat_id   serial
        primary key,
    habitat_name name not null
);

alter table habitat
    owner to postgres;

create table if not exists room
(
    room_id       serial
        primary key,
    square        integer not null,
    water         boolean,
    complex_id_fk integer not null
        constraint complex_id_fk
            references complex
);

alter table room
    owner to postgres;

create table if not exists kind
(
    kind_id            serial
        primary key,
    kind_life_duration integer not null,
    habitat_id_fk      integer not null
        constraint habitat_id_fk
            references habitat,
    family_id_fk       integer not null
        constraint family_id_fk
            references family,
    kind_name          name    not null
);

alter table kind
    owner to postgres;

create table if not exists accomodation
(
    accomodation_id    serial
        primary key,
    accomodation_count integer,
    room_id_fk         integer not null
        constraint room_id_fk
            references room,
    kind_id_fk         integer not null
        constraint kind_id_fk
            references kind
);

alter table accomodation
    owner to postgres;
