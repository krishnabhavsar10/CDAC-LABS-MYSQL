--Day 6 ASSIGN 10
---------------------------------------------------------------------------------------

--1. Practise set operators

CREATE TABLE STUDENTS_2024 (
    STUDENT_ID INT PRIMARY KEY,
    NAME VARCHAR(50),
    COURSE VARCHAR(50)
);

CREATE TABLE STUDENTS_2023 (
    STUDENT_ID INT PRIMARY KEY,
    NAME VARCHAR(50),
    COURSE VARCHAR(50)
);

-- Insert data into STUDENTS_2024
INSERT INTO STUDENTS_2024 (STUDENT_ID, NAME, COURSE) VALUES
(1, 'Alice', 'Mathematics'),
(2, 'Bob', 'Physics'),
(3, 'Carol', 'Computer Science'),
(4, 'David', 'Economics'),
(5, 'Eve', 'Biology');

-- Insert data into STUDENTS_2023
INSERT INTO STUDENTS_2023 (STUDENT_ID, NAME, COURSE) VALUES
(3, 'Carol', 'Computer Science'),
(4, 'David', 'Economics'),
(6, 'Frank', 'Chemistry'),
(7, 'Grace', 'Literature'),
(8, 'Heidi', 'History');

--1
--UNION
	SELECT * FROM STUDENTS_2024
    UNION
    SELECT * FROM STUDENTS_2023;
	
	-- ORDER WILL DIFFER
	SELECT * FROM STUDENTS_2023
    UNION
    SELECT * FROM STUDENTS_2024;

--UNION ALL
    SELECT * FROM STUDENTS_2024
    UNION ALL
    SELECT * FROM STUDENTS_2023;
	
	SELECT * FROM STUDENTS_2023
    UNION ALL
    SELECT * FROM STUDENTS_2024;
	
--INTERSECT
	SELECT * FROM STUDENTS_2023
    INTERSECT
    SELECT * FROM STUDENTS_2024;
	
--EXCEPT/MINUS OPERATOR

	SELECT * FROM STUDENTS_2023
    EXCEPT
    SELECT * FROM STUDENTS_2024;
	
	SELECT * FROM STUDENTS_2024
    EXCEPT
    SELECT * FROM STUDENTS_2023;
/*	
2. Practice on delete set null/ cascade
            on update set null/ cascade
*/			
CREATE TABLE departments (
	dept_id INT PRIMARY KEY AUTO_INCREMENT,
	dept_name VARCHAR(50) NOT NULL,         
	location VARCHAR(50)                   
);

INSERT INTO departments (dept_name, location) VALUES
('HR', 'New York'),
('IT', 'San Francisco'),
('Sales', 'Chicago'),
('Finance', 'London');
			
			
---ON DELETE CASCADE;		
CREATE TABLE employees 
(
	emp_id INT PRIMARY KEY AUTO_INCREMENT,   
	emp_name VARCHAR(50) NOT NULL,            
	emp_salary DECIMAL(10, 2),                
	dept_id INT,                              
	CONSTRAINT fk_dept_id FOREIGN KEY (dept_id) REFERENCES departments(dept_id) 
	ON DELETE CASCADE                         
);


INSERT INTO employees (emp_name, emp_salary, dept_id) VALUES
	('Alice Johnson', 70000.00, 1),  
	('Bob Smith', 80000.00, 2),    
	('Charlie Brown', 75000.00, 3), 
	('David White', 90000.00, 2),   
	('Eve Black', 60000.00, 4);    

DELETE FROM departments WHERE DEPT_NAME = 'HR';
			
----ON DELETE SET NULL
ALTER TABLE EMPLOYEES	
DROP CONSTRAINT fk_dept_id;

ALTER TABLE EMPLOYEES
ADD CONSTRAINT FK_DEPT_ID FOREIGN KEY(DEPT_ID) 
REFERENCES departments(dept_id)	
ON DELETE SET NULL;	
  
DELETE FROM departments WHERE DEPT_NAME = 'IT';
			
--- ON UPDATE cascade
DROP TABLE EMPLOYEES;
DROP TABLE DEPARTMENTS;
			
CREATE TABLE departments 
(
	dept_id INT PRIMARY KEY AUTO_INCREMENT,
	dept_name VARCHAR(50) NOT NULL,         
	location VARCHAR(50)                   
);

INSERT INTO departments (dept_name, location) VALUES
	('HR', 'New York'),
	('IT', 'San Francisco'),
	('Sales', 'Chicago'),
	('Finance', 'London');
			
			
CREATE TABLE employees 
(
	emp_id INT PRIMARY KEY AUTO_INCREMENT,   
	emp_name VARCHAR(50) NOT NULL,            
	emp_salary DECIMAL(10, 2),                
	dept_id INT,                              
	CONSTRAINT fk_dept_id FOREIGN KEY (dept_id) REFERENCES departments(dept_id) 
	ON UPDATE CASCADE                         
);


INSERT INTO employees (emp_name, emp_salary, dept_id) VALUES
	('Alice Johnson', 70000.00, 1),  
	('Bob Smith', 80000.00, 2),    
	('Charlie Brown', 75000.00, 3), 
	('David White', 90000.00, 2),   
	('Eve Black', 60000.00, 4);   
			
UPDATE  departments
SET DEPT_ID = 10
WHERE DEPT_NAME = 'HR';
			
------ ON UPDATE NULL
DROP TABLE EMPLOYEES;
DROP TABLE DEPARTMENTS;

CREATE TABLE departments 
(
	dept_id INT PRIMARY KEY AUTO_INCREMENT,
	dept_name VARCHAR(50) NOT NULL,         
	location VARCHAR(50)                   
);


INSERT INTO departments (dept_name, location) VALUES
	('HR', 'New York'),
	('IT', 'San Francisco'),
	('Sales', 'Chicago'),
	('Finance', 'London');
			
			
CREATE TABLE employees 
(
	emp_id INT PRIMARY KEY AUTO_INCREMENT,   
	emp_name VARCHAR(50) NOT NULL,            
	emp_salary DECIMAL(10, 2),                
	dept_id INT,                              
	CONSTRAINT fk_dept_id FOREIGN KEY (dept_id) REFERENCES departments(dept_id) 
	ON UPDATE SET NULL                      
);


INSERT INTO employees (emp_name, emp_salary, dept_id) VALUES
	('Alice Johnson', 70000.00, 1),  
	('Bob Smith', 80000.00, 2),    
	('Charlie Brown', 75000.00, 3), 
	('David White', 90000.00, 2),   
	('Eve Black', 60000.00, 4);   
			
UPDATE  departments
SET DEPT_ID = 10
WHERE DEPT_NAME = 'HR';
			
--3. Practise auto_increment

CREATE TABLE employees1 
(
	emp_id INT  AUTO_INCREMENT,
	emp_name VARCHAR(50) NOT NULL,
	CONSTRAINT PK PRIMARY KEY(EMP_ID)
);

INSERT INTO employees1 (emp_id, emp_name)
VALUES 
	(1, 'Alice Johnson'), 
	(2, 'Bob Smith');
		
		
INSERT INTO EMPLOYEES1(EMP_NAME)
VALUES('MANSI');