-- DAY 9 ASSIGNMENT 16

--1. Write a cursor which will handle all rows having deptno 20;
DROP PROCEDURE IF EXISTS DP20_EMP;
DELIMITER //
CREATE PROCEDURE DP20_EMP()
BEGIN
	DECLARE FLAG INT DEFAULT 0;
	
	DECLARE X INT;
	DECLARE EM VARCHAR(12);
	DECLARE DP INT;
	
	DECLARE CUR CURSOR FOR SELECT EMPNO, ENAME, DEPTNO FROM EMP WHERE DEPTNO = 20;
	
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET FLAG = 1;
	
	OPEN CUR;
	
	FLOOP:LOOP

		FETCH CUR INTO X, EM, DP;
				
		IF FLAG = 1
		THEN 
			LEAVE FLOOP;
		END IF;
		
		SELECT X, EM, DP;
		
	END LOOP;
	
	CLOSE CUR;
	
END //
DELIMITER ;


--2. Pass job as a parameter to procedure and display all employees working​​​​​​​ for the specified job using cursor.

DROP PROCEDURE IF EXISTS DPJOB;

DELIMITER //
CREATE PROCEDURE DPJOB(IN JB VARCHAR(9))
BEGIN
	DECLARE FLAG INT DEFAULT 0;
	
	DECLARE X INT;
	DECLARE EM VARCHAR(12);
	DECLARE J VARCHAR(9);
	
	DECLARE CUR CURSOR FOR 
			SELECT EMPNO, ENAME, JOB FROM EMP WHERE JOB = JB;
	
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET FLAG = 1;
	
	OPEN CUR;
	
	FLOOP:LOOP
		
		FETCH CUR INTO X, EM, J;
		
		IF FLAG = 1
		THEN 
			LEAVE FLOOP;
		END IF;
		
		SELECT X AS EMPNO, EM AS ENAME, J AS JOB;
		
	END LOOP;
	
	CLOSE CUR;
END //
DELIMITER ;


--3. Pass any number to the procedure and check if it is a perfect number. If the number is perfect, procedure should set value of out parameter as 1 otherwise as 0.   

DROP PROCEDURE IF EXISTS CHECK_PERFECT_NUMBER;

DELIMITER //

CREATE PROCEDURE CHECK_PERFECT_NUMBER(IN num INT, OUT result INT)
BEGIN
    DECLARE sum_divisors INT DEFAULT 0;
    DECLARE i INT DEFAULT 1;

    -- Calculate sum of divisors of 'num'
    WHILE i < num DO
        IF num % i = 0 THEN
            SET sum_divisors = sum_divisors + i;  -- Add divisor to sum
        END IF;
        SET i = i + 1;
    END WHILE;

    -- Check if the sum of divisors equals the number
    IF sum_divisors = num THEN
        SET result = 1;  -- Perfect number
    ELSE
        SET result = 0;  -- Not a perfect number
    END IF;

END //

DELIMITER ;


--4. Write procedure 'prime' which will check if number passed to the procedure is prime. 
--   Procedure should display 1 if prime or 0 if nit prime. 
--   Use out parameter to display value out of the procedure and in parameter to pass value to the procedure.
DELIMITER $$

CREATE PROCEDURE prime(
    IN input_number INT,
    OUT is_prime INT
)
BEGIN
    IF input_number <= 1 THEN
        SET is_prime = 0; -- Numbers <= 1 are not prime
    ELSE
        SET is_prime = 1; -- Assume the number is prime
        DECLARE i INT DEFAULT 2;

        WHILE i <= input_number / 2 DO
            IF input_number MOD i = 0 THEN
                SET is_prime = 0; -- Found a divisor, not prime
                LEAVE WHILE;
            END IF;
            SET i = i + 1;
        END WHILE;
    END IF;
END$$

DELIMITER ;


---------------------------------------------------------------------------------------------------------------------

--5. Write a query to add primary key constraint on emp table and check clustered index.
--   Write a query to add primary key constraint on emp table and check clustered index.
--   Try following command after creating index
--   show indexes from emp;


-- 1. Add Primary Key Constraint to the EMP table
-- The EMPNO column is typically a good candidate for the primary key.
-- This ensures that each EMPNO is unique and not NULL.
ALTER TABLE EMP
ADD CONSTRAINT PK_EMPNO PRIMARY KEY (EMPNO);

-- 2. Show indexes from the EMP table
-- This will display all indexes on the table, including the clustered index created by the primary key constraint.
SHOW INDEXES FROM EMP;

-- Example output you would expect to see from the `SHOW INDEXES` command:
-- The primary key index should show as `PRIMARY` and indicate it is a clustered index.

-- Example Output (description):
-- +-------+------------+------------+--------------+-------------+-----------+-------------+----------+--------+------+------------+------------+
-- | Table | Non_unique | Key_name   | Seq_in_index | Column_name | Collation | Cardinality | Sub_part | Packed | Null | Index_type | Comment    |
-- +-------+------------+------------+--------------+-------------+-----------+-------------+----------+--------+------+------------+------------+
-- | EMP   | 0          | PRIMARY    | 1            | EMPNO       | A         | 15          | NULL     | NULL   |      | BTREE      | Clustered  |
-- +-------+------------+------------+--------------+-------------+-----------+-------------+----------+--------+------+------------+------------+

-- The `PRIMARY` key is unique (`Non_unique = 0`) and uses the `BTREE` index type.
-- The `Comment` will indicate `Clustered` showing that the data is physically stored in the order of the `EMPNO` column.


---------------------------------------------------------------------------------------------------------------------------

--6. Write a query to create index on deptno. Check created index.

-- 1. Create an index on the DEPTNO column
-- This index will allow faster queries when filtering or sorting by DEPTNO.
CREATE INDEX IDX_DEPTNO ON EMP(DEPTNO);

-- 2. Show indexes from the EMP table
-- This will display all indexes, including the new index on DEPTNO.
SHOW INDEXES FROM EMP;

-- Example Output (description of the new index):
-- +-------+------------+-------------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+
-- | Table | Non_unique | Key_name    | Seq_in_index | Column_name | Collation | Cardinality | Sub_part | Packed | Null | Index_type | Comment |
-- +-------+------------+-------------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+
-- | EMP   | 1          | IDX_DEPTNO  | 1            | DEPTNO      | A         | 10          | NULL     | NULL   | YES  | BTREE      |         |
-- +-------+------------+-------------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+

-- Explanation of output fields:
-- Non_unique: `1` indicates that this index allows duplicate values.
-- Key_name: `IDX_DEPTNO` is the name of the index.
-- Column_name: `DEPTNO` is the column on which the index is created.
-- Index_type: `BTREE` indicates the index uses a binary tree structure.

-- 3. Drop the index (optional, if you need to clean up after testing)
-- This removes the index from the table.
DROP INDEX IDX_DEPTNO ON EMP;