/*
*Context:* Say we have a table salaries with data on employee salary and department in the following format: 

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

*Task*: Write a query to get the empno with the highest salary. Make sure your solution can handle ties!
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

-- solution 1: sub-query
SELECT empno
FROM salaries
WHERE salary = (SELECT MAX(salary) FROM salaries);

-- solution 2: window function
SELECT empno
FROM (
    SELECT empno, DENSE_RANK() OVER(ORDER BY salary DESC) AS rk 
    FROM salaries
) AS subq 
WHERE rk = 1;