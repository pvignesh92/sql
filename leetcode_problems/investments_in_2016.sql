-- Write an SQL query to report the sum of all total investment values in 2016 tiv_2016, for all policyholders who:

-- have the same tiv_2015 value as one or more other policyholders, and
-- are not located in the same city like any other policyholder (i.e., the (lat, lon) attribute pairs must be unique).
-- Round tiv_2016 to two decimal places.


with ctas_tiv_2015 AS (
select tiv_2015, count(*) as cnt
    FROM 
    insurance
    GROUP BY 
tiv_2015
    having cnt > 1
),
ctas_lat_lon AS (
select concat(lat,lon) as lat_lon, count(*) as cnt
    FROM 
insurance
    GROUP BY 
concat(lat,lon)
    having cnt = 1
),
ctas_join AS (
select 
    i.* from insurance AS i
    INNER JOIN 
    ctas_tiv_2015 as tiv ON (i.tiv_2015 = tiv.tiv_2015)
    INNER JOIN 
    ctas_lat_lon as cll ON (concat(i.lat, i.lon) = cll.lat_lon)
    )
select ROUND(SUM(tiv_2016),2) as tiv_2016 from ctas_join
    