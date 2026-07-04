create database hr;

USE hr;


/* 1. Write a query in SQL to display the first name, last name, department number, 
and department name for each employee. */
 
SELECT
    e.first_name,
    e.last_name,
    e.department_id AS department_number,
    d.department_name AS department_name
FROM employees AS e
INNER JOIN departments AS d
ON e.department_id = d.department_id;

/* 2. Write a query in SQL to display the first and last name, 
department, city, and state province for each employee. */

SELECT
    e.first_name,
    e.last_name,
    d.department_name,
    l.city,
    l.state_province
FROM employees e
INNER JOIN departments d
    ON e.department_id = d.department_id
INNER JOIN locations l
    ON d.location_id = l.location_id; 

/* 3. Write a query in SQL to display the first name, last name, salary, 
and job grade for all employees. */

SELECT
    e.first_name,
    e.last_name,
    e.salary,
    j.grade_level
FROM employees e
INNER JOIN job_grades j
ON e.salary BETWEEN j.lowest_sal AND j.highest_sal;


/* 4. Write a query in SQL to display the first name, last name, department number 
and department name, for all employees for departments 80 or 40. */

SELECT
    e.first_name,
    e.last_name,
    e.department_id AS department_number,
    d.department_name
FROM employees e
INNER JOIN departments d
ON e.department_id = d.department_id
WHERE e.department_id IN (80,40);

/* 5. Write a query in SQL to display those employees who contain a letter z to their 
first name and also display their last name, department, city, and state province. */

SELECT
    e.first_name,
    e.last_name,
    d.department_name,
    l.city,
    l.state_province
FROM employees e
INNER JOIN departments d
ON e.department_id = d.department_id
INNER JOIN locations l
ON d.location_id = l.location_id
WHERE e.first_name LIKE '%z%';

/* 6. Write a query in SQL to display all departments including those 
where does not have any employee. */

SELECT
    d.department_id,
    d.department_name,
    e.first_name,
    e.last_name
FROM departments d
LEFT JOIN employees e
ON d.department_id = e.department_id;

/* 7. Write a query in SQL to display the first and last name and salary 
for those employees who earn less than the employee earn whose number is 182. */

 SELECT E.first_name, E.last_name, E.salary
FROM employees E
JOIN employees S
ON E.salary < S.salary
AND S.employee_id = 182;



/* 8. Write a query in SQL to display the first name of all employees 
including the first name of their manager. */

SELECT
    e.first_name AS employee_name,
    m.first_name AS manager_name
FROM employees e
LEFT JOIN employees m
    ON e.manager_id = m.employee_id;

/* 9. Write a query in SQL to display the department name, city, and 
state province for each department. */
 
SELECT
    d.department_name,
    l.city,
    l.state_province
FROM departments d
JOIN locations l
    ON d.location_id = l.location_id;

/* 10. Write a query in SQL to display the first name, last name, department number and name, 
for all employees who have or have not any department. */

SELECT
    e.first_name,
    e.last_name,
    e.department_id,
    d.department_name
FROM employees e
LEFT JOIN departments d
    ON e.department_id = d.department_id;
 
/* 11. Write a query in SQL to display the first name of all employees and the 
first name of their manager including those who does not working under any manager. */

SELECT
    e.first_name AS employee_name,
    m.first_name AS manager_name
FROM employees e
LEFT JOIN employees m
    ON e.manager_id = m.employee_id;
 
/* 12. Write a query in SQL to display the first name, last name, and department number for 
those employees who works in the same department as the employee who holds the last name as Taylor. */
 
SELECT
    first_name,
    last_name,
    department_id
FROM employees
WHERE department_id IN (
    SELECT department_id
    FROM employees
    WHERE last_name = 'Taylor'
);

/* 13. Write a query in SQL to display the job title, department name, full name (first and last name ) 
of employee, and starting date for all the jobs which started on or after 1st January, 1993 and ending with 
on or before 31 August, 1997 */

SELECT j.job_title,d.department_name,
    CONCAT(e.first_name, ' ', e.last_name) AS employee_name,
    jh.start_date
FROM job_history jh
JOIN employees e
    ON jh.employee_id = e.employee_id
JOIN jobs j
    ON jh.job_id = j.job_id
JOIN departments d
    ON jh.department_id = d.department_id
WHERE jh.start_date >= '1993-01-01'
  AND jh.start_date <= '1997-08-31';


/* 14. Write a query in SQL to display job title, full name (first and last name ) of employee, 
and the difference between maximum salary for the job and salary of the employee. */

 SELECT j.job_title,CONCAT(e.first_name, ' ', e.last_name) AS employee_name,
(j.max_salary - e.salary) AS salary_difference
FROM employees e
JOIN jobs j
    ON e.job_id = j.job_id;


/* 15. Write a query in SQL to display the name of the department, average salary and number 
of employees working in that department who got commission. */

