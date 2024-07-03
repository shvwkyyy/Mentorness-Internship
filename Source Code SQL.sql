SELECT *
FROM Mness
--TASK 1
SELECT COUNT(room_type_reserved) AS 'total number of reservations'
FROM Mness
--TASK 2
SELECT type_of_meal_plan, COUNT(type_of_meal_plan) AS 'Number of meal plan'
FROM Mness
GROUP BY type_of_meal_plan
ORDER BY COUNT(type_of_meal_plan) DESC

--TASK 3
SELECT no_of_children, AVG(avg_price_per_room) AS 'Average price'
FROM Mness
WHERE no_of_children <> 0
GROUP BY no_of_children
ORDER BY AVG(avg_price_per_room) DESC

--TASK 4
SELECT COUNT(*) AS 'Number of reservation per year'
FROM Mness
WHERE arrival_date BETWEEN '2018-01-01' AND '2018-12-31'

SELECT COUNT(*) AS 'Number of reservation per year'
FROM Mness
WHERE YEAR(arrival_date) = 2018

--TASK 5
SELECT room_type_reserved, COUNT(room_type_reserved) AS 'Number of room type reserved'
FROM Mness
GROUP BY room_type_reserved
ORDER BY COUNT(room_type_reserved)DESC

--TASK 6
SELECT COUNT(no_of_weekend_nights) AS 'Number reservations fall on a weekend'
FROM Mness
WHERE no_of_weekend_nights > 0

--TASK 7
SELECT MAX(lead_time) AS 'Highest lead time',MIN(lead_time) AS 'Lowest lead Time'
FROM Mness

--TASK 8
SELECT market_segment_type, COUNT(market_segment_type) AS 'Number of segment'
FROM Mness
GROUP BY market_segment_type
ORDER BY COUNT(market_segment_type) DESC

--TASK 9
SELECT COUNT(booking_status) AS 
'Number reservations have a booking status of Confirmed'
FROM Mness
WHERE booking_status = 'Not_Canceled'

--TASK 10
SELECT SUM(no_of_adults) AS 'Number of Adults',
SUM(no_of_children) AS 'Number of Children'
FROM Mness
SELECT SUM(no_of_adults) + SUM(no_of_children) AS 'number of people in hotel'
FROM Mness
--TASK 11
SELECT AVG(no_of_weekend_nights) AS 'Number of weekend night involving children'
FROM Mness
WHERE no_of_children <> 0

--TASK 12
SELECT MONTH(arrival_date) AS Month, COUNT(*) AS 'NumberOfReservations'
FROM Mness
GROUP BY MONTH(arrival_date)
ORDER BY Month

--TASK 13

SELECT room_type_reserved,AVG(no_of_weekend_nights+no_of_week_nights) as 
'Average of nights'
FROM Mness
GROUP BY room_type_reserved

--TASK 14
SELECT room_type_reserved, COUNT(room_type_reserved) AS 'Room Type'
,AVG(avg_price_per_room) AS 'Avergae price per room'
FROM Mness
WHERE no_of_children <> 0
GROUP BY room_type_reserved
ORDER BY COUNT(room_type_reserved) DESC

--another way
WITH RankedRoomTypes AS (
    SELECT room_type_reserved,
           COUNT(*) AS NumberOfReservations,
           ROW_NUMBER() OVER (ORDER BY COUNT(*) DESC) AS RoomTypeRank
    FROM Mness
    WHERE no_of_children <> 0
    GROUP BY room_type_reserved
)
SELECT room_type_reserved AS 'Room Type',
       AVG(avg_price_per_room) AS 'Average price per room'
FROM Mness
WHERE room_type_reserved = (
    SELECT room_type_reserved
    FROM RankedRoomTypes
    WHERE RoomTypeRank = 1 -- Selects the most common room type
)
AND no_of_children <> 0
GROUP BY room_type_reserved;

--TASK 15
SELECT market_segment_type, AVG(avg_price_per_room) AS 'Average price per room'
FROM Mness
GROUP BY market_segment_type
ORDER BY AVG(avg_price_per_room) DESC