/*
*Note:* this question is probably more complex than the kind you would encounter in an interview. Consider it a challenge problem, or feel free to skip it! 

*Context:* Say I have a table table in the following form, where a user can be mapped to multiple values of class:

| user | class |
|------|-------|
| 1    | a     |
| 1    | b     |
| 1    | b     |
| 2    | b     |
| 3    | a     |

*Task:* Assume there are only two possible values for class. Write a query to count the number of users in each class such that any user who has label a and b gets sorted into b, any user with just a gets sorted into a and any user with just b gets into b. 

For table that would result in the following table: 

| class | count |
|-------|-------|
| a     | 1     |
 | b     | 2     |

*/

WITH cte AS (
    SELECT DISTINCT memid AS user, CASE WHEN slots <= 3 THEN 'a' ELSE 'b' END AS class
    FROM bookings
    WHERE memid >= 28
    ORDER BY 1
), 
agg AS (
	SELECT user, MAX(class) AS class
	FROM cte
	GROUP BY 1
)
SELECT class, COUNT(*) AS count
FROM agg
GROUP BY 1;