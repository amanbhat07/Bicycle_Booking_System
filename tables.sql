-- Creating new Database for the Project (Online Cycle Booking)
create database cycle_booking;
use cycle_booking;
-- Create tables in the database for Customers, Bikes, Location and Ride

-- customers table
create table customers
(customer_id int primary key auto_increment,
customer_name varchar(30),
email varchar(30),
phone varchar(15));

-- bikes table
create table bikes
(bike_id int primary key,
bike_name varchar(30),
total_ride float default 0,
last_inspected date);

alter table bikes add column bike_location_id int;
alter table bikes add constraint fk_bike_location foreign key (bike_location_id) references location(location_id);
desc bikes;

-- location table
create table location
(location_id int primary key,
location_name varchar(30));

-- ride table
create table ride
(ride_id int primary key,
customer_id int,
bike_id int,
start_location_id int,
end_location_id int,
start_time datetime,
end_time datetime,
distance_covered float,
cost decimal(10,2),
FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
FOREIGN KEY (bike_id) REFERENCES bikes(bike_id),
FOREIGN KEY (start_location_id) REFERENCES location(location_id),
FOREIGN KEY (end_location_id) REFERENCES location(location_id));

-- Insert sample data into the tables

-- Insert in customers table
insert into customers (customer_name, email, phone) values
("Ankit Sharma","ankit@gmail.com","9878677899"),
("Shubman Gill","shubhman@gmail.com","7889675678"),
("Rohit Sharma","rohit@hotmail.com","8765745363"),
("Virat Kohli","virat@gmail.cpm","7867562313"),
("Sunil Chetri","sunil@gmail.com","8064532314");

-- insert in location table
insert into location values
(1,"kharghar"),
(2,"belapur"),
(3,"seawood");

-- Insert in bikes table
insert into bikes values
(101,"Hero Sprint Pro",57,"2025-05-20",1),
(102,"Avon Smart Ride",23,"2025-05-20",1),
(103,"Hero Sprint Pro",57,"2025-05-20",2),
(104,"Mach City iBike",0,"2025-04-02",3),
(105,"Schnell Climber",44,"2025-03-24",2),
(106,"Btwin Rockrider ST 100",57,"2025-01-10",3),
(107,"Firefox Urban Eco",63,"2025-04-12",2),
(108,"Firefox Urban Eco",0,"2025-05-01",1);

-- Insert into ride table
insert into ride values(1101, 1, 101, 1, 2, '2025-05-01 10:00', '2025-05-01 10:45', 12.5, 75);
delete from ride where ride_id = 1102;

update bikes
set bike_location_id = 1
where bike_id = 102;

select * from bikes;
select * from ride;
desc ride;

-- insert into ride values(1103, 1, 101, 1, 2, '2025-05-01 10:00', '2025-05-01 10:45', 12.5, 75); -> bike not available at current location case
-- insert into ride values(1103, 1, 106, 3, 2, '2025-05-01 01:00', '2025-05-01 01:45', 12.5, 75); -> exeception error case