/*
Part 1: 

*Context:* Say we have login data in the table logins: 

| user_id | date       |
|---------|------------|
| 1       | 2018-07-01 |
| 234     | 2018-07-02 |
| 3       | 2018-07-02 |
| 1       | 2018-07-02 |
| ...     | ...        |
| 234     | 2018-10-04 |

*Task:* Write a query that gets the number of retained users per month. In this case, retention for a given month is defined as the number of users who logged in that month who also logged in the immediately previous month. 

*/
-- Part 1: 
WITH DistinctMonthlyUsers AS (
	SELECT DISTINCT memid AS user_id, DATE_FORMAT(starttime, '%Y%m') AS month
	FROM bookings
)
SELECT c.month, COUNT(p.user_id) AS retained_user_count
FROM DistinctMonthlyUsers AS c
LEFT JOIN DistinctMonthlyUsers AS p
ON c.user_id = p.user_id AND PERIOD_DIFF(c.month, p.month) = 1
GROUP BY 1;