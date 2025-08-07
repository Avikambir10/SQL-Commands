-- 1) CREATE DATABASE Library;

CREATE TABLE books(
	BookID INT PRIMARY KEY,
    Title VARCHAR(50),
    PublishedYear INT NOT NULL,
    Author VARCHAR(50)
);

INSERT INTO books 
(BookID, Title, PublishedYear, Author) 
VALUES 
(1, 'Room on the Roof',2001,'JK Ruskin Bond');

ALTER TABLE books
ADD ISBN VARCHAR(13);

ALTER TABLE books
DROP COLUMN PublishedYear;

-- 2)CREATE DATABASE School;
use School;

CREATE TABLE Students(
	rollNo INT primary key,
    name VARCHAR(50),
    age INT,
    grade VARCHAR(1)
);

INSERT INTO Students 
(rollNo, name, age, grade) 
VALUES 
(1, 'Avikam',19,'O');

SET SQL_SAFE_UPDATES = 0;

UPDATE Students
SET Grade = 'A'
WHERE name = 'Avikam';

DELETE from Students
WHERE grade='A'

-- 3)CREATE USER 'User2'@'localhost' IDENTIFIED BY 'avikam';
GRANT SELECT, INSERT ON school.students TO 'User2'@'localhost';

-- 4)START TRANSACTION;

use Orders;
UPDATE orders 
SET Quantity = Quantity - 2 
WHERE ProductID = 105;

-- If no errors, commit the transaction
COMMIT;

-- 5) START TRANSACTION;

INSERT INTO Customers (CustomerID, Name, Email, Phone) 
VALUES (201, 'Devesh Bond', 'bonddevesh@example.com', '7418529637');

CREATE USER 'Admin'@'localhost' IDENTIFIED BY 'admin';
GRANT SELECT, INSERT ON school.students TO 'Admin'@'localhost';

ROLLBACK;





-- INNER JOIN

SELECT e.name, d.department_name
FROM employees e
JOIN departments d ON e.department_id = d.id;

-- LEFT JOIN

SELECT e.name, d.department_name
FROM employees e
LEFT JOIN departments d ON e.department_id = d.id;

-- GROUP BY with HAVING

SELECT department, COUNT(*) 
FROM employees 
GROUP BY department 
HAVING COUNT(*) > 5;

-- SUBQUERY in WHERE

SELECT name FROM employees 
WHERE department_id IN (SELECT id FROM departments WHERE location = 'New York');


-- BETWEEN / IN / LIKE

SELECT * FROM employees WHERE salary BETWEEN 30000 AND 50000;
SELECT * FROM employees WHERE name LIKE 'A%';

-- UNION / UNION ALL
	
SELECT name FROM employees_us
UNION
SELECT name FROM employees_uk;

-- CASE WHEN
	
SELECT name, 
       CASE 
           WHEN salary > 50000 THEN 'High'
           ELSE 'Low'
       END AS salary_category
FROM employees;


SELECT name, salary 
FROM employees 
WHERE salary > (SELECT AVG(salary) FROM employees);

-- RANKING with WINDOW FUNCTIONS

SELECT name, department,
       RANK() OVER (PARTITION BY department ORDER BY salary DESC) AS dept_rank
FROM employees;

-- CTE (Common Table Expression)

WITH high_salary AS (
  SELECT * FROM employees WHERE salary > 60000
)
SELECT * FROM high_salary WHERE department = 'Sales';

-- SELF JOIN

SELECT A.name AS Employee, B.name AS Manager
FROM employees A
JOIN employees B ON A.manager_id = B.id;

-- CORRELATED SUBQUERY

SELECT name, salary 
FROM employees e1
WHERE salary > (SELECT AVG(salary) FROM employees e2 WHERE e1.department_id = e2.department_id);

-- DELETE using JOIN / Subquery

DELETE FROM employees 
WHERE department_id IN (SELECT id FROM departments WHERE name = 'Temp');

-- Window: ROW_NUMBER, DENSE_RANK

SELECT name, ROW_NUMBER() OVER (ORDER BY salary DESC) AS row_num
FROM employees;
