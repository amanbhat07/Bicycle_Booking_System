-- procedures
use cycle_booking;

-- 1. Which customer has spent the most money?
delimiter $$
create procedure topSpender()
begin
	select c.*, sum(r.cost) as totalSpent from customers c
    join ride r
    on c.customer_id = r.customer_id
    group by c.customer_id
    order by totalSpent desc
    limit 1;
end $$
delimiter ;

-- 2. Which location sees a lot of traffic?
delimiter $$
create procedure mostTraffic()
begin
	select l.location_name, count(*) as most_visits
    from location l
    join ride r
    on l.location_id = r.start_location_id or l.location_id = r.end_location_id
    group by l.location_id
    order by most_visits desc
    limit 1;
end $$
delimiter ;

drop procedure if exists rideHistory;
-- What is the ride history of the specific customer?
delimiter $$
create procedure rideHistory(in cid int)
begin
	select r.*, s.location_name as Start_Location , e.location_name as End_Location, b.bike_name
    from ride r
    join location s on r.start_location_id = s.location_id
    join location e on r.end_location_id = e.location_id
    join bikes b on r.bike_id = b.bike_id
    where r.customer_id = cid
    order by start_time desc;
end $$
delimiter ;

-- Which bikes are in need of inspection?
delimiter $$
create procedure inspectionNeeded()
begin
	select * from bikes
    where last_inspected <= date_sub(curdate(), interval 3 month);
end $$
delimiter ;

-- Which bike has been driven the most in terms of KM travelled?
delimiter $$
create procedure mostDrivenBike()
begin
	select * from bikes
    order by total_ride desc
    limit 1;
end $$
delimiter ;

-- procedure to get list of bikes available from the starting location
delimiter $$
create procedure showBikes(in loc_id int)
begin
	select * from bikes where bike_location_id = loc_id;
end $$
delimiter ;

select * from customers;
select * from ride;
select * from location;
select * from bikes;

call topSpender();
call mostDrivenBike();
call inspectionNeeded();
call rideHistory(1);
call showBikes(1);