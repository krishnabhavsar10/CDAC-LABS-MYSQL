--DAY 2 ASSIGNMENT 2

--1. Display vid, vname, price and details from table vehicle with column heading as Vehicle id, vehicle name, price, discount and details.
SELECT 
	VID "VEHICLE ID", 
	VNAME "VEHICLE NAME", 
	PRICE "PRICE", 
	DISC "DISCOUNT",  
	DETAILS "DETAILS" 
FROM VEHICLE;


--2. Create a copy of table customer and salesman by name customer1 and salesman1
CREATE TABLE CUSTOMER1
AS 
	SELECT * FROM CUSTOMER;

CREATE TABLE SALESMAN1
AS 
	SELECT * FROM SALESMAN;

--3. List all records with sal > 2000 and comm>200
SELECT * FROM EMP 
WHERE SAL > 2000 AND IFNULL(COMM, 0) > 200;

--4. List all records where job=’Clerk’ or sal>2000
SELECT * FROM EMP 
WHERE SAL> 1000 OR JOB = "CLERK";

--5. List all the records with sal=1250 or 1100 
SELECT * FROM EMP 
WHERE SAL IN(1250,1100);
 
--6. List all employees with sal>1250 and <2850
SELECT * FROM EMP 
WHERE SAL BETWEEN 1250 AND 2850; --inclusive in nature

--7. Retrieve the details (Name, Salary and dept no) of the emp who are working in department no 20
SELECT ENAME, SAL, DEPTNO
FROM EMP 
WHERE DEPTNO = 20;
 
--8. Display all employees who have joined after 9th june 81.
SELECT * FROM EMP
WHERE HIREDATE > '1981-06-09'; 
 
--9. Display empno,empname,sal, comm and total salary. Total Salary = comm + sal
SELECT EMPNO, ENAME, SAL, 
	IFNULL(COMM,0),
	SAL + IFNULL(COMM,0) AS "TOTAL SALARY"
FROM EMP;

--10. Display empname,deptno,dname for all employees.
SELECT ENAME, DEPTNO, JOB
FROM EMP;

 
--11. Display empname,deptno,dname for Smith.
SELECT E.ENAME, D.DEPTNO, D.DNAME
FROM EMP E, DEPT D 
WHERE E.DEPTNO = D.DEPTNO AND E.ENAME = 'SMITH';
 
--12. Display all employees with sal >2000 or job is either clerk or Salesman.
SELECT * FROM EMP
WHERE SAL>2000 OR JOB IN('CLERK', 'SALESMAN'); 
 
--13. List the employees in dept 20 and 30 who did not get any commission.
SELECT * FROM EMP
WHERE DEPTNO IN(20,30) AND COMM IS NULL;
 
--14. Display all employees who works in either dept 10 or 30 or joined in year 1982
SELECT * FROM EMP
WHERE DEPTNO IN(10,30) OR HIREDATE LIKE '1982%';
 
--15. There is a salary hike by 20% . Display the information from emp table as empno,ename,sal and new sal.
SELECT EMPNO, ENAME, SAL, SAL+SAL*0.2 "NEW SAL"
FROM EMP;
 
--16. Create new table emp100 same as emp without any data. Check it's structure.
CREATE TABLE EMP100 
AS 
SELECT * FROM EMP 
WHERE 1=2;
 
--17. Insert new row with data of your choice in emp10 table where manager(mgr) is null.
INSERT INTO EMP100 
VALUES(11, 'MANSI', 'DEVELOPER', 2010, '2025-02-15', 99999.99, 20000.22, 10 );

INSERT INTO EMP100 
VALUES(11, 'MANSI', 'DEVELOPER', NULL, '2025-02-15', 99999.99, 20000.22, 10 );
 
--18. Display the emp details who do not have manager.
SELECT * FROM EMP100
WHERE MGR IS NULL;
 
--19. Use emp100 table to perform following query 
--  Update employee salary. Increase sal of each employee by 15% of (sal+comm), change the mgr to 777 for all employees in dept 10. 
UPDATE EMP10 
SET SAL = SAL + ROUND((SAL + IFNULL(COMM, 0)) * 0.15,  2);

UPDATE EMP100
SET MGR = 777
WHERE DEPTNO = 10;

--20. Display all employees who joined between years 1981 to 1983.
SELECT * FROM EMP
WHERE HIREDATE LIKE '1981%' OR HIREDATE LIKE '1982%';

SELECT * FROM EMP
WHERE YEAR(HIREDATE) BETWEEN '1981' AND '1982';


--21. Display empno, name and department number of an emp working under manager with id 7698.
SELECT EMPNO, ENAME, DEPTNO, MGR
FROM EMP
WHERE MGR = 7698;
 
--22. List all managers working in dept 10.   
SELECT * FROM EMP
WHERE JOB = 'MANAGER' AND DEPTNO = 10;

--23. Display all jobs from emp table. 
SELECT DISTINCT JOB
FROM EMP;
 
--24. Display all unique  deptnos in which employees are working.
SELECT DISTINCT DEPTNO
FROM EMP;
 
--25. Implement following using case statement. Use data from emp database. 

/*
26. Company decides to give salary rise with following percentage.
    Using case statement display the data as below
    ename,job,sal,new sal
    Generate new sal and display with proper heading.
    clerk 7%
    analyst 5%
    manager %2
    others no rise
*/
 
SELECT ENAME, JOB, SAL, 
CASE 
	WHEN JOB = 'CLERK'   THEN SAL + ROUND(SAL * 0.07, 0)
	WHEN JOB = 'ANALYST' THEN SAL + ROUND(SAL * 0.05, 0)
	WHEN JOB = 'MANAGER' THEN SAL + ROUND(SAL * 0.02, 0)
	ELSE SAL
END 'NEW SAL'
FROM EMP;