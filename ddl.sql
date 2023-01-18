-----------------------------------------
-----------------------------------------
-----------------------------------------
-- Создание фактовой таблицы "Поездки" --
-----------------------------------------
create table dwh_ryazan.fact_rides(
	ride_id integer not null,
	point_from_txt varchar(200),
	point_to_txt varchar(200),
	distance_val NUMERIC(5, 2),
	price_amt numeric(7, 2),
	client_phone_num char(18),
	driver_pers_num integer,
	car_plate_num char(9),
	ride_arrival_dt timestamp(0),
	ride_start_dt timestamp(0),
	ride_end_dt timestamp(0),
	processed_dt timestamp(0)
	);
	
-----------------------------------------------
-- Создание фактовой таблицы "Путевые листы" --
-----------------------------------------------
create table dwh_ryazan.fact_waybills(
	waybill_num varchar(10),
	driver_pers_num integer,
	car_plate_num char(9),
	work_start_dt timestamp(0),
	work_end_dt timestamp(0),
	issue_dt timestamp(0),
	processed_dt timestamp(0)
	);
	
-----------------------------------------
-- Создание фактовой таблицы "Платежи" --
-----------------------------------------
create table dwh_ryazan.fact_payments(
	transaction_id serial,
	card_num char(16),
	transaction_amt numeric(7,2),
	transaction_dt timestamp(0),
	processed_dt timestamp(0)
	);

-----------------------------------
-----------------------------------
-----------------------------------
-- Создание измерения "Водители" --
-----------------------------------
CREATE TABLE dwh_ryazan.dim_drivers(
	personnel_num serial,
	last_name varchar(20),
	first_name varchar(20),
	middle_name varchar(20),
	birth_dt date,
	card_num char(19),
	driver_license_num char(12),
	driver_license_dt date,
	deleted_flag char(1),
	start_dt TIMESTAMP(0),
	end_dt timestamp(0),
	processed_dt timestamp(0)
	);

-- Создание стейджинга "Водители" --
-- Источник - база данных "taxi"
CREATE TABLE dwh_ryazan.stg_drivers (
	driver_license char(12),
	first_name varchar(20),
	last_name varchar(20),
	middle_name varchar(20),
	driver_valid_to date,
	card_num char(19),
	update_dt timestamp(0),
	birth_dt date
    );

-- Создание удалений "Водители" --
-- Источник - база данных "taxi"
CREATE TABLE dwh_ryazan.stg_drivers_del (
	driver_license char(12)
    );

-- Создание мета-данных "Водители"
create table dwh_ryazan.meta_drivers (
    max_update_dt timestamp(0)
);

insert into dwh_ryazan.meta_drivers(max_update_dt)
values (to_timestamp('1900-01-01', 'YYYY-MM-DD'));

---------------------------------
-- Создание измерения "Машины" --
---------------------------------
CREATE TABLE dwh_ryazan.dim_cars(
	plate_num char(9),
	model_name varchar(30),
	revision_dt date,
	deleted_flag char(1),
	start_dt timestamp(0),
	end_dt timestamp(0),
	processed_dt timestamp(0)
	);

-- Создание стейджинга "Машины" --
-- Источник - база данных "taxi"
CREATE TABLE dwh_ryazan.stg_car_pool (
	plate_num char(9),
	model varchar(30),
	revision_dt date,
	register_dt date,
	finished_flg char(1),
	update_dt timestamp(0)
    );

-- Создание удалений "Машины" --
-- Источник - база данных "taxi"
CREATE TABLE dwh_ryazan.stg_car_pool_del (
	plate_num char(9)
    );
	
---------------------------------
-- Создание измерения "Клиенты" --
---------------------------------
create table dwh_ryazan.dim_clients(
	phone_num char(18),
	card_num char(20),
	deleted_flag char(1),
	start_dt timestamp(0),
	end_dt timestamp(0),
	processed_dt timestamp(0)
	);

-- Создание стейджинга "Клиенты" --
-- Источник - база данных "bank"
CREATE TABLE dwh_ryazan.stg_clients (
	client_id varchar(10),
	last_name varchar(20),
	first_name varchar(20),
	patronymic varchar(20),
	date_of_birth date,
	passport_num varchar(15),
	passport_valid_to date,
	phone char(16),
	create_dt timestamp(0),
	update_dt timestamp(0)
    );

-- Создание стейджинга "Карты" --
-- Источник - база данных "bank"
CREATE TABLE dwh_ryazan.stg_cards (
	card_num char(20),
	account char(20),
	create_dt timestamp(0),
	update_dt timestamp(0)
    );
	

----------------------------------------
----------------------------------------
----------------------------------------
-- Создание стейджинга "Передвижения" --
----------------------------------------
-- Источник - база данных "taxi"
CREATE TABLE dwh_ryazan.stg_movement (
	movement_id integer,
	car_plate_num char(9),
	ride integer,
	event varchar(6),
	dt timestamp(0) 
    );

-----------------------------------
-- Создание стейджинга "Поездки" --
-----------------------------------
-- Источник - база данных "taxi"
CREATE TABLE dwh_ryazan.stg_rides (
	ride_id integer,
	dt timestamp(0),
	client_phone char(18),
	card_num char(19),
	point_from varchar(200),
	point_to varchar(200),
	distance numeric(5, 2),
	price numeric(7, 2) 
    );