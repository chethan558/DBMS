create database supplier;
use supplier;
create table SUPPLIERS(sid int(5) primary key, sname varchar(20), city varchar(20));
desc SUPPLIERS;
create table PARTS(pid integer(5) primary key, pname varchar(20), color varchar(10));
desc parts;
create table catalog(sid int, pid int,  foreign key(sid) references SUPPLIERS(sid), foreign key(pid) references PARTS(pid), cost float(6), primary key(sid, pid));
insert into suppliers values(10001, ' Acme Widget','Bangalore');
insert into suppliers values(10002, ' Johns','Kolkata');
insert into suppliers values(10003, ' Vimal','Mumbai');
insert into suppliers values(10004, ' Reliance','Delhi');
insert into suppliers values(10005, ' Mahindra','Mumbai');
select*from suppliers;
commit;
insert into parts values(20001, 'Book','Red');
insert into parts values(20002, 'Pen','Red');
insert into parts values(20003, 'Pencil','Green');
insert into parts values(20004, 'Mobile','Green');
insert into parts values(20005, 'Charger','Black');
 select * from parts;
insert into catalog values(10001, 20001,10);
insert into catalog values(10001, 20002,10);
insert into catalog values(10001, 20003,30);
insert into catalog values(10001, 20004,10);
insert into catalog values(10001, 20005,10);
insert into catalog values(10002, 20001,10);
insert into catalog values(10002, 20002,20);
insert into catalog values(10003, 20003,30);
insert into catalog values(10004, 20003,40);
select * from catalog;

select distinct pname from parts,catalog where parts.pid=catalog.pid;

select sname from suppliers where((select count(pid) from parts)=(select count(pid)from catalog 
where catalog.sid=suppliers.sid));

select s.sname from suppliers s where s.sid in 
((select c.sid from catalog c join parts p on c.pid = p.pid  
where p.color='Red' and c.sid = s.sid));


select pname
from Parts , Catalog , Suppliers 
where Parts.pid = Catalog.pid and Catalog.sid = Suppliers.sid
and Suppliers.sname = ' Acme Widget'
and not exists ( select *
from Catalog C1, Suppliers S1
where Parts.pid = C1.pid and C1.sid = S1.sid and
S1.sname <> ' Acme Widget')


select distinct sid FROM Catalog 
where catalog.cost>(select avg (c1.cost) from catalog c1
where c1.pid=catalog.pid);


SELECT P.pid, S.sname
FROM Parts P, Suppliers S, Catalog C
WHERE C.pid = P.pid
AND C.sid = S.sid
AND C.cost = (SELECT MAX(C1.cost)
		FROM Catalog C1
		WHERE C1.pid = P.pid);



