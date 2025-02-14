-- SQL DAY1

-- create insert and basic select

-- Create  following Tables. Use appropriate datatypes. Insert given rows in the tables.

-- create table vehicle(  vid int,  vname varchar(20),  price int,  discount int,  milage int,  details varchar(40));
/*
1.vehicle

vid   vname          price       discount        milage           details
-------------------------------------------------------------------------------------------------
1     Activa         80000         10            35              Two  wheeler. Sturdy.Milage 30 km
2     Santro         95000         20            20              Product of Hyandai.
3     Yamaha         160000        5             70              Sturdy and good milage 
4     i-10           300000        8             18              Good small car
5     WaganR         250000        10            25              Good milage car
6     Hero Splendor  75000         9             65              Best bike
7     Royal Enfild   190000        5             40              a royal bike

Note :discount is given in percentage.

*/

SHOW DATABASES;

CREATE DATABASE VEHICLE;

USE VEHICLE;

SHOW TABLES;

CREATE TABLE VEHICLE
(
	VID		INT,
	VNAME	VARCHAR(20),
	PRICE	INT,
	DISC    INT,
	MILEAGE INT,
	DETAILS	VARCHAR(40)
);

DESCRIBE VEHICLE;

INSERT INTO VEHICLE
VALUES(1, 'ACTIVA', 80000, 10, 35, 'TWO WHEELE. STURDY MILAGE. 30 KM'),
	(2, 'SANTRO', 95000, 20, 20, 'PRODUCT F HYUNDAI'),
	(3, 'YAMAHA', 160000, 5, 70, 'STURDY AND GOOD MILAGE'),
	(4, 'I-10', 300000, 8, 18, 'GOOD SMALL CAR'),
	(5, 'WAGONR', 250000, 10, 25, 'GOOD MILAGE CAR'),
	(6, 'SPLENDOR', 75000, 9, 65, 'BEST BIKE'),
	(7, 'ROYAL ENFIELD', 190000, 5, 40, 'A ROYAL BIKE');

/*
2. customer  

create table customer(custid int, cname varchar(15), location varchar(12))

custid    cname          location 
----------------------------------
1         Nilima         Pimpri
2         Ganesh         Pune
3         Kishor         Kothrud
4         Priya          Aundh
*/

CREATE TABLE CUSTOMER
(
	custid int, 
	cname varchar(15), 
	location varchar(12)
);

INSERT INTO CUSTOMER
VALUES(1, 'NILIMA', 'PIMPRI'),
	(2, 'GANESH', 'PUNE'),
	(3, 'KISHOR', 'KOTHRUD'),
	(4, 'PRIYA', 'AUNDH');

/*
3. salesman

create table salesman(sid int, sname varchar(12), city varchar(12), experience int)

sid    sname         city           experience
----------------------------------------------
10      Rajesh       mumbai           5
11      Seema        Pune             8 
12      Shailesh     Nagpur           7 
13      Rakhi        Pune             2
*/

CREATE TABLE SALESMAN
(
	sid int, 
	sname varchar(12), 
	city varchar(12), 
	experience int
);

INSERT INTO SALESMAN
VALUES(10, 'RAJESH', 'MUMBAI', 5),
	(11, 'SEEMA', 'PUNE', 8),
	(12, 'SHAILESH', 'NAGPUR', 7),
	(13, 'RAKHI', 'PUNE', 2);



/*
	mysql> select * from customer;
	+--------+--------+----------+
	| custid | cname  | location |
	+--------+--------+----------+
	|      1 | NILIMA | PIMPRI   |
	|      2 | GANESH | PUNE     |
	|      3 | KISHOR | KOTHRUD  |
	|      4 | PRIYA  | AUNDH    |
	+--------+--------+----------+
	4 rows in set (0.00 sec)

	mysql> select * from salesman;
	+------+----------+--------+------------+
	| sid  | sname    | city   | experience |
	+------+----------+--------+------------+
	|   10 | RAJESH   | MUMBAI |          5 |
	|   11 | SEEMA    | PUNE   |          8 |
	|   12 | SHAILESH | NAGPUR |          7 |
	|   13 | RAKHI    | PUNE   |          2 |
	+------+----------+--------+------------+
	4 rows in set (0.00 sec)

	mysql>select * from vehicle;
	+------+---------------+--------+------+---------+----------------------------------+
	| VID  | VNAME         | PRICE  | DISC | MILEAGE | DETAILS                          |
	+------+---------------+--------+------+---------+----------------------------------+
	|    1 | ACTIVA        |  80000 |   10 |      35 | TWO WHEELE. STURDY MILAGE. 30 KM |
	|    2 | SANTRO        |  95000 |   20 |      20 | PRODUCT F HYUNDAI                |
	|    3 | YAMAHA        | 160000 |    5 |      70 | STURDY AND GOOD MILAGE           |
	|    4 | I-10          | 300000 |    8 |      18 | GOOD SMALL CAR                   |
	|    5 | WAGONR        | 250000 |   10 |      25 | GOOD MILAGE CAR                  |
	|    6 | SPLENDOR      |  75000 |    9 |      65 | BEST BIKE                        |
	|    7 | ROYAL ENFIELD | 190000 |    5 |      40 | A ROYAL BIKE                     |
	+------+---------------+--------+------+---------+----------------------------------+
	7 rows
*/

