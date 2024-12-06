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
flight_num varchar(10),
crew_id integer
);



alter table employee add foreign key (airline_id) references airline(id);
alter table crew_staff add foreign key (employee_id) references employee(id);
alter table airport add foreign key (city_id) references city(id);
alter table flies_to_from 
add foreign key (depart_airport_id) references airport(id), 
add foreign key (arrive_airport_id) references airport(id),
add foreign key (airline_id) references airline(id);
alter table operates_flights add foreign key (flight_num) references flies_to_from(flight_num);
alter table operates_flights add foreign key (crew_id) references crew(id);
alter table crew add foreign key (operates_flights_id) references operates_flights(id);



insert into employee (name, title, start_date, years_experience, airline_id)
select 'Bob', 'Flight Attendant', '2024-01-01', 1, id 
from airline where name = 'Delta Air Lines';
	   
insert into employee (name, title, start_date, years_experience, airline_id)
select 'Jane', 'Flight Attendant', '2024-01-01', 1, id 
from airline where name = 'Delta Air Lines';

insert into employee (name, title, start_date, years_experience, airline_id)
select 'Barbara', 'Pilot', '2010-01-01', 20, id 
from airline where name = 'Delta Air Lines';

insert into employee (name, title, start_date, years_experience, airline_id)
select 'Joe', 'Pilot', '2020-01-01', 10, id 
from airline where name = 'Delta Air Lines';

insert into crew (name) values ('crew1');

insert into crew_staff (role, crew_id, employee_id) 
select 'FA', 1, id
from employee where name = 'Bob';

insert into crew_staff (role, crew_id, employee_id) 
select 'FA', 1, id
from employee where name = 'Jane';

insert into crew_staff (role, crew_id, employee_id)
select 'Pilot', 1, id
from employee where name = 'Barbara';

insert into crew_staff (role, crew_id, employee_id)
select 'Pilot', 1, id
from employee where name = 'Joe';

insert into flies_to_from (flight_num, depart_airport_id, arrive_airport_id, codeshare, days_sched, depart_time_sched, arrive_time_sched, airline_id)
select 'DAL145', 1442, 1682, 'KLM145', 'MTWRF', '13:00:00', '18:30:00', id
from airline where name = 'Delta Air Lines';

insert into operates_flights (departed_day_time, arrived_day_time, revenue, cost, fuel_amount_start, fuel_amount_end, flight_num, crew_id)
values ('2024-05-05 13:00:00', '2024-05-05 18:30:00', 1000000, 775000, 20000, 8500, 'DAL145', 1);

insert into operates_flights (departed_day_time, arrived_day_time, revenue, cost, fuel_amount_start, fuel_amount_end, flight_num, crew_id)
values ('2024-05-06 13:00:00', '2024-05-06 18:17:00', 800000, 500000, 20000, 8500, 'DAL145', 1);

insert into operates_flights (departed_day_time, arrived_day_time, revenue, cost, fuel_amount_start, fuel_amount_end, flight_num, crew_id)
values ('2024-05-07 13:00:00', '2024-05-07 18:22:00', 1500000, 975000, 20000, 3500, 'DAL145', 1);

insert into operates_flights (departed_day_time, arrived_day_time, revenue, cost, fuel_amount_start, fuel_amount_end, flight_num, crew_id)
values ('2024-05-08 14:30:00', '2024-05-08 20:32:00', 500000, 275000, 20000, 4500, 'DAL145', 1);

insert into operates_flights (departed_day_time, arrived_day_time, revenue, cost, fuel_amount_start, fuel_amount_end, flight_num, crew_id)
values ('2024-05-09 13:00:00', '2024-05-09 18:30:00', 1300000, 975000, 20000, 6500, 'DAL145', 1);
