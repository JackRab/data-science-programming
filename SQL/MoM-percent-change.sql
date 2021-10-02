/*
#1: MoM Percent Change 

*Context:* Oftentimes it's useful to know how much a key metric, such as monthly active users, changes between months. Say we have a table logins in the form: 

| user_id | date       |
|---------|------------|
| 1       | 2018-07-01 |
| 234     | 2018-07-02 |
| 3       | 2018-07-02 |
| 1       | 2018-07-02 |
| ...     | ...        |
| 234     | 2018-10-04 |

*Task*: Find the month-over-month percentage change for monthly active users (MAU). 
*/

WITH agg AS(
    SELECT DATE_TRUNC('month', date) AS month, COUNT(DISTINCT user_id) AS mau 
    FROM logins
    ORDER BY 1
)

SELECT c.month, (c.mau - p.mau)/p.mau AS mom_change
FROM agg AS c 
JOIN agg AS p 
ON c.month = p.month - INTEVAL '1 month'