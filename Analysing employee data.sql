#View records from  all the tables for overview#
SELECT 
    *
FROM
    employee_demographics;
SELECT 
    *
FROM
    parks_departments;
SELECT 
    *
FROM
    employee_salary;

#Department wise salary analysis using joins#

WITH cte AS (
    SELECT 
        es.`employee_id`, es.`first_name`, es.`last_name`, es.occupation,
        es.`dept_id`, pd.`department_name`, es.salary
    FROM 
        employee_salary es
    JOIN 
        parks_departments pd ON es.`dept_id` = pd.`department_id`
)
select department_name ,round(avg(salary),0) as avgsalary from cte group by department_name order by avgsalary desc;


#Top earners in each department using window function#
WITH cte1 AS (
    SELECT 
        es.`employee_id`, es.`first_name`, es.`last_name`, es.occupation,
        es.`dept_id`, pd.`department_name`, es.salary
    FROM 
        employee_salary es
    JOIN 
        parks_departments pd ON es.`dept_id` = pd.`department_id`
),
ranked_cte AS (
    SELECT 
        *, 
        Dense_RANK() OVER (PARTITION BY dept_id ORDER BY salary DESC) AS salary_rank
    FROM 
        cte1
)

SELECT 
    * 
FROM 
    ranked_cte
WHERE 
    salary_rank = 1;
    
#Count of Female and Male#
SELECT 
    COUNT(*), gender
FROM
    employee_demographics
GROUP BY Gender;


#Count of employees birth year wise#
SELECT 
    COUNT(*) AS empcount, YEAR(`birth_date`) AS birthyr
FROM
    employee_demographics
GROUP BY birthyr;


#Obtaining fullname of the employees#
SELECT 
    *, CONCAT(first_name, ' ', last_name) AS fullname
FROM
    employee_demographics;


#Avg age by gender of employees#
SELECT 
    ROUND(AVG(age), 0) AS avgagepergender, gender
FROM
    employee_demographics
GROUP BY Gender
ORDER BY avgagepergender DESC;
        



    


    






    







