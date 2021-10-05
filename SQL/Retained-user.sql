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

Part 2: 

*Task:* Now we’ll take retention and turn it on its head: Write a query to find how many users last month did not come back this month. i.e. the number of churned users.  

Part 3:

*Context*: You now want to see the number of active users this month who have been reactivated — in other words, users who have churned but this month they became active again. Keep in mind a user can reactivate after churning before the previous month. An example of this could be a user active in February (appears in logins), no activity in March and April, but then active again in May (appears in logins), so they count as a reactivated user for May . 

*Task:* Create a table that contains the number of reactivated users per month. 

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

-- Part 2:
SELECT p.month, COUNT(DISTINCT p.user_id) AS churned_users
FROM DistinctMonthlyUsers AS p
LEFT JOIN DistinctMonthlyUsers AS c
ON p.user_id = c.user_id AND PERIOD_DIFF(c.month, p.month) = 1
WHERE c.user_id IS NULL
GROUP BY 1;

-- Part 3:
WITH logins AS (
    SELECT DISTINCT memid AS user_id, DATE(starttime) AS date
    FROM bookings
)
SELECT 
	DATE_FORMAT(a.date, '%Y%m') AS month,
	COUNT(DISTINCT a.user_id) AS reactivated_users,
	MAX(DATE_FORMAT(b.date, '%Y%m'))  AS most_recent_active_previously
FROM logins AS a 
JOIN logins AS b ON a.user_id = b.user_id AND PERIOD_DIFF(DATE_FORMAT(a.date, '%Y%m'), DATE_FORMAT(b.date, '%Y%m'))>=1
GROUP BY 1 
HAVING PERIOD_DIFF(month, most_recent_active_previously) > 1;