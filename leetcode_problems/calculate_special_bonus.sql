/* Write an SQL query to calculate the bonus of each employee. 
 The bonus of an employee is 100% of their salary if the ID of the 
 employee is an odd number and the employee name does not start with
 the character 'M'. The bonus of an employee is 0 otherwise.
 */

 -- 1873. Calculate Special Bonus
select
    employee_id,
    CASE
        WHEN employee_id % 2 != 0
        AND UPPER(SUBSTR(name, 1, 1)) != 'M' THEN salary
        ELSE 0
    END as bonus
FROM
    Employees