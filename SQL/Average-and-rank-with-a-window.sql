/*
Part 1:
*Context*: Say we have a table salaries in the format:

  depname  | empno | salary |     
-----------+-------+--------+
 develop   |    11 |   5200 | 
 develop   |     7 |   4200 | 
 develop   |     9 |   4500 | 
 develop   |     8 |   6000 | 
 develop   |    10 |   5200 | 
 personnel |     5 |   3500 | 
 personnel |     2 |   3900 | 
 sales     |     3 |   4800 | 
 sales     |     1 |   5000 | 
 sales     |     4 |   4800 | 

*Task:* Write a query that returns the same table, but with a new column that has average salary per depname. We would expect a table in the form: 

  depname  | empno | salary | avg_salary |     
-----------+-------+--------+------------+
 develop   |    11 |   5200 |       5020 |
 develop   |     7 |   4200 |       5020 | 
 develop   |     9 |   4500 |       5020 |
 develop   |     8 |   6000 |       5020 | 
 develop   |    10 |   5200 |       5020 | 
 personnel |     5 |   3500 |       3700 |
 personnel |     2 |   3900 |       3700 |
 sales     |     3 |   4800 |       4867 | 
 sales     |     1 |   5000 |       4867 | 
 sales     |     4 |   4800 |       4867 |
 
Part 2:

*Task:* Write a query that adds a column with the rank of each employee based on their salary within their department, where the employee with the highest salary gets the rank of 1. We would expect a table in the form: 

  depname  | empno | salary | salary_rank |     
-----------+-------+--------+-------------+
 develop   |    11 |   5200 |           2 |
 develop   |     7 |   4200 |           5 | 
 develop   |     9 |   4500 |           4 |
 develop   |     8 |   6000 |           1 | 
 develop   |    10 |   5200 |           2 | 
 personnel |     5 |   3500 |           2 |
 personnel |     2 |   3900 |           1 |
 sales     |     3 |   4800 |           2 | 
 sales     |     1 |   5000 |           1 | 
 sales     |     4 |   4800 |           2 | 


*/

WITH salaries AS (
    SELECT 
        facid AS depname,
        memid AS empno,
        SUM(slots) AS salary
    FROM bookings
    GROUP BY 1, 2
    ORDER BY 1, 2
)
-- Part 1
SELECT depname, empno, salary, AVG(salary) OVER(PARTITION BY depname) AS avg_salary
FROM salaries;

-- Part 2
SELECT depname, empno, salary, RANK() OVER(PARTITION BY depname ORDER BY salary DESC) AS salary_rank
FROM salaries;