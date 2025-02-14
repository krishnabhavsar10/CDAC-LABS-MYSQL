-- DAY 9 ASSIGNMENT 17

/* 
   1.Consider following tables    
   product(pid,pname,price,qty)   
   product_log(pid,old_amt,new_amt)   
   amt = price * qty
   
   Write a trigger which will calculate amt every time any update is done in the price of an item.  
*/

DELIMITER //
CREATE TRIGGER UPDATE_AMT
BEFORE UPDATE 
ON PRODUCT
FOR EACH ROW
BEGIN
    DECLARE AMT_OLD INT;
    DECLARE AMT_NEW INT;

    -- Calculate the old and new amounts
    SET AMT_OLD = OLD.PRICE * OLD.QTY;
    SET AMT_NEW = NEW.PRICE * NEW.QTY;

    -- Insert a record into PRODUCT_LOG
    INSERT INTO PRODUCT_LOG (pid, old_amt, new_amt)
    VALUES (OLD.pid, AMT_OLD, AMT_NEW);
END //
DELIMITER ;




/* 
   2.Consider following table  
   emp_wage(eno,ename,sal,over_time)   eno : pk auto inc
  
   Write a trigger which will insert over_time as 400 if value of  over_time entered is null.    
*/ 

DELIMITER //
CREATE TRIGGER OVER_TIME_TIG
BEFORE INSERT 
ON EMP_WAGE 
FOR EACH ROW
BEGIN
    -- Check if the new value of over_time is NULL
    IF NEW.over_time IS NULL THEN 
        -- Set over_time to 400 if it is NULL
        SET NEW.over_time = 400;
    END IF;
END //
DELIMITER ;


/* 
  3.Consider following table     
  order_master(oid,pname,qty,price)      oid : pk auto inc      
  order_log(oid,odate,amt)
  
  Write a trigger which will create a log of all orders once order is placed. 
*/

DELIMITER //
CREATE TRIGGER UPDATE_ORD_LOG
AFTER INSERT 
ON ORDER_MASTER 
FOR EACH ROW
BEGIN 
    DECLARE amt INT;

    -- Calculate the total amount
    SET amt = NEW.price * NEW.qty;

    -- Insert a new record into ORDER_LOG
    INSERT INTO ORDER_LOG (oid, odate, amt)
    VALUES (NEW.oid, CURDATE(), amt);
END //
DELIMITER ;


/* 
  4.Consider following table    
  cust_master(cid,cname,accno,city) 
  cust_details(cid,deleted_date)
 
  Write a trigger which will save the information of deleted customer in cust_details table. 
*/ 

DELIMITER //
CREATE TRIGGER DEL_CUST_LOGS
BEFORE DELETE
ON CUST_MASTER
FOR EACH ROW
BEGIN 
    -- Insert the deleted customer's ID and the current date into cust_details
    INSERT INTO CUST_DETAILS (cid, deleted_date)
    VALUES (OLD.cid, CURDATE());
END //
DELIMITER ;

