/*
*Context:* Say we have a table sessions where each row is a video streaming session with length in seconds: 

| session_id | length_seconds |
|------------|----------------|
| 1          | 23             |
| 2          | 453            |
| 3          | 27             |
| ..         | ..             |

*Task:* Write a query to count the number of sessions that fall into bands of size 5, i.e. for the above snippet, produce something akin to: 

| bucket  | count |
|---------|-------|
| 20-25   | 2     |
| 450-455 | 1     |

Get complete credit for the proper string labels (“5-10”, etc.) but near complete credit for something that is communicable as the bin. 
*/
WITH sessions AS (
    SELECT memid AS session_id, SUM(slots) AS length_seconds
    FROM bookings
    GROUP BY 1
    ORDER BY 2
)

-- solution without string labels
SELECT length_seconds DIV 5 AS bucket, COUNT(*) AS count 
FROM sessions
GROUP BY 1
ORDER BY 1;

-- solution with string labels
SELECT 
    CONCAT(CAST((length_seconds DIV 5)*5 AS CHAR), '-', CAST((length_seconds DIV 5)*5+5 AS CHAR)) AS bucket, 
    COUNT(*) AS count
FROM sessions
GROUP BY 1;