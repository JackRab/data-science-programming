/*
*Note:* there are different ways to compute rolling/moving averages. Here we'll use a preceding average which means that the metric for the 7th day of the month would be the average of the preceding 6 days and that day itself. 

*Context*: Say we have table signups in the form: 

| date       | sign_ups |
|------------|----------|
| 2018-01-01 | 10       |
| 2018-01-02 | 20       |
| 2018-01-03 | 50       |
| ...        | ...      |
| 2018-10-01 | 35       |

*Task*: Write a query to get 7-day rolling (preceding) average of daily sign ups. 
*/
-- can also be solved using self-join
WITH signups AS (
    SELECT DATE(starttime) AS date, SUM(slots) AS sign_ups
    FROM bookings
    GROUP BY 1
    ORDER BY 1
)
SELECT date, AVG(sign_ups) OVER(ORDER BY date ROWS BETWEEN 6 PRECEDING AND CURRENT ROW) AS avg_sign_ups
FROM signups
ORDER BY 1;