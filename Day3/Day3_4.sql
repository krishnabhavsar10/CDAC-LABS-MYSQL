-- DAY 3

-------------------- EXTRA'S DATE -----------------------------------
SELECT CURRENT_DATE(); -- 2024-11-16
SELECT CURDATE(); -- 2024-11-16
SELECT CURTIME(); -- 19:28:08 
SELECT NOW(); --  2024-11-16 19:28:30 
SELECT DATE(NOW()); -- 2024-11-16  

SELECT DATE_ADD(CURDATE(), INTERVAL 1 YEAR); -- ADDS 1 YEAR TO CURDATE
SELECT DATE_ADD(CURDATE(), INTERVAL 1 DAY);
SELECT DATE_ADD(CURDATE(), INTERVAL 1 MONTH);

SELECT DATE_SUB(CURDATE(), INTERVAL 1 YEAR); -- SUBS 1 YEAR FROM CURDATE
SELECT DATE_SUB(CURDATE(), INTERVAL 1 DAY);
SELECT DATE_SUB(CURDATE(), INTERVAL 1 MONTH);


SELECT DATEDIFF('2024-11-1', '2024-11-16'); --> -15 NUMBER OF DAYS ARE RETURNED

SELECT YEAR(CURDATE());  -- 2024
SELECT MONTH(CURDATE()); -- 11
SELECT DAY(CURDATE());   -- 16

------------------------------------------------------------------------------


-- 1. Display hiredate from emp table in different formats. 
SELECT HIREDATE, 
	YEAR(HIREDATE), 
	MONTH(HIREDATE), 
	DAY(HIREDATE) 
FROM EMP;

-- YEAR
SELECT HIREDATE, 
	DATE_FORMAT(HIREDATE, '%y'), -- LAST 2 DIGIT
	DATE_FORMAT(HIREDATE, '%Y')  -- COMPLETE YEAR
FROM EMP;			

-- MONTH
SELECT HIREDATE, 
	DATE_FORMAT(HIREDATE, '%m'), -- MONTH NUMBER
	DATE_FORMAT(HIREDATE, '%M')  -- MONTH NAME
FROM EMP;		

--DAY
SELECT HIREDATE, 
	DATE_FORMAT(HIREDATE, '%d'), -- DAY NUM
	DATE_FORMAT(HIREDATE, '%D'), -- FORMATTED DAY NUM EX: --> 1ST, 2ND, 3RD,...
	DATE_FORMAT(HIREDATE, '%b')  -- MONTH FIRST 3 LETTERS
FROM EMP;	

--2. Find all employees whose sal is divisible by 3 .
SELECT * FROM EMP
WHERE MOD(SAL, 3) = 0;

--3. Write query to display name followed by 4 stars followed by sal . '
-- e.g SMITH****800   
SELECT ENAME, SAL, CONCAT(ENAME, '****', TRUNCATE(SAL, 0))
FROM EMP;

-- 4. Display email as ename followed by mycompany.com. 
-- e.g SMITH@mycompany.com
SELECT ENAME, CONCAT(UPPER(ENAME), '@mycompany.com')
FROM EMP;

--5.Display ename and it's length for all employees. 
--e.g SMITH 5
SELECT ENAME, LENGTH(ENAME) FROM EMP;

-- 6.Display email as  first  3 chacarters of ename, followed by dot, followed by 2 and 3rd character of  jobs,followed by @MyCompany
SELECT ENAME, JOB, 
CONCAT(SUBSTR(LOWER(ENAME), 1, 3), '.', SUBSTR(LOWER(JOB), 3, 1), '@MyCompany')
FROM EMP;

--7. Display name starting with upper case letter and job starting with upper case letter for all employees.   
-- e.g Smith Clerk
SELECT 
CONCAT(
	UPPER(SUBSTR(ENAME,1,1)), 
	LOWER(SUBSTR(ENAME,2)), 
	' ' ,
	UPPER(SUBSTR(JOB,1,1)), 
	LOWER(SUBSTR(JOB,2))
)
AS DESIGNATION
FROM EMP; 

--8. Display first 3 characters of ename in lower case and rest everything in upper case.  
--   e.g smiTH

