--1. faculty(fid(PK),fname,sp.skill1,sp.skill2)      

	CREATE TABLE faculty(
		fid int, 
		fname varchar (20) not null,  
		sp_skill1 varchar (30), 
		sp_skill2 varchar(30),
		CONSTRAINT pk_fid PRIMARY KEY(fid)
	);

	/*
	fid   fname    sp_skill1         sp_skill2
	------------------------------------------
	10    Amol      Database          Java
	11    Asha      Java              MySQL
	12    Kiran     CPP               database
	13    Seeta     MySQL             database
	*/

--2. courses(cid(PK),cname,rid,fid(FK))
  
	CREATE TABLE Courses
	(
		cid int,
		cname varchar (15) not null,
		rid int, 
		fid int,
		CONSTRAINT PK_CID PRIMARY KEY(CID),
		CONSTRAINT FK_RID FOREIGN KEY(RID) REFERENCES ROOM(RID) ON DELETE SET NULL,
		CONSTRAINT FK_FID FOREIGN KEY(FID) REFERENCES FACULTY(FID) ON DELETE SET NULL
	);

/*
	cid	cname	rid	 fid

	121	DBDA 100 10
	
	131	DAC	101	null

	141	DTISS	null	null

	151	DOIT	105	12
*/


--3. room(roomid,rname,rloc)  

	CREATE TABLE room
	(
		rid int, 
		rname varchar(15) not null,  
		rloc varchar(20),
		CONSTRAINT PK_RID PRIMARY KEY(RID)
	);

	/*
	rid     rname    rloc 
	100   Jasmin   1st floor 
	101    Rose      2nd floor
	105    Lotus     1st floor
	103    Mogra   1st floor
	*/

--1. list all rooms which are allocated or not allocated to any courses.
/*
Expected Output
+---------+-------------+----------+------------+

|  rid      | rname     | cid       | cname   |

+---------+-------------+----------+------------+
|
 100      | Jasmin      |  121     | DBDA     |

| 101     | Rose        |  131     | DAC      |

| 103     | Mogra       | NULL     | NULL     |

| 105     | Lotus       |  151     | DIOT     |
+---------+-------------+----------+------------+

*/

-- SOL 1
SELECT R.RID, R.RNAME, C.CID, C.CNAME
FROM ROOM R
LEFT JOIN COURSES C
ON C.RID = R.RID;

-- SOL 2
SELECT R.RID, R.RNAME, C.CID, C.CNAME
FROM COURSES C
RIGHT JOIN ROOM R
ON C.RID = R.RID;


--2. list all rooms which are not allocated to any courses.

--> WITHOUT USING JOIN
SELECT * FROM ROOM
WHERE RID NOT IN (SELECT RID FROM COURSES WHERE RID IS NOT NULL);

--> WITH USING JOIN
SELECT R.RID, R.RNAME, R.RLOC 
FROM ROOM R
LEFT JOIN COURSES C 
ON R.RID = C.RID 
EXCEPT 
SELECT R.RID, R.RNAME, R.RLOC 
FROM ROOM R
JOIN COURSES C 
ON R.RID = C.RID;


--3. display courses and faculty assigned to those courses 
--   whose special skill is database.
/*
Expected Output
+-------+-----------+-------+-----------+--------------+---------------+
| cid    | cname    | fid   | fname     | sp_skill1    | sp_skill2     |
+-------+-----------+-------+-----------+--------------+---------------+
| 121    | DBDA     |  10   | Amol      | database     |  JAVA         |
| 151    | DIOT     |  12   | Kiran     | CPP          |  Database     |
+-------+-----------+--------+-----------+-------------+---------------+
*/


--> WITHOUT USING JOIN
SELECT C.CID, C.CNAME, F.FID, F.FNAME, F.SP_SKILL1, F.SP_SKILL2
FROM COURSES C , FACULTY F
WHERE (C.FID = F.FID) AND (F.SP_SKILL1 = 'DATABASE' OR F.SP_SKILL2 = 'DATABASE');

--> WITH USING JOIN
SELECT C.CID, C.CNAME, F.FID, F.FNAME, F.SP_SKILL1, F.SP_SKILL2
FROM FACULTY F 
JOIN COURSES C 
ON C.FID = F.FID
WHERE F.SP_SKILL1 = 'DATABASE' OR F.SP_SKILL2 = 'DATABASE';


-----------------------------------------------------------------
mysql> SELECT * FROM COURSES;
+-----+-------+------+------+
| cid | cname | rid  | fid  |
+-----+-------+------+------+
| 121 | DBDA  |  100 |   10 |
| 131 | DAC   |  101 | NULL |
| 141 | DTISS | NULL | NULL |
| 151 | DOIT  |  105 |   12 |
+-----+-------+------+------+
4 rows in set (0.00 sec)

mysql> SELECT * FROM ROOM;
+-----+--------+-----------+
| rid | rname  | rloc      |
+-----+--------+-----------+
| 100 | Jasmin | 1st floor |
| 101 | Rose   | 2nd floor |
| 103 | Mogra  | 1st floor |
| 105 | Lotus  | 1st floor |
+-----+--------+-----------+
4 rows in set (0.00 sec)

mysql> SELECT * FROM FACULTY;
+-----+-------+-----------+-----------+
| fid | fname | sp_skill1 | sp_skill2 |
+-----+-------+-----------+-----------+
|  10 | Amol  | Database  | Java      |
|  11 | Asha  | Java      | MySQL     |
|  12 | Kiran | CPP       | database  |
|  13 | Seeta | MySQL     | database  |
+-----+-------+-----------+-----------+
4 rows in set (0.00 sec)