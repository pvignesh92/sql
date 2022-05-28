/*
 Query the Western Longitude (LONG_W)where the smallest Northern Latitude (LAT_N) in STATION is greater than 38.7780 . Round your answer to 4 decimal places.
 */
SELECT
    CAST(long_w AS DECIMAL(38, 4))
FROM
    STATION
where
    lat_n IN (
        SELECT
            min(lat_n)
        FROM
            station
        where
            lat_n > 38.7780
    )