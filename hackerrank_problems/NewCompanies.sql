/*Advanced SQL - Topic New Companies
-- write a query to print the company_code, founder name, total number of lead managers, total number of senior managers, total number of managers, and total number of employees. Order your output by ascending company_code.
-- Note:
-- The tables may contain duplicate records.
-- The company_code is string, so the sorting should not be numeric. For example, if the company_codes are C_1, C_2, and C_10, then the ascending company_codes will be C_1, C_10, and C_2.
*/

-- Engine - MSSQL Server


WITH ctas_iq AS (
    SELECT
        DISTINCT c.company_code,
        c.founder,
        lm.lead_manager_code,
        sm.senior_manager_code,
        m.manager_code,
        e.employee_code
    FROM
        company AS c
        LEFT JOIN lead_manager as lm ON (c.company_code = lm.company_code)
        LEFT JOIN senior_manager AS sm ON (
            lm.company_code = sm.company_code
            AND lm.lead_manager_code = sm.lead_manager_code
        )
        LEFT JOIN manager as m ON (
            m.company_code = sm.company_code
            AND m.lead_manager_code = sm.lead_manager_code
            AND m.senior_manager_code = sm.senior_manager_code
        )
        LEFT JOIN employee as e ON (
            e.company_code = m.company_code
            AND e.lead_manager_code = m.lead_manager_code
            AND e.senior_manager_code = m.senior_manager_code
            AND e.manager_code = m.manager_code
        )
)
select
    distinct company_code,
    founder,
    COUNT(DISTINCT lead_manager_code),
    COUNT(DISTINCT senior_manager_code),
    COUNT(DISTINCT manager_code),
    COUNT(DISTINCT employee_code)
from
    ctas_iq -- where company_code in ('C93')  
GROUP BY
    company_code,
    founder
ORDER BY
    company_code