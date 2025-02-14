create table demo
(
	p1 int, 
	name varchar(20),
	p2 int,
	constraint pk_comp PRIMARY key(p1, p2)
);