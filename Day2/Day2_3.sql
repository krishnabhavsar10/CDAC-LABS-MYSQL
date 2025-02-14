--DAY 2 ASSIGNMENT 3

-- 1.Find all employees with name ending with R . 
SELECT * FROM EMP 
WHERE REGEXP_LIKE(ENAME, '.*R$');
 
-- 2. Find all employees with name starting with M and ending with R.
SELECT * FROM EMP
WHERE REGEXP_LIKE(ENAME, '^M.*R$');
 
-- 3. To find all employees with name starting with either M or A.
SELECT * FROM EMP
WHERE REGEXP_LIKE(ENAME, '^[M|A].*');

SELECT * FROM EMP
WHERE REGEXP_LIKE(ENAME, '^[MA].*');
 
-- 4. List the employee  name having letter 'L' as the second character.
SELECT * FROM EMP
WHERE REGEXP_LIKE(ENAME, '^.L.*');
 
-- 5. Find all employees with name having L at 3 rd position.
SELECT * FROM EMP
WHERE REGEXP_LIKE(ENAME, '^..L.*'); 
 
-- 6. To list all employees with name ending by ES.
SELECT * FROM EMP
WHERE REGEXP_LIKE(ENAME, '.*ES$');

-- 7. To list all employees with job starting with C and ending with K.
SELECT * FROM EMP
WHERE REGEXP_LIKE(JOB, '^C.*K$');
 
-- 8. To find all employees with name starting with either M or A and last character as either R or E.
SELECT * FROM EMP
WHERE REGEXP_LIKE(ENAME, '^[MA].*[RE]$');
 
-- 9. To find all employee with name starting with A or M and ending with E.
SELECT * FROM EMP
WHERE REGEXP_LIKE(ENAME, '^[MA].*E$'); 
 
--10. Find all employees with name starting with A and ending with N, or it may start with S and end with H.
SELECT * FROM EMP
WHERE REGEXP_LIKE(ENAME, '^A.*N$|^S.*H$');
 
-- 11. Find all employees with name starting with M, having  L at 3 rd position and ends with R.
SELECT * FROM EMP
WHERE REGEXP_LIKE(ENAME, '^M.L.*R$');
 
-- 12. Find all employees with name having L at 3 rd position and E at second last position.
SELECT * FROM EMP
WHERE REGEXP_LIKE(ENAME, '^..L.*E.$');
 
-- 13. Find all employees with name not starting with A or M
SELECT * FROM EMP
WHERE REGEXP_LIKE(ENAME, '^[^AM].*');
 
--14. Display all employees with sal >1000 and sal<3000 and job has A at starting position and ends with T.
SELECT * FROM EMP
WHERE SAL BETWEEN 1000 AND 3000 AND REGEXP_LIKE(JOB, '^A.*T$'); 
 
--15. Write a query  to display empno, ename, sal, commission, increased sal by 10% and for all employees  whose  name starts with A,M or S.
SELECT EMPNO, ENAME, SAL, COMM, SAL + SAL*0.1 AS 'NEW SAL'
FROM EMP 
WHERE REGEXP_LIKE(ENAME, '^[AMS].*');	
 
--16. Display all employees whose name starts with A and ends with either N or S, or works in dept 10.   
SELECT * FROM EMP 
WHERE REGEXP_LIKE(ENAME, '^A.*[NS]$') OR DEPTNO = 10;
 
--17. List all departments whose name has atleast 8 characters.
SELECT * FROM DEPT
WHERE REGEXP_LIKE(DNAME, '.........*');
 
--18. List the employees name having 'E' as a second last character.
SELECT * FROM EMP 
WHERE REGEXP_LIKE(ENAME, '.*E.$');
 
--19. List the details of the employee , whose names start with ‘A’ and end with ‘S’ or whose names contains N as the second or third     character, and end with either ‘N’ or ‘S’.
SELECT * FROM EMP 
WHERE REGEXP_LIKE(ENAME, '^A.*S$|^.N.*[NS]$|^..N.*[NS]$');
 
--20. List employees whose name starts with either 'A' or 'S' in dept 20.
SELECT * FROM EMP
WHERE DEPTNO = 20 AND REGEXP_LIKE(ENAME, '^[AS].*'); 
 
--21. To list all employees with job starting with C , E at 3rd position and  ending with K.
SELECT * FROM EMP 
WHERE REGEXP_LIKE(JOB, '^C.E.*K$');
 
--22. To list all employees with job containing L at third position and M at third last position.
SELECT * FROM EMP 
WHERE REGEXP_LIKE(ENAME, '^..L.*M..$');

--23. To list all employees with comm is null and name starts with ‘S’
SELECT * FROM EMP 
WHERE COMM IS NULL AND REGEXP_LIKE(ENAME, '^S.*');
 
--24. List employees in all dept whose salary not in the range of 2000 to 3000 with the job which is having a  string called 'MAN' at the end.
SELECT * FROM EMP 
WHERE SAL NOT BETWEEN 2000 AND 3000 AND REGEXP_LIKE(JOB, '.*MAN$');
 
--25. List all the employee whose name does not end with 'S' in dept 20 and 30?
SELECT * FROM EMP
WHERE DEPTNO BETWEEN 20 AND 30 AND REGEXP_LIKE(ENAME, '.*[^S]$');

--26. Display list all employees whose name ends with ER.
SELECT * FROM EMP
WHERE REGEXP_LIKE(ENAME, '.*ER');
 
--27. Display all employees where comm is null and name starts with ‘S’.
SELECT * FROM EMP 
WHERE COMM IS NULL AND REGEXP_LIKE(ENAME, '^S.*');
 
--28. Display all rows where comm is null.
SELECT * FROM EMP 
WHERE COMM IS NULL;

--29. Create table dept10 same as dept and table emp10 same as emp.
CREATE TABLE DEPT10 AS SELECT * FROM DEPT;
CREATE TABLE EMP10 AS SELECT * FROM EMP;