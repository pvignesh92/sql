/*
 Query the smallest Northern Latitude (LAT_N) from STATION that is greater than 38.7780 . Round your answer to 4 decimal places.
 */
SELECT
    CAST(min(lat_n) AS DECIMAL(38, 4))
FROM
    station
WHERE
    lat_n > 38.7780;