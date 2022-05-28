-- Query the greatest value of the Northern Latitudes (LAT_N) from STATION that is less than 137.2345. Truncate your answer to  4 decimal places.
-- Engine MSSQL Server
SELECT
    CAST(max(lat_n) as DECIMAL(38, 4))
FROM
    station
where
    lat_n < 137.2345