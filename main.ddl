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
	
CREATE TABLE dwh_ryazan.dim_drivers(
	personnel_num serial,
	last_name varchar(20),
	first_name varchar(20).
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