SELECT CONCAT(LOWER(SUBSTR(ENAME,1,3)), UPPER(SUBSTR(ENAME,4)))
FROM EMP;


--9. Display last 3 letters of name.
SELECT SUBSTR(ENAME, LENGTH(ENAME)-2)
FROM EMP;

--10. Generate an email-id for all employees and display. Email id is generated as follows    
--first 3 letters of name in lower case + last 2 letters of job in lower case + @knowit.com   
 --eg name=SMITH   job=CLERK      email-id = smirk@knowit.com

SELECT CONCAT(LOWER(SUBSTR(ENAME,1,3)), LOWER(SUBSTR(JOB, LENGTH(job)-1)), '@acts.com')
from emp;


--11. List all employees having experience greater than 40 years.
SELECT ENAME, HIREDATE, CEIL(DATEDIFF(CURDATE(), HIREDATE)/365) 
FROM emp
WHERE CEIL(DATEDIFF(CURDATE(), HIREDATE)/365) > 43;


--12. Increase the salary by 10% in the database for all employees having experience more than 40 years  
UPDATE EMP
SET SAL = SAL + SAL* 0.1
WHERE CEIL(DATEDIFF(CURDATE(), HIREDATE)/365) > 40;


--13. Implement following using case statement. Use data from emp database.    
--If comm is null ‘need improvement’ If <500 “ok” If >=500 and < 1000 ‘good' ‘Excellent'
SELECT ENAME, SAL, COMM, 
CASE 
	WHEN COMM IS NULL THEN 'need improvement'
	WHEN COMM < 500 THEN 'OK'
	WHEN COMM < 1000 THEN 'GOOD EXCELLENT'
	ELSE 'NOT OKAY'
	END 'REMARKS'
FROM EMP;

--14.From the emp table, write a SQL query to find those employees whose salary is in 
--the range of 1000, and 3000 (Begin and end values included.). Return all the fields.

SELECT * FROM emp
WHERE SAL BETWEEN 1000 AND 3000;


--15. Display all names. Length of each name should be 10 characters , 
--add required spaces on left side of name, also display job, 
--length of job should be 9 characters add required on the right side of job.

SELECT ENAME, JOB, LPAD(ENAME,10,' '), RPAD(JOB,9,' ')
FROM EMP;


--16. Display string “Hello” followed by name having first letter of name in capital, 
--followed by ! for all  employees  who earned commission.

SELECT CONCAT('HELLO', ' ', UPPER(SUBSTR(ENAME,1,1)), LOWER(SUBSTR(ENAME, 2)), ' ' , '!') AS BADIYA
FROM EMP
WHERE COMM IS NOT NULL ;


--17. Display all employee names from emp table in the following format. 
--  Hello Allen . 
SELECT CONCAT('Hello', ' ', UPPER(SUBSTR(ENAME,1,1)), LOWER(SUBSTR(ENAME,2)), ' .') AS 'KYA BAAT'
FROM EMP;


--18. Write a query to display name is a job. job should be in small letters
--   e.g SMITH is a clerk 
SELECT ENAME, JOB, 
	CONCAT(UPPER(ENAME), ' is a ', LOWER(JOB))
FROM EMP;    


--19. Display all columns by sperating with comma.
SELECT 
	CONCAT_WS(' ,', EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO) AS ALL_COLUMNS_COMB
FROM EMP;

--20. Find how many analysts are there in each department.
SELECT COUNT(*) 
FROM EMP
WHERE JOB = 'ANALYST';

--21. To find max, min and sum of salary for all employees whose sal > 1500 and < 3000
SELECT MIN(SAL), MAX(SAL), SUM(SAL)
FROM EMP
WHERE SAL BETWEEN 1500 AND 3000;

--22. Display ename,sal for dept 10 with max sal at the top.
SELECT ENAME, SAL 
FROM EMP 
WHERE DEPTNO = 10
ORDER BY SAL DESC
LIMIT 1;

--23. Write a query which will display name, department no and date of joining 
--of all employees joined between  January 1, 1981 and March 31, 1983. 
--Sort it based on date of joining (ascending). 
SELECT ENAME, DEPTNO, HIREDATE 
FROM EMP 
WHERE HIREDATE BETWEEN '1981-01-01' AND '1983-03-31'
ORDER BY HIREDATE;

