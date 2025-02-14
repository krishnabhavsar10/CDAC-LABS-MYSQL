/*
	1. List all rooms which are allocated or not allocated to any courses. 
	Use joins.
*/

-- THE NULL IN CID AND CNAME REPRESENTS NO ROOM IS ALLOCATED
SELECT R.RID, R.RNAME, R.RLOC, C.CID, C.CNAME
FROM ROOM R
LEFT JOIN COURSES C
ON R.RID = C.RID;

--2. Display all products sold by Kirti.
---------------------------------------------------------------------------------
SELECT * FROM PRODUCT P
JOIN SALESMAN S
ON P.SID = S.SID AND S.SID = (SELECT SID FROM SALESMAN WHERE SNAME = 'KIRTI');
----------------------------------------------------------------------------------
SELECT P.PID, P.PNAME, P.PRICE, P.QTY, S.SID, S.SNAME
FROM PRODUCT P
JOIN SALESMAN S
ON P.SID = S.SID
WHERE S.SID = (SELECT SID FROM SALESMAN WHERE SNAME='KIRTI');
------------------------------------------------------------------------------------

--3. Consider emp and dept  table display 
--   empno, ename, deptno, dname and loc for all employees.
SELECT E.EMPNO, E.ENAME, D.DEPTNO, D.DNAME, D.LOC
FROM EMP E
JOIN DEPT D
ON E.DEPTNO = D.DEPTNO;

--4. Consider emp and dept  table display 
--   empno,ename,deptno, dname and loc for all 
--   employees who are working as managers.
------------------------------------------------------
SELECT E.EMPNO, E.ENAME, D.DEPTNO, D.DNAME, D.LOC
FROM EMP E
JOIN DEPT D
ON E.DEPTNO = D.DEPTNO
WHERE E.JOB = 'MANAGER';
-----------------------------------------------------
SELECT E.EMPNO, E.ENAME, D.DEPTNO, D.DNAME, D.LOC
FROM EMP E
JOIN DEPT D
ON E.DEPTNO = D.DEPTNO AND 
E.EMPNO IN (SELECT EMPNO FROM EMP WHERE JOB = 'MANAGER');
----------------------------------------------------------


--5. Consider emp and dept table dispaly deptno and dname to whom 
--employees are assingned and also the depts to whom  employees are not 
--assigned.
  
SELECT DISTINCT D.DNAME, D.DEPTNO 
FROM DEPT D
LEFT JOIN EMP E
ON E.DEPTNO = D.DEPTNO;


--6. From emp table, display empno,ename,mgr and name of 
--manager for each employee.

SELECT E.EMPNO, E.ENAME, E.JOB, M.ENAME
FROM EMP E 
JOIN EMP M
ON E.MGR = M.EMPNO;

--7. Create following table and insert the required data.create table Product_table(   pid  int,   pname varchar (20),   sid int );
/*
  sid is sample id which is given as a free sample on every product sold
  pid pnames id 
   1  Pen    2 
   2  Pencil 3
   3  Eraser 2
   4  Sketch Pens 1
*/

CREATE TABLE Product_table (
    pid INT, 
    pname VARCHAR(20), 
    sid INT
);

INSERT INTO Product_table (pid, pname, sid) 
VALUES
    (1, 'Pen', 2),
    (2, 'Pencil', 3),
    (3, 'Eraser', 2),
    (4, 'Sketch Pens', 1);

--Write a query to display pid, pname, sid and sample name for all the products.

SELECT P.PID, P.PNAME, P.SID, S.PNAME
FROM PRODUCT_TABLE P
JOIN PRODUCT_TABLE S
ON P.SID = S.PID
ORDER BY P.PID;