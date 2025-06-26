CREATE DATABASE staff;
USE staff;

CREATE TABLE emp(
emp_id int,
emp_fname varchar(20) NOT NULL,
emp_lname varchar(20) NOT NULL,
address varchar(20) NOT NULL,
salary numeric
);

SELECT * FROM emp;

ALTER TABLE emp DROP COLUMN dep_if;

ALTER TABLE emp
ADD (emp_age int);

UPDATE emp
SET emp_age = 38
WHERE emp_id = 10;

ALTER TABLE emp
ADD (dep_id int);

ALTER TABLE emp ADD CONSTRAINT dep_fk FOREIGN KEY (dep_id) REFERENCES dep(dep_id);

ALTER TABLE emp
ADD (emp_email varchar(20));

ALTER TABLE emp ADD CONSTRAINT EMP_EMAIL UNIQUE (emp_email);

ALTER TABLE emp ADD CONSTRAINT EMP_ID PRIMARY KEY (emp_id);

DELETE FROM emp WHERE emp_id > 0;

CREATE TABLE dep(
dep_id int primary key,
dep_name varchar(20) not null,
dep_location varchar(20) not null
);

INSERT INTO dep (dep_id, dep_name, dep_location) VALUES
(6, 'IT', 'New York'),
(7, 'IT', 'Chicago'),
(8, 'IT', 'San Francisco'),
(9, 'IT', 'Los Angeles'),
(10, 'IT', 'Houston');


CREATE TABLE emp_dep(
emp_id int,
dep_id int,
constraint emp_fk foreign key (emp_id) references emp(emp_id),
constraint dep_fk foreign key (dep_id) references dep(dep_id)
);

DROP TABLE emp_dep;

INSERT INTO emp (emp_id, emp_fname, emp_lname, address, salary, emp_email) VALUES
(1, 'John', 'Doe', 'New York', 50000, 'emp1@gmail.com'),
(2, 'Jane', 'Smith', 'Los Angeles', 55000, 'emp2@gmail.com'),
(3, 'Alice', 'Johnson', 'Chicago', 60000, 'emp3@gmail.com'),
(4, 'Bob', 'Williams', 'Houston', 52000, 'emp4@gmail.com'),
(5, 'Charlie', 'Brown', 'Phoenix', 58000, 'emp5@gmail.com'),
(6, 'Emily', 'Clark', 'San Diego', 61000, 'emily.clark@example.com'),
(7, 'David', 'Lee', 'Dallas', 62000, 'david.lee@example.com'),
(8, 'Sophia', 'Lopez', 'Seattle', 59000, 'sophia.lopez@example.com'),
(9, 'Michael', 'Nguyen', 'Miami', 64000, 'michael.nguyen@example.com'),
(10, 'Olivia', 'Turner', 'Atlanta', 63000, 'olivia.turner@example.com');

ALTER TABLE emp MODIFY COLUMN emp_email varchar(40);

UPDATE emp SET salary =  salary - 1000 WHERE emp_id = 2;

UPDATE emp SET address = 'Muscat', salary = 200000
WHERE emp_id = 1;

#set same address to other emp
UPDATE emp AS e1
JOIN (
  SELECT address FROM emp WHERE emp_fname = 'John' LIMIT 1
) AS e2
SET e1.address = e2.address
WHERE e1.emp_id = 3;

UPDATE emp 
SET EMP_EMAIL = 'emp3@gmail.com'
WHERE EMP_ID = 3;

SELECT * FROM emp;

#set name for the column
SELECT salary AS 'Employees Salary' FROM emp;

#adding bouns to the salary
SELECT emp_fname, salary+(salary * 0.05) FROM emp;

DELETE FROM emp WHERE emp_id = 1;

#select 2 row from emp table
SELECT * FROM emp LIMIT 2;

#select emp that are greater than 2 and 4
SELECT * FROM emp WHERE emp_id > any(SELECT emp_id FROM emp WHERE emp_id BETWEEN 2 AND 4);

#select emp where second letter is o 
SELECT * FROM emp WHERE emp_fname LIKE '_o%';

SELECT * FROM emp WHERE emp_fname NOT LIKE '_o%';

#select emp where the emp_id is 2,4,and 6
SELECT * FROM emp WHERE emp_id IN (2,4,6);

SELECT * FROM emp WHERE emp_id NOT IN (2,4,6);

#select all emp between 2 and 6
SELECT * FROM emp WHERE emp_id BETWEEN 2 AND 6;

#order fanme by ascending and lname by descending
SELECT * FROM emp ORDER BY emp_fname ASC, emp_lname DESC;

#select emp and jobs title    
SELECT e.emp_fname AS 'Employee Name', d.dep_name AS 'Job Title' FROM emp e, dep d WHERE e.emp_id = d.dep_id ORDER BY e.emp_fname;

SELECT CONCAT(emp_fname ,' ', emp_lname,' ,',address) AS 'Employee Full Name and Address' FROM emp;

SELECT CONCAT(emp_fname,' ', emp_lname,' ,', emp_age) AS 'Employee Full Name and age' FROM emp;

SELECT dep_name, COUNT(dep_location) AS 'Number of Locations of department' FROM dep GROUP BY dep_name;
#-------------------------------------------------------------------------------------------------------------------------------------------------

