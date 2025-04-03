-- LAB 2: Joins, Aggregations and Updates
-- Query 1: INNER JOIN (Members with their payments)
SELECT m.name AS member_name, p.amount, p.payment_date
FROM Members m
JOIN Payments p ON m.member_id = p.member_id;

-- Query 2: LEFT JOIN (All trainers with class count)
SELECT t.name AS trainer_name, 
       COUNT(c.class_id) AS classes_taught
FROM Trainers t
LEFT JOIN Classes c ON t.trainer_id = c.trainer_id
GROUP BY t.name;

-- Query 3: UPDATE (Apply 5% price increase)
UPDATE Payments
SET amount = amount * 1.05
WHERE amount > 0;

-- Query 4: AGGREGATION (Total payments per member)
SELECT m.name, SUM(p.amount) AS total_paid
FROM Members m
LEFT JOIN Payments p ON m.member_id = p.member_id
GROUP BY m.name
HAVING total_paid > 0;

-- Query 5: SUBQUERY (Members without payments)
SELECT name AS non_paying_members
FROM Members
WHERE member_id NOT IN (SELECT member_id FROM Payments);