--24.Display the number of employees who has got the commission.
SELECT * FROM EMP
WHERE COMM IS NOT NULL;

--25. Find sum of all the salaries in emp table.
SELECT SUM(SAL)
FROM EMP;

--26. List Department wise total  salary.
SELECT DEPTNO, SUM(SAL) 
FROM EMP 
WHERE DEPTNO IS NOT NULL
GROUP BY DEPTNO;


--27. List department wise total sal only if the total sal is > 8000
SELECT DEPTNO, SUM(SAL)
FROM EMP 
WHERE DEPTNO IS NOT NULL
GROUP BY DEPTNO
HAVING SUM(SAL) > 8000;

--28. Count number of clerks in dept 10 and 20.   
SELECT COUNT(*)
FROM EMP 
WHERE DEPTNO BETWEEN 10 AND 20;

--29. Display job wise sum of salary excluding dept 30 only if the sum salary is > 5000.
SELECT JOB, SUM(SAL)
FROM EMP 
WHERE DEPTNO != 30 
GROUP BY JOB 
HAVING SUM(SAL) > 5000;

--30. Find all employees whose sal is divisible by 3.
SELECT * FROM emp
WHERE MOD(SAL, 3) = 0;


--31.List emp working as managers and clerks with Salary at least 2000 
-- except in dept 10 and 20.

SELECT * FROM EMP 
WHERE JOB IN ('MANAGER', 'CLERK') AND SAL >= 2000 AND DEPTNO NOT IN (10, 20);

--32. List all the clerks and analysts with salary at least 1000 in dept 20 and 30.
SELECT * FROM emp
WHERE JOB IN ('CLERK', 'ANALYST') AND SAL >= 1000 AND DEPTNO IN (20, 30);

--33. Display all employees who works in either dept 10 or 30 or joined in year 1982.
SELECT * FROM emp
WHERE DEPTNO IN (10, 30) OR EXTRACT(YEAR FROM HIREDATE) = 1982;


--34.Write a query which will display name, department no and date of joining of
--   all employees joined between  January 1, 1981 and March 31, 1983.  Sort it based 
--   on date of   joining (ascending).

SELECT ENAME, DEPTNO, HIREDATE
FROM EMP
WHERE HIREDATE BETWEEN '1981-01-01' AND '1983-03-31' 
ORDER BY HIREDATE;

--35.List the employees in dept 20 and 30 who get no commission.
SELECT * FROM EMP
WHERE DEPTNO IN (20, 30) AND COMM IS NULL;

--36.Display job wise max sal only for managers, clerks, salesman working in 
--   dept 10 and 20. Sort the data by des order of the max salary.
SELECT JOB, MAX(SAL)
FROM EMP 
WHERE DEPTNO IN (10, 20)
GROUP BY JOB
HAVING JOB IN ('MANAGER', 'CLERK', 'SALESMAN')
ORDER BY MAX(SAL) DESC;


--37.Write a query which will display name, department no and date of joining of 
--  all employees joined between  January 1, 1981 and March 31, 1983. Sort it
-- based on date of   joining (ascending).
SELECT ENAME, DEPTNO, hiredate
FROM emp
WHERE HIREDATE BETWEEN '1981-01-01' AND '1983-03-31' 
ORDER BY HIREDATE;

--38.Display hiredate from emp table in different formats.
SELECT ENAME,HIREDATE,
	   DATE_FORMAT(HIREDATE, '%Y') '4 DIGIT YEAR',
	   DATE_FORMAT(HIREDATE, '%y') 'LAST TWO DIGITS',
	   DATE_FORMAT(HIREDATE, '%m') 'MONTH NUMBER',
	   DATE_FORMAT(HIREDATE, '%M') 'MONTH NAME',
	   DATE_FORMAT(HIREDATE, '%D') 'GIVES 3RD',
	   DATE_FORMAT(HIREDATE, '%d') 'GIVES ONLY DIGIT',
	   DATE_FORMAT(HIREDATE, '%b') 'SHORTFORM OF MONTH'
FROM EMP;	   