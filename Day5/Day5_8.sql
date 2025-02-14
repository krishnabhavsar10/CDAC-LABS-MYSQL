-- Day 5 ASSIGN 8
-----------------------------------------------------------------------------------------------------------

--1. Display all empno,ename,deptno,sal,avg(sal),min(sal), max(sal).
SELECT EMPNO, ENAME, DEPTNO, SAL , 
AVG(SAL) OVER(PARTITION BY DEPTNO),
MIN(SAL) OVER(PARTITION BY DEPTNO), 
MAX(SAL) OVER(PARTITION BY DEPTNO)
FROM emp
ORDER BY DEPTNO , SAL;


--2. Write a query to display maximum salary, minimum salary 
--and average sal along with emp name and deptno for all 
--departments.

SELECT  ENAME, DEPTNO, 
AVG(SAL) OVER(PARTITION BY DEPTNO),
MIN(SAL) OVER(PARTITION BY DEPTNO), 
MAX(SAL) OVER(PARTITION BY DEPTNO)
FROM emp
ORDER BY DEPTNO ;


--3. Find sum of salary for all employees whose sal > 1000.
-- Query should display ename,sal,Sum of salary, should be 
--displayed according to the job.

SELECT ENAME, SAL, 
SUM(SAL) OVER(PARTITION BY JOB)
FROM emp
WHERE SAL > 1000;

SELECT JOB , SUM(SAL)
FROM emp
WHERE SAL > 1000
GROUP BY JOB;

--4. Find number of clerks working in each department.
-- Display ename,job 
--and count of that job.

SELECT ENAME, JOB , DEPTNO,
COUNT(*) OVER(PARTITION BY DEPTNO) 
FROM EMP 
WHERE JOB = 'CLERK';

--5. Find how many employees are working 
-- under same manager display 
-- mgr and the count .

SELECT MGR, COUNT(*) AS EMP_COUNT
FROM EMP
WHERE MGR IN ( 
				SELECT EMPNO 
				FROM EMP 
				WHERE JOB = 'MANAGER'
			  )
GROUP BY MGR;

---------- 
SELECT DISTINCT MGR, COUNT(*) OVER(PARTITION BY MGR) AS EMP_COUNT
FROM EMP 
WHERE MGR IN ( SELECT EMPNO FROM EMP WHERE JOB = 'MANAGER');

--6. Calculate how many employees earn sal greater than 1500
-- in each dept. Query should display ename, sal, 
--count of employees earning sal >1500. 

SELECT ENAME, SAL, DEPTNO,
COUNT(*) OVER(PARTITION BY DEPTNO) AS EMP_COUNT_OVER_1500
FROM EMP 
WHERE SAL > 1500;

 
--7.Calculate the difference between max salary and minimum salary 
-- for depatno 20.  Query should display ename,sal, 
-- diff between max sal and employee's sal, 
-- diff between min sal and max sal of the dept.

SELECT 
ENAME, SAL, DEPTNO,
MAX(SAL) OVER(PARTITION BY DEPTNO) AS 'MAX',
MIN(SAL) OVER(PARTITION BY DEPTNO) AS 'MIN',
MAX(SAL) OVER(PARTITION BY DEPTNO) - SAL as 'DIFF1',
MAX(SAL) OVER(PARTITION BY DEPTNO) - MIN(SAL) OVER(PARTITION BY DEPTNO) AS 'DIFF2'
FROM EMP
WHERE DEPTNO = 20;