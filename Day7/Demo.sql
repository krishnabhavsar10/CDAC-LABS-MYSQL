
joins in RDBMS
----------------
fetching data form multiple tables

1. Inner Join
    equi join
    non equi join
    self join

2. Outer join
    left join
    right join
    full join

3. Cross join

------------------
Cross join

selec column list
from table1
join table2
on table1.column=table2.column;


select * 
from emp10
join dept10;

select e.empno, e.ename, e.deptno,
d.deptno,d.dname
from emp10 e
join dept10 d;

inner join
-----------
select e.empno, e.ename, e.deptno,
d.deptno,d.dname
from emp10 e, dept10 d
where e.deptno=d.deptno;

inner equi join
---------------
fetch comm data from both the tables

select e.empno, e.ename, e.deptno,
d.deptno,d.dname
from emp10 e
join dept10 d
on e.deptno=d.deptno;

inner non equi join
select e.ename,e.sal,s.grade
from emp e,salgrade s
where e.sal between s.losal and s.hisal;

select e.ename,e.sal, s.grade
from emp e
join salgrade s
on e.sal between s.losal and s.hisal;

self join
---------
empno ename mgr    e
 1     raj  2
 2     yash 3
 3     sita 1

empno ename mgr    m
 1     raj  2
 2     yash 3
 3     sita 1


output

1 raj 2 yash
2 yash 3 sita

select e.empno, e.ename, e.mgr,
m.ename
from emp e
join emp m
on e.mgr = m.empno;

create table p1
(pid int,
 pname varchar(10),
 sid int
);

insert into p1
values(1,'pen',3),
      (2,'pencil',4),
      (3,'nb',1),
      (4,'eraser',2);

p
mysql> select * from p1;
+------+--------+------+
| pid  | pname  | sid  |
+------+--------+------+
|    1 | pen    |    3 |
|    2 | pencil |    4 |
|    3 | nb     |    1 |
|    4 | eraser |    2 |
+------+--------+------+
4 rows in set (0.00 sec)
s
mysql> select * from p1;
+------+--------+------+
| pid  | pname  | sid  |
+------+--------+------+
|    1 | pen    |    3 |
|    2 | pencil |    4 |
|    3 | nb     |    1 |
|    4 | eraser |    2 |
+------+--------+------+
4 rows in set (0.00 sec)

select p.pid,p.pname,p.sid,s.pname
from p1 p
join p1 s
on p.sid=s.pid;

+------+--------+------+--------+
| pid  | pname  | sid  | pname  |
+------+--------+------+--------+
|    3 | nb     |    1 | pen    |
|    4 | eraser |    2 | pencil |
|    1 | pen    |    3 | nb     |
|    2 | pencil |    4 | eraser |
+------+--------+------+--------+
4 rows in set (0.00 sec)

outer join
----------
common rows + extra rows

left outer join

common rows + extra rows from left

select e.ename,e.deptno,d.deptno,d.dname
from emp10 e
left join dept10 d
on e.deptno=d.deptno;
+--------+--------+--------+------------+
| ename  | deptno | deptno | dname      |
+--------+--------+--------+------------+
| SMITH  |     20 |     20 | RESEARCH   |
| ALLEN  |     30 |     30 | SALES      |
| WARD   |     30 |     30 | SALES      |
| JONES  |     20 |     20 | RESEARCH   |
| MARTIN |     30 |     30 | SALES      |
| BLAKE  |     30 |     30 | SALES      |
| CLARK  |     10 |     10 | ACCOUNTING |
| SCOTT  |     20 |     20 | RESEARCH   |
| KING   |     10 |     10 | ACCOUNTING |
| TURNER |     30 |     30 | SALES      |
| ADAMS  |     20 |     20 | RESEARCH   |
| JAMES  |     30 |     30 | SALES      |
| FORD   |     20 |     20 | RESEARCH   |
| MILLER |     10 |     10 | ACCOUNTING |
| Suresh |     50 |   NULL | NULL       |
| Sumit  |   NULL |   NULL | NULL       |
+--------+--------+--------+------------+
16 rows in set (0.00 sec)

select e.ename,e.deptno,d.deptno,d.dname
from emp10 e
right join dept10 d
on e.deptno=d.deptno;

