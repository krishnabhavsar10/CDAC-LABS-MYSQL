-- DAY 4 ASSIGN 5

ALTER TABLE CUSTOMER
ADD CONSTRAINT PK_CUSTID PRIMARY KEY(CUSTID);

ALTER TABLE VEHICLE
ADD CONSTRAINT PK_VID PRIMARY KEY(VID);

ALTER TABLE SALESMAN
ADD CONSTRAINT PK_SID PRIMARY KEY(SID);

CREATE TABLE TRANSACTION
(
	TID INT,
	CUSTID INT,
	VID INT,
	SID INT,
	BUYPRICE INT,
	CONSTRAINT PK_TID PRIMARY KEY(TID),
	CONSTRAINT FK_VID FOREIGN KEY(VID) REFERENCES VEHICLE(VID),
	CONSTRAINT FK_CUSTID FOREIGN KEY(CUSTID) REFERENCES CUSTOMER(CUSTID),
	CONSTRAINT FK_SID FOREIGN KEY(SID) REFERENCES salesman(SID)
);

-------------------------------------------------------------------------

CREATE TABLE `TRANSACTION` (
    TID INT NOT NULL,
    CUSTID INT NOT NULL,
    VID INT,
    SID INT NOT NULL,
    BUYPRICE INT,
    CONSTRAINT PK_TRANSACTION_TID PRIMARY KEY (TID),
    CONSTRAINT FK_TRANSACTION_VID FOREIGN KEY (VID) 
        REFERENCES CVEH (VID) 
        ON DELETE SET NULL ON UPDATE SET NULL,
    CONSTRAINT FK_TRANSACTION_CUSTID FOREIGN KEY (CUSTID) 
        REFERENCES CCUST (CUSTID) 
        ON DELETE CASCADE,
    CONSTRAINT FK_TRANSACTION_SID FOREIGN KEY (SID) 
        REFERENCES Csal (SID) 
        ON UPDATE CASCADE
);

---------------------------------------------------------------------------


INSERT INTO TRANSACTION
VALUES(1, 1, 7, 10, 80000),
(2, 2, 5, 11, 250000),
(3, 3, 4, 12, 300000),
(4, 4, 2, 13, 119000);



--1. Display tid,custid,customer name and buy_price. 

SELECT * FROM TRANSACTION;

SELECT C.CNAME, V.VNAME, S.SNAME, BUYPRICE
FROM 
	CUSTOMER C, 
	VEHICLE V, 
	SALESMAN S, 
	TRANSACTION T
	
WHERE T.CUSTID = C.CUSTID AND T.VID = V.VID AND T.SID = S.SID;


--2.Dispaly tid,custid,customer name,vid,vehicle name, sid, salesmen name and 
--buy_price for vehicle.
 
 
SELECT T.TID, C.CUSTID, C.CNAME, V.VID, V.VNAME, S.SID, S.SNAME, BUYPRICE
FROM 
	CUSTOMER C, 
	VEHICLE V, 
	SALESMAN S, 
	TRANSACTION T
WHERE T.CUSTID = C.CUSTID AND T.VID = V.VID AND T.SID = S.SID; 
 

--Consider emp, dept and salgrade tables to answer following queries.

--1.List details of employees as ename,deptno,dname,sal,comm. 
SELECT  E.ENAME, D.DEPTNO, D.DNAME, E.SAL, E.COMM
FROM 
	EMP E, 
	DEPT D  
WHERE E.DEPTNO = D.DEPTNO ;  
 
--2. Display details of employees as empno,ename,sal,job, deptno and dept name 
--for all employees working as a clerk or salesman and earning  

SELECT E.EMPNO, E.ENAME, E.SAL, E.JOB, D.DEPTNO, D.DNAME
FROM EMP E, DEPT D  
WHERE E.DEPTNO = D.DEPTNO AND E.JOB IN ('CLERK', 'SALESMAN') AND SAL IS NOT NULL;

