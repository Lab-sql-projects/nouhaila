-- 1. Create a View (SafeMemberView)
CREATE VIEW SafeMemberView AS
SELECT member_id, name, membership_start, membership_end
FROM Members;

-- 2. Add Integrity Constraints
ALTER TABLE Members
ADD CONSTRAINT unique_email UNIQUE (email);

ALTER TABLE Members
ADD CONSTRAINT check_membership_length 
CHECK (DATEDIFF(membership_end, membership_start) <= 365);

-- 3. Create Index on member_id
CREATE INDEX idx_member_id ON Payments(member_id);

-- 4. Transaction (Insert, Update, Rollback)
START TRANSACTION;
INSERT INTO Members (name, email, phone_number, membership_start, membership_end)
VALUES ('Test User', 'testuser@example.com', '0000000000', '2025-01-01', '2025-12-31');
UPDATE Members
SET membership_end = '2026-01-01'
WHERE name = 'Test User';
ROLLBACK;

-- 5. Create Enrollments Table
CREATE TABLE Enrollments (
    enrollment_id INT AUTO_INCREMENT PRIMARY KEY,
    member_id INT,
    class_id INT,
    FOREIGN KEY (member_id) REFERENCES Members(member_id),
    FOREIGN KEY (class_id) REFERENCES Classes(class_id)
);

-- Enroll member John Doe in Jane Smith's class
INSERT INTO Enrollments (member_id, class_id)
VALUES (1, 1);

-- 6. Complex Query: Join + Subquery + Filter
SELECT m.name AS member_name, c.class_name
FROM Members m
JOIN Payments p ON m.member_id = p.member_id
JOIN Enrollments e ON m.member_id = e.member_id
JOIN Classes c ON e.class_id = c.class_id
WHERE c.trainer_id = (
    SELECT trainer_id FROM Trainers WHERE name = 'Jane Smith'
)
AND p.amount > 0;

-- 7. Bonus: Create User and Grant SELECT on View
CREATE USER 'staff_user'@'localhost' IDENTIFIED BY 'securepass';
GRANT SELECT ON gym_membership_system.SafeMemberView TO 'staff_user'@'localhost';
