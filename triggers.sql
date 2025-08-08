-- triggers

-- to update the total_distance of the bike and
-- update the bike location after the ride
use cycle_booking;
drop trigger if exists updateBike;
delimiter $$
create trigger updateBike
after insert on ride
for each row
begin
	-- update total_distance of the bike
	update bikes
    set total_ride = total_ride + new.distance_covered
    where bike_id = new.bike_id;
    
    -- update new location of the bike
    update bikes
    set bike_location_id = new.end_location_id
    where bike_id = new.bike_id;
end $$
delimiter ;

-- trigger
-- to check whether the bike is inspected or not and is available at that location or not
drop trigger if exists checkInspection;
delimiter $$
create trigger checkInspection
before insert on ride
for each row
begin
	declare bike_location int;
    declare bike_inspected_date date;
    
	select bike_location_id into bike_location from bikes where bike_id = new.bike_id;
    
	-- check if the bike is available at this location or not
    if bike_location != new.start_location_id then
		signal sqlstate '45000' -- raises a serious error
        set message_text = "This Bike is not available at this location"; -- with this message
	end if;
    
    select last_inspected into bike_inspected_date from bikes where bike_id = new.bike_id;
    
    -- check if the bike is inspected or not
    if bike_inspected_date < date_sub(cast(new.start_time as date), interval 3 month) then
		signal sqlstate '45000' -- raises a serious error
        set message_text = "This Bike needs inspection."; -- with this message
	end if;
end $$