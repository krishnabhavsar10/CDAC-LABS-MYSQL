Day 6 ASSIGN 9
---------------------------------------------------------------------------------------

-- Day 6 Assign 9

-- 1. Display all employees who earn sal more that Smith earns.
SELECT * FROM EMP 
WHERE SAL > (SELECT SAL FROM EMP WHERE ENAME = 'SMITH')
ORDER BY SAL;

-- 2. Display all employees who are working in Smith's department.
SELECT * FROM EMP
WHERE DEPTNO = (SELECT DEPTNO FROM EMP WHERE ENAME = 'SMITH');
 
-- 3. Display all employees who earn salary < Scott and salary > Adams sal.
SELECT * FROM EMP
WHERE (SELECT SAL FROM EMP WHERE ENAME = 'ADAMS') < SAL AND
				  (SELECT SAL FROM EMP WHERE ENAME = 'SCOTT') > SAL
ORDER BY SAL;

 
--4. Display all employees with salary > either Ward's  salary or Blake's sal.
SELECT * FROM EMP
WHERE SAL > ANY(
				(SELECT SAL FROM EMP WHERE ENAME IN ('WARD', 'BLAKE'))	
				)
ORDER BY SAL;
 
--5. Display all employees who earn more than average sal of dept 10.
SELECT * FROM EMP 
WHERE SAL > (SELECT AVG(SAL) FROM EMP WHERE DEPTNO = 10);

--6. Display all employees who are working in research department.
SELECT * FROM EMP
WHERE DEPTNO = (SELECT DEPTNO FROM DEPT WHERE DNAME = 'RESEARCH');
 
--5. Display deptno, sum of salary  and min(sal) for all employees who are managers.
SELECT DEPTNO, SUM(SAL), MIN(SAL)
FROM EMP
WHERE JOB = 'MANAGER'
GROUP BY DEPTNO;

----------------------------------------
SELECT DEPTNO, ENAME, SAL, JOB,
SUM(SAL) OVER(PARTITION BY JOB) AS SUM, 
MIN(SAL) OVER(PARTITION BY JOB) AS MIN
FROM EMP
WHERE JOB IN (SELECT JOB FROM EMP WHERE JOB = 'MANAGER');
-------------------------------------------

/*
Create following tables and solve the  queries

1. create tAble category(cid int primary key auto_increment, cname varchar (15) unique not null, description varchar(30))
-----------------------------------------------------          
cid    cname                   description
------------------------------------------------------
1      chips                   very crunchy
2      chocolate               very chocolaty
3      snacks                  yummy
4      cold drinks             thanda thanda cool cool
*/

CREATE TABLE category (
	cid INT PRIMARY KEY AUTO_INCREMENT,
	cname VARCHAR(15) UNIQUE NOT NULL,
	description VARCHAR(30)
);

-- Insert the given data into the category table
INSERT INTO category (cname, description) VALUES 
('chips', 'very crunchy'),
('chocolate', 'very chocolaty'),
('snacks', 'yummy'),
('cold drinks', 'thanda thanda cool cool');


/*
2. create table Product(pid  int primary key, pname varchar (20), price float (6,2) default 20.00, qty int check(qty>0)  
   cid int  ,   sid int,   constraint fk_cid foreign key(cid) references category(cid) on delete set null, 
   constraint fk_sid foreign key(sid) references salesman(sid));
-----------------------------------------------------------------------
   prodid      pname         qty        price       catid        sid 
-----------------------------------------------------------------------
   123         lays          30         30.00        1           12
   111         pepsi         40         50.00        4           11
   134         nachos        50         50.00        1           12
   124         dairy milk    40         60.00        2           14 
   125         pringles      40         60.00        1           14
   213         Sketch Pens   56         150.00       null        11
   167         eraser        90         5.00         null        null
*/

CREATE TABLE product (
    pid INT PRIMARY KEY,
    pname VARCHAR(20),
    price FLOAT(6,2) DEFAULT 20.00,
    qty INT CHECK(qty > 0),
    cid INT,
    sid INT,
    CONSTRAINT fk_cid FOREIGN KEY(cid) REFERENCES category(cid) ON DELETE SET NULL,
    CONSTRAINT fk_sid FOREIGN KEY(sid) REFERENCES salesman(sid)
);

-- Insert the given data into the product table
INSERT INTO product (pid, pname, price, qty, cid, sid) VALUES
(123, 'lays', 30.00, 30, 1, 12),
(111, 'pepsi', 50.00, 40, 4, 11),
(134, 'nachos', 50.00, 50, 1, 12),
(124, 'dairy milk', 60.00, 40, 2, 14),
(125, 'pringles', 60.00, 40, 1, 14),
(213, 'Sketch Pens', 150.00, 56, NULL, 11),
(167, 'eraser', 5.00, 90, NULL, NULL);


/*
3. create table salesman(sid int primary key, sname varchar (15) unique not null, city varchar(15))
--------------------------------- 
sid     sname           city
---------------------------------
11      Rahul           Pune
12      Kirti           Mumbai
13      Prasad          Nashik
14      Arnav           Amravati
*/

CREATE TABLE salesman (
    sid INT PRIMARY KEY,
    sname VARCHAR(15) UNIQUE NOT NULL,
    city VARCHAR(15)
);

-- Insert the given data into the salesman table
INSERT INTO salesman (sid, sname, city) VALUES
(11, 'Rahul', 'Pune'),
(12, 'Kirti', 'Mumbai'),
(13, 'Prasad', 'Nashik'),
(14, 'Arnav', 'Amravati');





--1. List all pid, pname, cid, cname  with category chips 

SELECT P.PID, P.PNAME, C.CID , C.CNAME
FROM PRODUCT P, CATEGORY C
WHERE P.CID = C.CID AND
      C.CID = (SELECT CID FROM CATEGORY WHERE CNAME = 'CHIPS');
 


--2. Display all products sold by kirti
SELECT * FROM PRODUCT
WHERE SID = (SELECT SID FROM SALESMAN WHERE SNAME = 'KIRTI');
 
--3. Display all salesmen who did not sell any product

SELECT * FROM SALESMAN 
WHERE SID NOT IN (SELECT SID FROM PRODUCT WHERE SID IS NOT NULL);

 
--4. Display all category for which no product is assigned
SELECT * FROM CATEGORY 
WHERE CID NOT IN(SELECT CID FROM PRODUCT WHERE CID IS NOT NULL);
 

--5. Display all products to which  category is  not assigned

SELECT * FROM PRODUCT 
WHERE CID IS NULL;

 
--6. List all salesmen who stays in city where  
-- name starts with P or N

SELECT * FROM salesman
WHERE REGEXP_LIKE(CITY, '^[PN].*');
 
 
--7. Add new column in salesman table by name credit limit.

ALTER TABLE salesman
ADD CREDIT_LIMIT INT ;


--8. Write a query which will display dept no 
--and dept names to which no employee is assigned dept  . 
--Use emp and dept table.

SELECT * FROM DEPT 
WHERE DEPTNO NOT IN (
					SELECT DEPTNO 
					FROM EMP 
					WHERE DEPTNO IS NOT NULL
					);