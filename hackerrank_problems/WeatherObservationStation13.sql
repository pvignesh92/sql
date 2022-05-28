/*
 Query the sum of Northern Latitudes (LAT_N) from STATION having values greater than 38.7880 and less than 137.2345. Truncate your answer to  decimal places.
 */
select
    CAST(SUM(lat_n) AS DECIMAL(38, 4))
from
    station
WHERE
    lat_n > 38.7880
    and lat_n < 137.2345
    