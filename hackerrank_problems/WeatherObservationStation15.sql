/*
 Query the Western Longitude (LONG_W) for the largest Northern Latitude (LAT_N) in STATION that is less than 137.2345 . Round your answer to  4 decimal places.
 */
-- Engine MSSQL Server
-- Approach 1 
WITH ctas_max_lat_n AS (
    SELECT
        max(lat_n) as max_lat_n
    FROM
        station
    where
        lat_n < 137.2345
)
select
    CAST(s.long_w AS DECIMAL(38, 4))
FROM
    station s
    INNER JOIN ctas_max_lat_n cmln ON (s.lat_n = cmln.max_lat_n) -- Approach 2
select
    CAST(long_w AS DECIMAL(38, 4))
FROM
    station
where
    lat_n IN (
        select
            max(lat_n)
        from
            station
        WHERE
            lat_n < 137.2345
    )
    