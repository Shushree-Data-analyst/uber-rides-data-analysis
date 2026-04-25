Create database uber;
use uber;

CREATE TABLE uber_rides (
    START_DATE VARCHAR(50),
    END_DATE VARCHAR(50),
    CATEGORY VARCHAR(50),
    START_LOCATION VARCHAR(100),
    STOP_LOCATION VARCHAR(100),
    MILES FLOAT,
    PURPOSE VARCHAR(100)
);

select* from uber_rides;

DELETE FROM uber_rides
WHERE START_DATE = 'Totals';


UPDATE uber_rides
SET 
start_dt = STR_TO_DATE(START_DATE, '%m-%d-%Y %H:%i'),
end_dt = STR_TO_DATE(END_DATE, '%m-%d-%Y %H:%i');

UPDATE uber_rides
SET PURPOSE = 'NOT'
WHERE PURPOSE IS NULL;

DELETE FROM uber_rides
WHERE start_dt IS NULL OR end_dt IS NULL;

ALTER TABLE uber_rides ADD COLUMN hour INT;

UPDATE uber_rides
SET hour = HOUR(start_dt);

ALTER TABLE uber_rides ADD COLUMN day_night VARCHAR(20);

UPDATE uber_rides
SET day_night =
CASE 
    WHEN hour BETWEEN 0 AND 10 THEN 'Morning'
    WHEN hour BETWEEN 11 AND 15 THEN 'Afternoon'
    WHEN hour BETWEEN 16 AND 19 THEN 'Evening'
    ELSE 'Night'
END;


ALTER TABLE uber_rides ADD COLUMN day_name VARCHAR(20);

UPDATE uber_rides
SET day_name = DAYNAME(start_dt);

SELECT COUNT(*) AS total_rides FROM uber_rides;

SELECT CATEGORY, COUNT(*) AS total
FROM uber_rides
GROUP BY CATEGORY;

SELECT PURPOSE, COUNT(*) AS total
FROM uber_rides
GROUP BY PURPOSE
ORDER BY total DESC;

-- Total Rides
SELECT COUNT(*) AS total_rides FROM uber;

-- Ride Count by Category
SELECT CATEGORY, COUNT(*) AS total
FROM uber
GROUP BY CATEGORY;

-- Ride Count by Purpose
SELECT PURPOSE, COUNT(*) AS total
FROM uber
GROUP BY PURPOSE
ORDER BY total DESC;

-- Average Miles Travelled
SELECT AVG(MILES) AS avg_miles FROM uber;

-- Max Distance Ride
SELECT MAX(MILES) AS max_distance FROM uber;

-- Rides by Time Category
SELECT day_night, COUNT(*) AS total_rides
FROM uber
GROUP BY day_night;

-- Monthly Rides
SELECT MONTH, COUNT(*) AS total_rides
FROM uber
GROUP BY MONTH;

-- Weekly Rides
SELECT DAY, COUNT(*) AS total_rides
FROM uber
GROUP BY DAY;

-- Business vs Personal Comparison
SELECT CATEGORY, AVG(MILES) AS avg_distance
FROM uber
GROUP BY CATEGORY;