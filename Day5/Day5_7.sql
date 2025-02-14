-- Day 5 ASSIGN 7
-----------------------------------------------------------------------------------------------------------

--1. List sum of salary for each department.
select deptno, sum(sal) "sum"
from emp
group by deptno;

--2. List department wise sum sal only if the sum for 
--any department is  > 10000.

SELECT DEPTNO, SUM(SAL)
FROM EMP
GROUP BY DEPTNO
HAVING SUM(SAL)>10000; 

--3. Display job wise sum of salary for all departments 
--except dept 30   if the sum salary is >3000.

SELECT JOB, SUM(SAL)
FROM emp
WHERE DEPTNO != 30 
GROUP BY  JOB
HAVING SUM(SAL) > 3000;

--4.Display job wise max sal only for managers, clerks,
-- salesman working in dept 10 and 20. Sort the data by des order 
-- of the max salary.
SELECT JOB, MAX(SAL)
FROM EMP 
WHERE DEPTNO IN (10, 20)
GROUP BY JOB 
HAVING JOB IN ('MANAGER', 'CLERK', 'SALESMAN')
ORDER BY MAX(SAL) DESC;


--5.Display job wise number of employees in all 
--the department with total salary > 3000

SELECT JOB, COUNT(*), SUM(SAL)
FROM EMP
GROUP BY JOB
HAVING SUM(SAL) > 3000;


--6.Display the department number having atleast 3 employees in it.

SELECT DEPTNO, COUNT(*)
FROM EMP
GROUP BY DEPTNO
HAVING COUNT(*) >= 3;

--8. Display deptno, salary sum and min(SAL) 
--for all employees who are managers.
SELECT DEPTNO, SUM(SAL), MIN(SAL)
FROM EMP 
WHERE JOB = 'MANAGER'
GROUP BY DEPTNO;


--9.Find sum(sal) for each dept having more than 2 clerk. 
SELECT DEPTNO, COUNT(*), SUM(SAL)
FROM EMP
WHERE JOB = 'CLERK'
GROUP BY DEPTNO
HAVING COUNT(*) >= 2;



--10.Calculate 
--how many employees earn sal more than 1500 in each dept
SELECT DEPTNO, COUNT(*)
FROM emp
WHERE SAL>1500
GROUP BY DEPTNO;


-----------------------------------------------------------------------------------------------------------
