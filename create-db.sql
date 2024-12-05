drop table crew_staff;
drop table crew;
drop table operates_flights;
drop table flies_to_from;
drop table airport;
drop table city;
drop table employee;
drop table airline;


create table airline (
id serial primary key,
name text,
icao_code varchar(5),
iata_code varchar(5)
);

create table employee (
id serial primary key,
name text,
title text,
start_date timestamp,
retire_date timestamp,
years_experience integer,
airline_id integer
);

create table crew (
id serial primary key,
name text,
operates_flights_id integer
);

create table crew_staff (
role text,
crew_id integer,
employee_id integer
);

create table city (
id serial primary key,
name text,
country text,
population integer,
time_zone varchar(100)
);

create table airport (
id serial primary key,
name text,
iata_code varchar(5),
is_international boolean,
terminal_count integer,
gate_count integer,
city_id integer
);

create table flies_to_from (
flight_num varchar(10) primary key,
depart_airport_id integer,
arrive_airport_id integer,
codeshare text,
days_sched text,
depart_time_sched time,
arrive_time_sched time,
airline_id integer
);

create table operates_flights (
id serial primary key,
departed_day_time timestamptz,
arrived_day_time timestamptz,
revenue integer,
cost integer,
fuel_amount_start integer,
fuel_amount_end integer,
accident_occurred boolean,
flight_num varchar(10)
);



alter table employee add foreign key (airline_id) references airline(id);
alter table crew_staff add foreign key (employee_id) references employee(id);
alter table airport add foreign key (city_id) references city(id);
alter table flies_to_from 
add foreign key (depart_airport_id) references airport(id), 
add foreign key (arrive_airport_id) references airport(id),
add foreign key (airline_id) references airline(id);
alter table operates_flights add foreign key (flight_num) references flies_to_from(flight_num);
alter table crew add foreign key (operates_flights_id) references operates_flights(id);



insert into airline (name, icao_code, iata_code) values ('Delta', 'DL', 'DL');

insert into city (name, country, population, time_zone) values ('Portland', 'USA', 2500000, 'Pacific');
insert into city (name, country, population, time_zone) values ('Amsterdam', 'Netherlands', 2500000, 'Europe/Amsterdam');

insert into airport (name, iata_code, is_international, terminal_count, gate_count)
values ('Portland International Airport', 'PDX', 'T', 4, 25);
insert into airport (name, iata_code, is_international, terminal_count, gate_count)
values ('Schiphol International Airport', 'AMS', 'T', 8, 50);


insert into employee (name, title, start_date, years_experience, airline_id)
values ('Bob', 'Flight Attendant', '2024-01-01', 1, 1);
insert into employee (name, title, start_date, years_experience, airline_id)
values ('Jane', 'Flight Attendant', '2024-01-01', 1, 1);
insert into employee (name, title, start_date, years_experience, airline_id)
values ('Barbara', 'Pilot', '2010-01-01', 20, 1);
insert into employee (name, title, start_date, years_experience, airline_id)
values ('Joe', 'Pilot', '2020-01-01', 10, 1);

insert into crew (name) values ('crew1');

insert into crew_staff (role, crew_id, employee_id) values ('FA', 1, 1);
insert into crew_staff (role, crew_id, employee_id) values ('FA', 1, 2);
insert into crew_staff (role, crew_id, employee_id) values ('Pilot', 1, 3);
insert into crew_staff (role, crew_id, employee_id) values ('Pilot', 1, 4);

insert into flies_to_from (flight_num, depart_airport_id, arrive_airport_id, codeshare, days_sched, depart_time_sched, arrive_time_sched, airline_id)
values ('DAL145', 1, 2, 'KLM145', 'MTWRF', '14:00:00', '10:00:00', 1);
