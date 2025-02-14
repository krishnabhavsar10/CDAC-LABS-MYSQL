/* 
1. The HR department wants to know the names of all the employees who were hired after 
Blake. Create a query to display the name and hire date of any employee hired 
after employee  Blake.
*/
SELECT ENAME, HIREDATE 
FROM EMP 
WHERE HIREDATE > (SELECT HIREDATE FROM EMP WHERE ENAME = 'BLAKE');


--2. Write a query to get  year, and number of employees joined each year.
SELECT YEAR(HIREDATE) AS Hire_Year, COUNT(*) AS Employee_Count
FROM EMP
WHERE HIREDATE IS NOT NULL
GROUP BY YEAR(HIREDATE)
ORDER BY Hire_Year;


--3. Write a query to display all employees with experience more than 43 years.
SELECT ENAME, 
       ROUND(DATEDIFF(CURDATE(), HIREDATE) / 365, 1) AS Experience_Years
FROM EMP
WHERE DATEDIFF(CURDATE(), HIREDATE) / 365 > 43;


--4. Display 3rd highest salary.
SELECT * 
FROM EMP
WHERE SAL IS NOT NULL
ORDER BY SAL DESC
LIMIT 1 OFFSET 2;

--5. Write a query which will display all employees working in sales department.
SELECT * FROM EMP
WHERE DEPTNO = (SELECT DEPTNO FROM DEPT WHERE DNAME = 'SALES');


--6. Write a query to display year if more than 2 employees are hired in that year.
SELECT YEAR(HIREDATE), COUNT(*) AS EMP_HIRED
FROM EMP 
WHERE HIREDATE IS NOT NULL
GROUP BY YEAR(HIREDATE)
HAVING EMP_HIRED > 2;

--7. From emp table write a SQL query to find those employees  whose ID matches 
--   any of the numbers 7902, 7876 and 7934. Display all columns.
SELECT * FROM EMP
WHERE EMPNO IN (7902, 7876, 7934);


--8. From emp table, write a SQL query to find the employee  
--   whose salary is 3000 and reporting person’s ID is 7876. 
SELECT * FROM EMP
WHERE SAL = 3000 AND MGR = 7876;


--9. From emp table  write a SQL query to find those employees whose salary 
--   falls within the range of the minimum  salary and 2500.  
SELECT * FROM EMP
WHERE SAL BETWEEN (SELECT MIN(SAL) FROM EMP) AND 2500;

--10. From emp table, write a SQL query to find those employees who do not
--    work in the departments where managers’ IDs are between 7566 and 7698 
--    (Begin and end values are included.) 
SELECT * FROM EMP
WHERE MGR NOT BETWEEN 7566 AND 7698;


--11. From emp table, write a SQL query to find those employees who get 
--    second-highest salary.  
SELECT * FROM EMP
ORDER BY SAL DESC
LIMIT 1 OFFSET 1;

--12. From emp table, write a SQL query to find those employees who work in 
--    a department where the employee’s name contains the letter 'J'. 
SELECT * FROM EMP
WHERE REGEXP_LIKE(ENAME, '.*J.*');


--13. From emp table, write a SQL query to find those employees who earn more 
--    than the average salary and work in the same department as an employee 
--    whose first name contains the letter 'J'. Return employee ID, first name and salary.  
SELECT EMPNO, ENAME, SAL
FROM EMP E
WHERE SAL > (SELECT AVG(SAL) 
             FROM EMP D 
             WHERE D.DEPTNO = E.DEPTNO)
  AND DEPTNO IN (
      SELECT DISTINCT DEPTNO
      FROM EMP
      WHERE REGEXP_LIKE(ENAME, 'J', 'i')
  );


--14. From emp table, write a SQL query to find those employees whose salaries 
--    are higher than the average for all departments.
SELECT EMPNO, ENAME, SAL
FROM EMP
WHERE SAL > (SELECT AVG(SAL) FROM EMP);

--15. From emp table, write a SQL query to find those employees whose salary 
--    matches that of the employee who works in department ID 30
SELECT * FROM EMP
WHERE SAL IN (SELECT DISTINCT SAL FROM EMP WHERE DEPTNO = 30)

--16. From emp table, write a SQL query to find employees who work for the department 
--    in which employee ID 7788 is employed.
SELECT * FROM EMP
WHERE DEPTNO = (SELECT DEPTNO FROM EMP WHERE EMPNO = 7788);


--17. From emp table, write a SQL query to display all employees working in the 
--    department whose location is as that of the location of dept 30
SELECT E.EMPNO, E.ENAME, D.DEPTNO, D.DNAME, D.LOC
FROM EMP E
JOIN DEPT D
ON E.DEPTNO = D.DEPTNO
WHERE D.LOC = (SELECT LOC FROM DEPT WHERE DEPTNO = 30);