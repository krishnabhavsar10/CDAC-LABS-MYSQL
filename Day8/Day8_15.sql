-- DAY 8 ASSIGNMENT 15

/* 1. Write a procedure which accepts in parameter
as empno and calculates total salary for that employee. Display salary out of procedure.
total salary = sal +comm */

DELIMITER //
DROP PROCEDURE IF EXISTS TOTAL_SAL;
CREATE PROCEDURE TOTAL_SAL(IN EM INT)
BEGIN
	SELECT SAL + IFNULL(COMM, 0) AS TOTAL_SAL
	FROM EMP WHERE EMPNO = EM;
END //
DELIMITER ;

CALL TOTAL_SAL(1234);


/* 
2.Write a procedure which takes empno of 2 employees. 
Compare salaries of employees and display ename,sal and job for the employee who
earns more salary out of procedure.  */

DELIMITER //
CREATE PROCEDURE COMP_EMP(IN EM1 INT, IN EM2 INT)
BEGIN
    DECLARE X1 DECIMAL(7,2);
    DECLARE X2 DECIMAL(7,2);

    -- Retrieve salaries of both employees
    SELECT SAL INTO X1 FROM EMP WHERE EMPNO = EM1;
    SELECT SAL INTO X2 FROM EMP WHERE EMPNO = EM2;

    -- Compare salaries and display details of the employee with the higher salary
    IF X1 > X2 THEN
        SELECT ENAME, SAL, JOB FROM EMP WHERE EMPNO = EM1;
    ELSE
        SELECT ENAME, SAL, JOB FROM EMP WHERE EMPNO = EM2;
    END IF;
END //
DELIMITER ;

/* 

-- INCOMPLETE QUESTION

3. Write a procedure which accepts ename and job as parameters
   and calculates salary hike depending on job. 
   
DELIMITER //
CREATE PROCEDURE SAL_HIKE(IN EM VARCHAR(12), IN JB VARCHAR(9))
BEGIN
--STATEMENT
END //
DELIMITER; 

*/
 

 

--4. Pass empno to the procedure. 
--   Find if employee exists in the table. 
--   If so, print sal out of procedure else print sal as 0.

DELIMITER //
CREATE PROCEDURE EMP_EXIST(IN EM INT)
BEGIN
	DELARE X INT DEFAULT NULL;
	
	SELECT EMPNO INTO X FROM EMP WHERE EMPNO = EM;
	
	IF X IS NOT NULL
	THEN 
		SELECT SAL AS SAL FROM EMP WHERE EMPNO = EM;
	ELSE 
		SELECT O AS SAL
	END IF;
END //
DELIMITER ;


/* 5. Write a function which will display email for employees working as salesman.
   email generated is as follows
   2nd and 3rd letter of name + last 2 letters of job in caps + deptno+'@mycompany.com'.
 */
 
SET GLOBAL log_bin_trust_function_creators = 1;

DELIMITER //

CREATE FUNCTION EMAIL_EMP(EM VARCHAR(12), JB VARCHAR(9), DPN INT)
RETURNS VARCHAR(30)
BEGIN
    DECLARE X VARCHAR(30);
    SET X = CONCAT(
                SUBSTR(EM, 2, 2), 						-- Extract 2nd and 3rd letters of the name
                UPPER(SUBSTR(JB, LENGTH(JB) - 1, 2)), 	-- Extract last 2 letters of job in uppercase
                DPN, 									-- Department number
                '@mycompany.com' 						-- Domain
            );
    RETURN X;
END //

DELIMITER ;


/* 6. Write a function which will return square of the number.
   Call this function in the procedure 'calculate'. 
   Pass any number to this procedure and call a function in the procedure by passing
   a number. */

DELIMITER //
CREATE FUNCTION SQR_NUM(X INT)
RETURNS INT
DETERMINISTIC 
BEGIN
    RETURN X * X;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE CALCULATE(IN N INT)
BEGIN
	SELECT SQR_NUM(N) AS 'SQUARE OF NUMBER';
END //
DELIMITER ;

/*
The DETERMINISTIC keyword is required in MySQL when binary logging is enabled to ensure that functions always produce the same result for the same input. 
This is crucial for replication, where changes from the master server must be consistently applied to slave servers. 
If a function is deterministic, it does not rely on external factors (like random values or current timestamps), 
making it safe for replication. If not marked as deterministic, MySQL can't guarantee consistent results across servers, 
leading to potential errors or inconsistencies. This is why MySQL requires explicit marking of deterministic functions 
when binary logging is enabled.
*/
  
  
/* 7. wite a cursor which will display salary hike as follows
   if employee is clerk then hike is 10%
   if employee is salesman then hike is 7%
   if employee is analyst then hike is 5%
   others no hike 
*/

DROP PROCEDURE IF EXISTS SAL_HIKE;

DELIMITER //
CREATE PROCEDURE SAL_HIKE()
BEGIN
    DECLARE FLAG INT DEFAULT 0;
    DECLARE EM VARCHAR(12);
    DECLARE JB VARCHAR(9);
    DECLARE S DECIMAL(7,2);
    DECLARE NEW_SAL DECIMAL(7,2);
    
    -- Declare a cursor to fetch employee details (ENAME, JOB, SAL)
    DECLARE CUR CURSOR FOR 
        SELECT ENAME, JOB, SAL FROM EMP;
    
    -- Handler for when there are no more rows to fetch
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET FLAG = 1;
    
    -- Open the cursor
    OPEN CUR;
    
    -- Loop through all the rows returned by the cursor
    FLOOP: LOOP
        FETCH CUR INTO EM, JB, S;
        
        IF FLAG = 1 THEN
            LEAVE FLOOP; -- Exit the loop when no more rows are found
        END IF;
        
        -- Apply salary hike based on the job title
        SET NEW_SAL = 
            CASE 
                WHEN JB = 'CLERK' THEN S + (S * 0.1)  -- 10% hike for CLERK
                WHEN JB = 'SALESMAN' THEN S + (S * 0.07)  -- 7% hike for SALESMAN
                WHEN JB = 'ANALYST' THEN S + (S * 0.05)  -- 5% hike for ANALYST
                ELSE S  -- No hike for other job titles
            END;
        
        -- Display the employee details along with the new salary after the hike
        SELECT EM AS Employee_Name, JB AS Job_Title, S AS Old_Salary, NEW_SAL AS New_Salary;
    
    END LOOP;
    
    -- Close the cursor
    CLOSE CUR;
    
END //

DELIMITER ;



--8. Try creating index.
CREATE INDEX ENAME_INDEX ON EMP(ENAME);

--9. Practice commit and rollback.
SET AUTOCOMMIT = 0; -- ENABLE AUTOCOMMIT 

INSERT INTO EMP(EMPNO, ENAME, SAL)
VALUES(1111, 'MANSI', 9999),
	(2222, 'VIKRANT', 8888);
	
SELECT * FROM EMP;

ROLLBACK;

SELECT * FROM EMP;

COMMIT;


SAVEPOINT X1;
INSERT INTO EMP(EMPNO, ENAME, SAL)
VALUES(1111, 'MANSI', 9999),
	(2222, 'VIKRANT', 8888);
	
SELECT * FROM EMP;
	
SAVEPOINT X2;
INSERT INTO EMP(EMPNO, ENAME, SAL)
VALUES(1111, 'MANSI_1', 9999),
	(2222, 'VIKRANT_1', 8888);	
	
SELECT * FROM EMP;

ROLLBACK TO X1;

SELECT * FROM EMP;

ROLLBACK TO X2;

SELECT * FROM EMP;

COMMIT;