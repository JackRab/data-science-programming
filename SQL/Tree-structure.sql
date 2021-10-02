/*
*Context:* Say you have a table tree with a column of nodes and a column corresponding parent nodes 

node   parent
1       2
2       5
3       5
4       3
5       NULL 

*Task:* Write SQL such that we label each node as a “leaf”, “inner” or “Root” node, such that for the nodes above we get: 

node    label  
1       Leaf
2       Inner
3       Inner
4       Leaf
5       Root

A solution which works for the above example will receive full credit, although you can receive extra credit for providing a solution that is generalizable to a tree of any depth (not just depth = 2, as is the case in the example above). 
*/
/* Solution 1 */
SELECT DISTINCT
    n.node, 
    CASE WHEN n.parent IS NULL THEN 'Root'
         WHEN n.parent IS NOT NULL AND c.node IS NULL THEN 'Leaf'
         ELSE 'Inner' END AS label
FROM nodes AS n 
LEFT JOIN nodes AS c 
ON n.node = c.parent;

/* Solution 2 */
SELECT
    n.node, 
    CASE WHEN SUM(IF(n.parent IS NOT NULL, 1, 0)) = 0 THEN 'Root'
         WHEN SUM(IF(n.parent IS NOT NULL, 1, 0)) > 0 AND SUM(IF(c.node IS NOT NULL, 1, 0)) > 0 THEN 'Inner'
         ELSE 'Leaf' END AS label
FROM nodes AS n 
LEFT JOIN nodes AS c 
ON n.node = c.parent
GROUP BY 1;