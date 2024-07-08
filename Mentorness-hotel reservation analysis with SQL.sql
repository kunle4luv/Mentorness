use hotel;
select * from hotel.reservation;
alter table reservation
add primary key (Booking_ID);
select count(Booking_ID) as Total_Reservation from hotel.reservation;
select distinct room_type_reserved from hotel.reservation;
select distinct market_segment_type from hotel.reservation;
select distinct booking_status from hotel.reservation;
describe hotel.reservation;
update hotel.reservation set arrival_date=str_to_date(arrival_date, "%d-%m-%Y");

ALTER TABLE hotel.reservation
modify arrival_date date;
update hotel.reservation
set arrival_date = str_to_date(arrival_date, "%Y-%m-%d");

# SQL Problem Statment For Mentorness Intership Program
# Question 1: What is the total number of reservations in the dataset?
SELECT COUNT(*) AS total_reservation FROM reservation;

#Question 2: Which meal plan is the most popular among guests?
select type_of_meal_plan as Most_Popular_Meal_Plan, count(Booking_ID) as count
from reservation
group by type_of_meal_plan
order by count desc
limit 1;

# Question 3: What is the average price per room for reservations involving children? 
SELECT round(avg(avg_price_per_room), 2) AS Average_Price_Per_Room_Involving_Children
FROM reservation
WHERE no_of_children > 0;

# Question 4: How many reservations were made for the year 20XX (replace XX with the desired year)?
# For the year 2018
select count(Booking_ID) as No_of_reservations_from_2018 from reservation
where year(arrival_date) = 2018;
# For the year 2017
select count(Booking_ID) as No_of_reservations_from_2017 from reservation
where year(arrival_date) = 2017;

# Question 5: What is the most commonly booked room type?
select room_type_reserved as Most_Commonly_Booked_Room, count(Booking_ID) as No_Of_Higest_Reservation
from reservation
group by room_type_reserved
Having count(Booking_ID) = (
select max(counts)
from (
select count(Booking_ID) as counts
from reservation
group by room_type_reserved
) as sortedreservation
);

# Question 6: How many reservations fall on a weekend (no_of_weekend_nights > 0)?
select count(*) as No_of_reservations_that_fall_on_a_weekend 
from reservation
where no_of_weekend_nights > 0;

# Question 7: What is the highest and lowest lead time for reservations?
select max(lead_time) as Highest_Lead_Time_for_Reservation, min(lead_time) as lowest_Lead_Time_for_Reservation
from reservation;

# Question 8: What is the most common market segment type for reservations?
select market_segment_type as Most_Common_Segment_Type, count(*) as counts
from reservation
group by market_segment_type
order by counts desc
limit 1;

# Question 9: How many reservations have a booking status of "Confirmed"?
select count(*) as Reservation_being_Confirmed 
from reservation 
where booking_status = "Not_Canceled";

# Question 10: What is the total number of adults and children across all reservations?
select sum(no_of_adults) as Total_number_of_adults, sum(no_of_children) as Total_number_of_children
from reservation;

# Question 11: What is the average number of weekend nights for reservations involving children?
select round(avg(no_of_weekend_nights)) as Average_no_of_Weekend_Night_Involving_Children
from reservation
where no_of_children > 0;

# Question 12: How many reservations were made in each month of the year?
SELECT YEAR(arrival_date) AS YEARS,MONTHNAME(arrival_date) AS Months,COUNT(*) AS count
FROM reservation
WHERE YEAR(arrival_date) IN (2017, 2018)
GROUP BY YEARS, MONTH(arrival_date),Months
ORDER BY YEARS, MONTH(arrival_date);


# Question 13: What is the average number of nights (both weekend and weekday) spent by guests for each room type?
select room_type_reserved, round(avg(no_of_week_nights + no_of_weekend_nights)) as Average_Number_of_Nights
from reservation
group by room_type_reserved;

# Question 14: For reservations involving children, what is the most common room type, and what is the average price for that room type?
select room_type_reserved, round(avg(avg_price_per_room), 2) as Average_price, count(*) as counts 
from reservation
where no_of_children > 0
group by room_type_reserved
order by counts desc
limit 1;

# Question 15: Find the market segment type that generates the highest average price per room.
select market_segment_type, round(avg(avg_price_per_room), 2) as Highest_Average_Price_Per_Room
from reservation
group by market_segment_type
order by Highest_Average_Price_Per_Room desc
limit 1;


