-- DAY 4 ASSIGN 6

--Constraints in RDBMS

--1. Create new table dept100 having same structure and data as that of dept table.
CREATE TABLE DEPT100 
AS 
SELECT * FROM DEPT;

--1.Create new table emp100 having same structure and data as that of emp table.
CREATE TABLE EMP100 
AS 
SELECT * FROM EMP;

--2.Add primary key constraint on deptno for dept100 table.
ALTER TABLE DEPT100 
ADD CONSTRAINT PK_DEPTNO PRIMARY KEY(DEPTNO);

--3.Add primary key constraint on empno for emp100 table. Check structure of both the tables.
ALTER TABLE EMP100 
ADD CONSTRAINT PK_EMPNO PRIMARY KEY(EMPNO);

--================================================================================================
/*
2. Create following tables for given schema. Apply constraints as mentioned in the schema.
trainer(tid PK, tname not null , cid fk, salary default 20000,experience in years check >10 )
tid     tname            cid        salary      experience
----------------------------------------------------------------
t1      Amit             c2          your   own   data 
t2      Rajan            c1          your   own   data  
t3      Shruti           c2          your   own   data
t4      Arti             c2          your   own   data 
t5      Sameer           c3          your   own   data 
t6      Sanjay           null        your   own   data 
t7      Soha             null        your   own   data	
*/
CREATE TABLE TRAINER
(
	TID VARCHAR(10),
	TNAME VARCHAR(20) NOT NULL,
	CID VARCHAR(2),
	SALARY INT DEFAULT 20000,
	EXPERIENCE INT CHECK(EXPERIENCE > 10),
	CONSTRAINT PK_TID PRIMARY KEY(TID),
	CONSTRAINT FK_CID FOREIGN KEY(CID) REFERENCES COURSE(CID)
);

INSERT INTO TRAINER 
VALUES ('T1',  'AMIT',    'C1',  21000,  11),
('T2',  'RAJAN',   'C2',  22000,  21),
('T3',  'SHRUTI',  'C3',  23000,  31),
('T4',  'ARTI',    'C4',  24000,  41),
('T5',  'SAMEER',  'C5',  25000,  51),
('T6',  'SANJAY',  NULL,  26000,  61),
('T7',  'SOHA',    NULL,  27000,  71);

/*
Try adding following data in the trainer table
 (T2,'Mahesh',null,16000,12)	// ERROR T2 EXISTS
 (t8,'Meena',c3,25000,11)       // VALID
 (t9,null,c2,30000,10)			// NULL NOT ALLOWED
 (t10,'Soham',c2,35000,8)		// CHECK CONDITION FAILED
 (t11,'Anil',c3,null,11)		// VALID
*/

-- ONLY WORKING QUERY
INSERT INTO TRAINER 
VALUES 
('T8',  'MEENA',   'C3',  25000,  11),
('T11', 'ANIL',    'C3',  NULL,  11);

-- Use delete FOR null VALUES IN cid while creating table.
DELETE FROM TRAINER
WHERE CID IS NULL;

/*
course(cid pk, cname unique not null, fees default500)
cid         cname                         fees
----------------------------------------------------      
 c1          Core                         7000 
 c2          Linux                        8000 
 c3          Data Structure              10000 
 c4          Python                      12000    
 c5          Dot Net                       null
*/

CREATE TABLE COURSE 
(
	CID VARCHAR(2),
	CNAME VARCHAR(30) UNIQUE NOT NULL,
	FEES INT DEFAULT 500,
	CONSTRAINT PK_CID PRIMARY KEY(CID)
);

INSERT INTO COURSE
VALUES('C1', 'CORE', 7000),
	('C2', 'LINUX', 8000),
	('C3', 'DATA STRUCTURE', 10000),
	('C4', 'PYTHON', 12000),
	('C5', 'DOT NET', NULL);

-- Try on delete set null.
DELETE FROM COURSE 
WHERE FEES IS NULL;

DELETE FROM TRAINER 
WHERE TID = 'T5';


-- Drop table trainer and create it again with on delete cascade clause
ALTER TABLE TRAINER
DROP CONSTRAINT FK_CID;

ALTER TABLE TRAINER
ADD CONSTRAINT FK_CID FOREIGN KEY(CID) REFERENCES COURSE(CID) ON DELETE CASCADE;

-- Try on delete  cascade on trainer table.
INSERT INTO COURSE
VALUES('C5', 'DOT NET', NULL);

INSERT INTO TRAINER 
VALUES('T5',  'SAMEER',  'C5',  25000,  51);

DELETE FROM COURSE 
WHERE FEES IS NULL;


/*

The DELETE CASCADE clause is used in relational database management systems (RDBMS) to automatically delete rows in a 
child table when the corresponding row in the parent table is deleted. It is typically used to maintain referential integrity between related tables.

How it works:
When you set up a foreign key relationship between two tables, you can specify the ON DELETE CASCADE option. 
This ensures that if a record in the parent table is deleted, all related records in the child table are automatically deleted as well, 
without needing to manually delete them.

Example:
Consider two tables: orders (parent table) and order_items (child table). Each order can have multiple items, and the order_items table contains a foreign key that references the orders table.

sql
Copy code
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE
);

CREATE TABLE order_items (
    item_id INT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    FOREIGN KEY (order_id) REFERENCES orders(order_id) ON DELETE CASCADE
);
In this example, if an order is deleted from the orders table, all corresponding items in the order_items table that are associated with that order will also be automatically deleted, thanks to the ON DELETE CASCADE constraint.

Key Points:
Parent-Child Relationship: The DELETE CASCADE rule applies to a parent-child relationship where the child table contains a foreign key referencing the parent table.
Automatic Deletion: When a row in the parent table is deleted, the corresponding rows in the child table are automatically deleted, ensuring no orphan records remain.
Integrity Maintenance: This maintains referential integrity, making sure that the child table doesn’t have references to non-existent parent rows.
Use cases:
When you have tables with dependent records (e.g., orders and order_items).
When you want to ensure that all associated records are cleaned up without having to manually delete them.
Caveats:
Cascading deletes can potentially delete a large number of records if not managed carefully, especially if there are multiple levels of related tables.
Ensure that you really want to remove all related data, as DELETE CASCADE can make data recovery difficult once executed.

*/
--------------------------------------------------------------------------------------------------------