+--------+--------+--------+------------+
| ename  | deptno | deptno | dname      |
+--------+--------+--------+------------+
| MILLER |     10 |     10 | ACCOUNTING |
| KING   |     10 |     10 | ACCOUNTING |
| CLARK  |     10 |     10 | ACCOUNTING |
| FORD   |     20 |     20 | RESEARCH   |
| ADAMS  |     20 |     20 | RESEARCH   |
| SCOTT  |     20 |     20 | RESEARCH   |
| JONES  |     20 |     20 | RESEARCH   |
| SMITH  |     20 |     20 | RESEARCH   |
| JAMES  |     30 |     30 | SALES      |
| TURNER |     30 |     30 | SALES      |
| BLAKE  |     30 |     30 | SALES      |
| MARTIN |     30 |     30 | SALES      |
| WARD   |     30 |     30 | SALES      |
| ALLEN  |     30 |     30 | SALES      |
| NULL   |   NULL |     40 | OPERATIONS |
| NULL   |   NULL |     90 | mkt        |
+--------+--------+--------+------------+

full outer join
---------------
select e.ename,e.deptno,d.deptno,d.dname
from emp10 e
left join dept10 d
on e.deptno=d.deptno
union
select e.ename,e.deptno,d.deptno,d.dname
from emp10 e
right join dept10 d
on e.deptno=d.deptno;

=======================
for n tables n-1 joins are required

joins on 3 tBLES

empno,ename,deptno,dname,sal,grade

select e.ename,e.deptno,d.dname,e.sal,s.grade
from emp e
join dept d
on e.deptno=d.deptno
join salgrade s
on e.sal between s.losal and s.hisal;

===================================

composite key - pk with more than 1 column

demo(sno,sname,cname,fees)
create table demo
(sno int,
 sname vrachar(10),
 cname varchar(10),
 fees int,
 constrain pk priary key(sno,cname)
);

pk=sno+cname
sno  sname  cname  fees
1    sujit  cpp    5000
2    amit   cpp    5000
1    sujit  wp     10000

delete 
from demo
where (sno,cname)=(1,'cpp');

update demo
set fees= 7000
where (sno,cname)=(2,'cpp');

----------------------------------------
view in RDBMS ----virtual tables

create view view_name 
as 
  select column_list
  from table_name;
======================
1. simple view
   query is on one table

create view emp_view
as
  select empno,ename,job,sal
  from emp;

create view emp_view1
as
  select empno "Emp No",ename "Name",job "Designation",sal "Salary"
  from emp;


2. complex view - more than 1 table is involved
create view v1
as
  select e.ename,e.deptno,d.dname,e.sal,s.grade
  from emp e
  join dept d
  on e.deptno=d.deptno
  join salgrade s
  on e.sal between s.losal and s.hisal;

types of views
--------------
1. updatable views
   changes can be made in the views

   create view v2
   as 
      select empno,ename,sal from emp10;

delete from view

delete 
from v2
where empno = 1111;

insert data in view

insert into v2
values(7777,'abc',7000);

2. read only
 create view v2
   as 
      select empno,ename,sal from emp10
 read only;  -----not supported by mysql


3. materialized views
create materialized view v2
   as 
      select empno,ename,sal from emp10;

create view v4
as
 select empno,ename,deptno
 from emp10
 where deptno=20;

with check ----- constraint on view
create view v5
as
 select empno,ename,deptno
 from emp10
 where deptno=20
 with check option ;

------------------------------

PL/SQL ----- procedural language / structured query language


1. Stored procedures
    set of logical lines that cannot return any value
2. Stored functions
    set of logical lines that  returns the value

SP and SF are permanently stored on the disk and need to be deleted explicitly.

create procedure procedure_name
begin
 statements;
end

delimiter $$
create procedure insert_data()
begin 
   insert into dept10
   values(70,'Training','Pune');
end $$
delimiter ;

mysql>call insert_data();

mysql>drop procedure_name;

---------------------------------
delimiter //
create procedure insert_data1()
begin 
   insert into dept10
   values(80,'Develop','Pune');
   select * from dept10;
end //
delimiter ;

parameters are of 3 types

IN parameter - input to the procedure
               default in

OUT parameter - brings out the values from procedure

INOUT parameter - IN + out

delimiter //
create procedure display(in mno int)
begin
   select empno,ename,deptno
   from emp
   where deptno=mno;
end //
delimiter ;

mysql>call display(20);

mysql>set @p=10;
mysql>call display(@p);





  





























 





     
Demo Day - 7.txt
Displaying Demo Day - 7.txt.