/*
*Context:* Say we have a table state_streams where each row is a state and the total number of hours of streaming from a video hosting service: 

| state | total_streams |
|-------|---------------|
| NC    | 34569         |
| SC    | 33999         |
| CA    | 98324         |
| MA    | 19345         |
| ..    | ..            |

(In reality these kinds of aggregate tables would normally have a date column, but we’ll exclude that component in this problem) 

*Task:* Write a query to get the pairs of states with total streaming amounts within 1000 of each other. For the snippet above, we would want to see something like:

| state_a | state_b |
|---------|---------|
| NC      | SC      |
| SC      | NC      |

Part 2: 

*Note:* This question is considered more of a bonus problem than an actual SQL pattern. Feel free to skip it!

*Task:* How could you modify the SQL from the solution to Part 1 of this question so that duplicates are removed? For example, if we used the sample table from Part 1, the pair NC and SC should only appear in one row instead of two. 


*/
WITH state_streams AS (
    SELECT name AS state, SUM(slots) AS total_streams
    FROM bookings
    JOIN facilities USING(facid)
    GROUP BY 1
    ORDER BY 1
)

-- part 1:
SELECT a.state AS state_a, b.state AS state_b
FROM state_streams AS a 
CROSS JOIN state_streams AS b 
ON ABS(a.total_streams - b.total_streams)<50 AND a.state != b.state;

-- part 2:
SELECT a.state AS state_a, b.state AS state_b
FROM state_streams AS a 
CROSS JOIN state_streams AS b 
ON ABS(a.total_streams - b.total_streams)<50 AND a.state < b.state;