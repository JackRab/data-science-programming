/*
*Context:* Say we have a table transactions in the form:

| date       | cash_flow |
|------------|-----------|
| 2018-01-01 | -1000     |
| 2018-01-02 | -100      |
| 2018-01-03 | 50        |
| ...        | ...       |

Where cash_flow is the revenues minus costs for each day. 

*Task:* Write a query to get cumulative cash flow for each day such that we end up with a table in the form below: 

| date       | cumulative_cf |
|------------|---------------|
| 2018-01-01 | -1000         |
| 2018-01-02 | -1100         |
| 2018-01-03 | -1050         |
| ...        | ...           |

*/
WITH transactions AS (
    SELECT DATE(starttime) AS date, SUM(slots) AS cash_flow
    FROM bookings
    GROUP BY 1
    ORDER BY 1
)

-- solution 1: self join
SELECT a.date, SUM(b.cash_flow) AS cumulative_cf
FROM transactions AS a 
JOIN transactions AS b
ON a.date>=b.date 
GROUP BY 1
ORDER BY 1;

-- solution 2: window function
SELECT date, SUM(cash_flow) OVER(ORDER BY date) AS cumulative_cf
FROM transactions;