SELECT
    d.department_name,
    AVG(e.salary) AS average_salary,
    COUNT(e.employee_id) AS employee_count
FROM employees e
JOIN departments d
    ON e.department_id = d.department_id
WHERE e.commission_pct IS NOT NULL
GROUP BY d.department_name;
 
/* 16. Write a query in SQL to display the full name (first and last name ) of employees, 
job title and the salary differences to their own job for those employees who is working in the department ID 80. */

 SELECT
    CONCAT(e.first_name, ' ', e.last_name) AS employee_name,
    j.job_title,
    (j.max_salary - e.salary) AS salary_difference
FROM employees e
JOIN jobs j
    ON e.job_id = j.job_id
WHERE e.department_id = 80;

/* 17. Write a query in SQL to display the name of the country, city, and 
the departments which are running there. */

 SELECT
    c.country_name,
    l.city,
    d.department_name
FROM countries c
JOIN locations l
    ON c.country_id = l.country_id
JOIN departments d
    ON l.location_id = d.location_id;

/* 18. Write a query in SQL to display department name and the 
full name (first and last name) of the manager. */
 
 SELECT d.department_name,CONCAT(e.first_name, ' ', e.last_name) AS manager_name
FROM departments d
JOIN employees e
    ON d.manager_id = e.employee_id;

/* 19. Write a query in SQL to display job title and average salary of employees. */

 SELECT
    j.job_title,
    AVG(e.salary) AS average_salary
FROM employees e
JOIN jobs j
    ON e.job_id = j.job_id
GROUP BY j.job_title;

/* 20. Write a query in SQL to display the details of jobs which was done by any of the employees 
who is presently earning a salary on and above 12000. */

 SELECT DISTINCT
    j.job_id,
    j.job_title,
    j.min_salary,
    j.max_salary
FROM employees e
JOIN jobs j
    ON e.job_id = j.job_id
WHERE e.salary >= 12000;

/* 21. Write a query in SQL to display the country name, city, and number of 
those departments where at least 2 employees are working. */

SELECT c.country_name,l.city,
    COUNT(DISTINCT d.department_id) AS number_of_departments
FROM countries c
JOIN locations l
    ON c.country_id = l.country_id
JOIN departments d
    ON l.location_id = d.location_id
JOIN employees e
    ON d.department_id = e.department_id
GROUP BY
    c.country_name,
    l.city,
    d.department_id
HAVING COUNT(e.employee_id) >= 2;
 
/* 22. Write a query in SQL to display the department name, 
full name (first and last name) of manager, and their city.  */
 
SELECT
    d.department_name,
    CONCAT(e.first_name, ' ', e.last_name) AS manager_name,
    l.city
FROM departments d
JOIN employees e
    ON d.manager_id = e.employee_id
JOIN locations l
    ON d.location_id = l.location_id;

/* 23. Write a query in SQL to display the employee ID, job name, number of days worked in 
for all those jobs in department 80. */

 SELECT
    jh.employee_id,
    j.job_title,
    (jh.end_date - jh.start_date) AS days_worked
FROM job_history jh
JOIN jobs j
    ON jh.job_id = j.job_id
WHERE jh.department_id = 80;


/* 24. Write a query in SQL to display the full name (first and last name), and salary of 
those employees who working in any department located in London. */

 SELECT
    CONCAT(e.first_name, ' ', e.last_name) AS employee_name,
    e.salary
FROM employees e
JOIN departments d
    ON e.department_id = d.department_id
JOIN locations l
    ON d.location_id = l.location_id
WHERE l.city = 'London';

/* 25. Write a query in SQL to display full name(first and last name), job title, 
starting and ending date of last jobs for those employees with worked without a commission percentage. */

 SELECT
    CONCAT(e.first_name, ' ', e.last_name) AS employee_name,
    j.job_title,
    jh.start_date,
    jh.end_date
FROM employees e
JOIN job_history jh
    ON e.employee_id = jh.employee_id
JOIN jobs j
    ON jh.job_id = j.job_id
WHERE e.commission_pct IS NULL;

/* 26. Write a query in SQL to display the department name and number of 
employees in each of the department. */

SELECT
    d.department_name,
    COUNT(e.employee_id) AS number_of_employees
FROM departments d
LEFT JOIN employees e
    ON d.department_id = e.department_id
GROUP BY d.department_name; 

/* 27. Write a query in SQL to display the full name (first and last name) 
of employee with ID and name of the country presently where (s)he is working. */
 
SELECT
    e.employee_id,
    CONCAT(e.first_name, ' ', e.last_name) AS employee_name,
    c.country_name
FROM employees e
JOIN departments d
    ON e.department_id = d.department_id
JOIN locations l
    ON d.location_id = l.location_id
JOIN countries c
    ON l.country_id = c.country_id;