--1. Display names of salesmen who work in Pune.   
SELECT SNAME
FROM SALESMAN 
WHERE CITY = 'PUNE';


--2. Delete customer from Pimpri area.
DELETE 
FROM CUSTOMER 
WHERE LOCATION = 'PIMPRI';

/*
3. Add some new customers 
 'Geeta' with custid 5 and area as 'Pimpri'. 
 'Raj'   with custid 6 and area as 'Aundh'  
 'Yash'  with custid 7 and area as 'Aundh'
*/

INSERT INTO CUSTOMER
VALUES(5, 'GEETA', 'PIMPRI'),
	(6, 'RAJ', 'AUNDH'),
	(7, 'YASH', 'AUNDH');

--4. Delete customer from area Aundh whose name is Priya. 
DELETE FROM CUSTOMER 
WHERE LOCATION = 'AUNDH' AND CNAME = 'PRIYA';

--5. Display information of vehicle , Royal Enfild.
SELECT * FROM VEHICLE 
WHERE VNAME = 'ROYAL ENFIELD';

--6. Display information of all Bikes.
SELECT * FROM VEHICLE 
WHERE MILAGE >= 35;

--7. If buying price of the vehicle is 75000 then change it to 80000.
UPDATE VEHICLE
SET PRICE = 80000
WHERE PRICE = 75000;
 
--8. Display information of vehicle i-10.
SELECT * FROM VEHICLE 
WHERE VNAME = 'I-10';

--9. Display vid, vname, price, details and total price for each vehicle. total price = price - discount
SELECT VID, VNAME, PRICE, DISC, DETAILS, 
ROUND(PRICE - (PRICE * DISC / 100), 2) AS 'TOTAL PRICE' 
FROM VEHICLE;
 
SELECT VID, VNAME, PRICE, DISC, DETAILS, 
PRICE - (PRICE * DISC / 100), 2 AS 'TOTAL PRICE' 
FROM VEHICLE; 
 
--10. Display all vehicles whose price is less than 100000.
SELECT * FROM VEHICLE 
WHERE PRICE < 100000;

--11. Display all the information of salesmen having experience more than 5 years.
SELECT * FROM SALESMAN 
WHERE experience > 5;
 
--12. Create a copy of table salesman as salesman1.

-- If you want to create a new table that has the same structure (column definitions, data types, etc.) 
-- but no data, you can use the CREATE TABLE statement with the LIKE clause.
-- This will create a new table called new_table_name that has the 
-- same columns, indexes, and constraints as the original_table_name, but no data.
CREATE TABLE SALESMAN LIKE SALESMAN1;

-- CREATES AND COPIES THE ENTIRE DATA
CREATE TABLE SALESMAN1 
AS 
	SELECT * FROM SALESMAN; 


--13. For the given schema, create the table and solve following queries

/*
employee(eno, ename, basic, incentives)  

eno    ename      basic        incentives
------------------------------------------
1      Rajesh     20000         1500
2      Sarita     25000         1000
3      Meera      15000         3000
4      Jitesh     30000         500
5      Ramesh     12000         3000
*/

CREATE TABLE EMPLOYEE
(
	ENO		INT,
	ENAME	VARCHAR(20),
	BASIC	INT,
	INCENTIVES	INT
);

INSERT INTO EMPLOYEE
VALUES(1,'RAJESH', 20000, 1500),
	(2,'SARITA', 25000, 1000),
	(3,'MEERA', 15000, 3000),
	(4,'JITESH', 30000, 500),
	(5,'RAMESH', 12000, 3000);

-- 1. List all employees having basic>15000
SELECT * FROM EMPLOYEE
WHERE BASIC > 15000;
 
-- 2. Change incentive of Jitesh to 1000.
UPDATE EMPLOYEE
SET INCENTIVES = 1000
WHERE ENAME = 'JITESH';
 
-- 3. Increase the salary of all employees by 5% who are earning less than 20000 as a basic pay. Update in the table.
UPDATE EMPLOYEE
SET BASIC = BASIC + (BASIC * 5 / 100)
WHERE BASIC < 20000;
 
-- 4. New employee Ajay joins the firm. His eno is 20, basic is 16000 and he is not eligible for incentives. Store this information in table.
INSERT INTO EMPLOYEE (ENO, ENAME, BASIC)
VALUES(20, 'AJAY', 16000);
 
-- 5. Meera leaves the company. Make necessary changes in table.
DELETE
FROM EMPLOYEE
WHERE ENAME = 'MEERA';
 
-- 6. Ramesh is promoted as Head Clerk and now earns salary as 60000. Write a query.    
UPDATE EMPLOYEE
SET BASIC = 60000
WHERE NAME = 'RAMESH';