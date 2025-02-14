 /*
 1. Create a view emp_view having following columns
    empno,ename,deptno,sal, comm
*/

	CREATE VIEW EMP_VIEW 
	AS 
		SELECT EMPNO, ENAME, DEPTNO, SAL, comm
		FROM EMP;


/*
 2. Insert new employee having following information in the view
    (1111,'Geeta',20,10000,300)
    check the data inserted in the view as well as the base table. 
*/
	INSERT INTO EMP_VIEW 
	VALUES(1111, 'GEETA', 20, 10000, 300);

	SELECT * FROM EMP_VIEW;
	SELECT * FROM EMP;


/*
 3. Create a view for deptno 20 as emp_v20 having following COLUMNS. 
    This view should contain rows from dept20 only.
    empno,ename,deptno,job.
*/

	CREATE VIEW EMP_V20 
	AS 
		SELECT EMPNO, ENAME, DEPTNO, JOB 
		FROM EMP
		WHERE DEPTNO = 20;


/*
 4. Insert new employee  in view emp_v20 having following 
    information (2222,'Raj',40,'Analyst') 
    check the data inserted in the base table emp and also in the view.
*/

	--> NO ERROR AS NO 'WITH CHECK OPTION' CONSTRAINT USED
	INSERT INTO EMP_V20
	VALUES(2222, 'RAJ', 40, 'Analyst');


/*
 5. Create a view for deptno 20 as new_emp_v20 having following cloumns
    empno,ename,deptno,job with constraint 'check option' .
*/
	CREATE VIEW NEW_EMP_V20 
	AS 
		SELECT EMPNO, ENAME, DEPTNO, JOB 
		FROM EMP
		WHERE DEPTNO = 20
		WITH CHECK OPTION;
	
	
/*
 6. Insert below data in new_emp_v20 having following 
    information(2222,'Raj',40,'Analyst')
    check the data inserted in the base table emp and also in the view.
*/

	-- ERROR --> ERROR 1369 (HY000): CHECK OPTION failed 'employee.new_emp_v20'
	INSERT INTO NEW_EMP_V20
	VALUES(2222, 'RAJ', 40, 'Analyst');



/*
 7. Check the views created.
*/
	SELECT * FROM NEW_EMP_V20;
	SELECT * FROM EMP_V20;


/*
 8. Create a view with columns as empno,ename, deptno and dname.
    empno,ename, deptno and dname.
    Check if you can enter the data in the above view.
*/
	CREATE VIEW KRISHNA
	AS 
		SELECT E.EMPNO "EMPNO", E.ENAME "ENAME", D.DEPTNO "DEPTNO", D.DNAME "DNAME"
		FROM EMP E, DEPT D
		WHERE E.DEPTNO = D.DEPTNO;
	/*
	ERROR 1393 (HY000): Can not modify more than one base table 
	through a join view 'employee.krishna'
	*/
	
	INSERT INTO KRISHNA(EMPNO, ENAME, DEPTNO, DNAME)
	VALUES(79, 'KRUSHNA', 20, 'RESEARCH');	