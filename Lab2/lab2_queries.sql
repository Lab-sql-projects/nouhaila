-- LAB 2: IMPROVED QUERIES

-- 1. INNER JOIN (Formatted output)
SELECT 
    m.name AS member_name,
    CONCAT('$', ROUND(p.amount, 2)) AS amount,
    DATE_FORMAT(p.payment_date, '%b %d, %Y %h:%i %p') AS payment_date
FROM Members m
JOIN Payments p ON m.member_id = p.member_id;

-- 2. LEFT JOIN (With zero-class handling)
SELECT 
    t.name AS trainer_name,
    COUNT(c.class_id) AS classes_taught,
    IF(COUNT(c.class_id)=0, 'None', 'Assigned') AS status
FROM Trainers t
LEFT JOIN Classes c ON t.trainer_id = c.trainer_id
GROUP BY t.name;

-- 3. SAFE UPDATE (One-time 5% increase)
START TRANSACTION;
UPDATE Payments
SET amount = ROUND(amount * 1.05, 2)
WHERE payment_date < CURDATE();
COMMIT;

-- 4. AGGREGATION (With sorting)
SELECT 
    m.name,
    CONCAT('$', SUM(p.amount)) AS total_paid,
    COUNT(p.payment_id) AS payments_count
FROM Members m
LEFT JOIN Payments p ON m.member_id = p.member_id
GROUP BY m.name
HAVING total_paid IS NOT NULL
ORDER BY SUM(p.amount) DESC;

-- 5. SUBQUERY (Optimized)
SELECT 
    name AS non_paying_members,
    email AS contact
FROM Members
WHERE member_id NOT IN (
    SELECT DISTINCT member_id 
    FROM Payments 
    WHERE amount > 0
);
