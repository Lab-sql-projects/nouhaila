USE gym_membership_system;
CREATE TABLE Members (
    member_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL,
    phone_number VARCHAR(15),
    membership_start DATE,
    membership_end DATE
);

CREATE TABLE Trainers (
    trainer_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    specialization VARCHAR(100)
);

CREATE TABLE Classes (
    class_id INT AUTO_INCREMENT PRIMARY KEY,
    class_name VARCHAR(100) NOT NULL,
    trainer_id INT,
    class_time TIMESTAMP,
    FOREIGN KEY (trainer_id) REFERENCES Trainers(trainer_id)
);

CREATE TABLE Payments (
    payment_id INT AUTO_INCREMENT PRIMARY KEY,
    member_id INT,
    amount DECIMAL(10, 2),
    payment_date TIMESTAMP,
    FOREIGN KEY (member_id) REFERENCES Members(member_id)
);

INSERT INTO Members (name, email, phone_number, membership_start, membership_end)
VALUES ('John Doe', 'johndoe@example.com', '1234567890', '2023-01-01', '2023-12-31');

INSERT INTO Trainers (name, specialization)
VALUES ('Jane Smith', 'Yoga');

INSERT INTO Classes (class_name, trainer_id, class_time)
VALUES ('Morning Yoga', 1, '2023-03-28 08:00:00');

INSERT INTO Payments (member_id, amount, payment_date)
VALUES (1, 100.00, '2023-01-01 10:00:00');

SELECT * FROM Members;
SELECT * FROM Trainers;
SELECT * FROM Classes;
SELECT * FROM Payments;

-- Insert more members
INSERT INTO Members (name, email, phone_number, membership_start, membership_end)
VALUES ('Alice Johnson', 'alice@example.com', '9876543210', '2023-02-01', '2023-12-31');

-- Insert more trainers
INSERT INTO Trainers (name, specialization)
VALUES ('Mark Brown', 'Pilates');

-- Insert more classes
INSERT INTO Classes (class_name, trainer_id, class_time)
VALUES ('Evening Pilates', 2, '2023-03-29 18:00:00');

-- Insert more payments
INSERT INTO Payments (member_id, amount, payment_date)
VALUES (2, 150.00, '2023-02-01 14:00:00');

SELECT c.class_name, c.class_time 
FROM Classes c
JOIN Trainers t ON c.trainer_id = t.trainer_id
WHERE t.trainer_id = 1;


UPDATE Members
SET phone_number = '5555555555'
WHERE name = 'John Doe';

UPDATE Classes
SET class_time = '2023-03-28 09:00:00'
WHERE class_name = 'Morning Yoga';


DELETE FROM Classes
WHERE class_name = 'Morning Yoga';

DELETE FROM Members
WHERE name = 'Alice Johnson';
