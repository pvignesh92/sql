/*
Query the following two values from the STATION table:

The sum of all values in LAT_N rounded to a scale of  decimal places.
The sum of all values in LONG_W rounded to a scale of  decimal places.
*/

--Engine MSSQL Server


select
    CAST(ROUND(SUM(lat_n), 2) AS DECIMAL(38, 2)) as lat_sum,
    CAST(ROUND(SUM(long_w), 2) AS DECIMAL(38, 2)) as long_sum
from
    station