-- BETTER ALTERNATIVE USING JOINS
SELECT 
    E.EMPNO, 
    E.ENAME, 
    E.SAL, 
    E.JOB, 
    D.DEPTNO, 
    D.DNAME
FROM 
    EMP E
JOIN 
    DEPT D 
ON 
    E.DEPTNO = D.DEPTNO
WHERE 
    E.JOB IN ('CLERK', 'SALESMAN') 
    AND E.SAL IS NOT NULL;


--3. List details of employees as ename,deptno,dname,sal,comm working in dept
-- 20 and 30 who did not get any commission.   
SELECT E.ENAME, D.DEPTNO, D.DNAME, E.SAL, E.COMM
FROM EMP E, DEPT D  
WHERE E.DEPTNO = D.DEPTNO AND (E.DEPTNO = 20 OR E.DEPTNO = 30) AND COMM IS  NULL;


--4. Display ename,sal and grade of employee(use salgrade table).

SELECT E.ENAME,  E.SAL, S.GRADE
FROM EMP E, SALGRADE S  
WHERE E.SAL BETWEEN S.LOSAL AND S.HISAL ;

 
 
--5. Display the information of department i.e deptno, dname and loc in
-- which clerks are working. 

SELECT  E.ENAME, D.DEPTNO, D.DNAME, D.LOC
FROM EMP E, DEPT D  
WHERE E.DEPTNO = D.DEPTNO AND E.JOB = 'CLERK';



mysql> SELECT * FROM TRANSACTION;
+-----+--------+------+------+----------+
| TID | CUSTID | VID  | SID  | BUYPRICE |
+-----+--------+------+------+----------+
|   1 |      1 |    7 |   10 |    80000 |
|   2 |      2 |    5 |   11 |   250000 |
|   3 |      3 |    4 |   12 |   300000 |
|   4 |      4 |    2 |   13 |   119000 |
+-----+--------+------+------+----------+
4 rows in set (0.00 sec)

mysql> SELECT * FROM CUSTOMER;
+--------+---------+----------+
| custid | cname   | location |
+--------+---------+----------+
|      1 | VIKRANT | KOLHAPUR |
|      2 | GANESH  | PUNE     |
|      3 | KISHOR  | KOTHRUD  |
|      4 | KRISHNA | EVEREST  |
+--------+---------+----------+
4 rows in set (0.00 sec)

mysql> SELECT * FROM SALESMAN;
+-----+----------+--------+------------+
| sid | sname    | city   | experience |
+-----+----------+--------+------------+
|  10 | RAJESH   | MUMBAI |          5 |
|  11 | SEEMA    | PUNE   |          8 |
|  12 | SHAILESH | NAGPUR |          7 |
|  13 | RAKHI    | PUNE   |          2 |
+-----+----------+--------+------------+
4 rows in set (0.00 sec)

mysql> SELECT * FROM VEHICLE;
+-----+---------------+--------+------+--------+----------------------------------+
| VID | VNAME         | PRICE  | DISC | MILAGE | DETAILS                          |
+-----+---------------+--------+------+--------+----------------------------------+
|   1 | ACTIVA        |  80000 |   10 |     35 | TWO WHEELE. STURDY MILAGE. 30 KM |
|   2 | SANTRO        |  95000 |   20 |     20 | PRODUCT F HYUNDAI                |
|   3 | YAMAHA        | 160000 |    5 |     70 | STURDY AND GOOD MILAGE           |
|   4 | I-10          | 300000 |    8 |     18 | GOOD SMALL CAR                   |
|   5 | WAGONR        | 250000 |   10 |     25 | GOOD MILAGE CAR                  |
|   6 | SPLENDOR      |  80000 |    9 |     65 | BEST BIKE                        |
|   7 | ROYAL ENFIELD | 190000 |    5 |     40 | A ROYAL BIKE                     |
+-----+---------------+--------+------+--------+----------------------------------+
7 rows in set (0.00 sec)

