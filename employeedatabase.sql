create database employee;
use employee;
create table dept(
deptno int,
dname varchar(20),
dloc varchar(20),
primary key(deptno));
create table emp(
empno decimal(4,0),
ename varchar(20),
mgr_no decimal(4,0) default null,
hiredate date,
sal int,
deptno int references dept(deptno),
primary key(empno));
desc emp;
create table incentives(
empno decimal(4,0) references emp(empno),
incentive_date date,
incentives_amount decimal(10,2),
primary key(empno , incentive_date));
create table project(
pno int primary key,
pname varchar(20) not null,
ploc varchar(20));
desc project;
create table assigned_to(
empno decimal(4,0) references emp(empno),
pno int references project(pno),
job_role varchar(20),
primary key (empno,pno));
desc dept;
INSERT INTO dept VALUES (10,"ACCOUNTING","MUMBAI");
INSERT INTO dept VALUES (20,"RESEARCH","BENGALURU");
INSERT INTO dept VALUES (30,"SALES","DELHI");
INSERT INTO dept VALUES (40,"OPERATIONS","CHENNAI");
select * from dept;
desc emp;
insert into emp values(7369,"Adarsh","7902","2012-12-17","80000","20");
insert into emp values(7499,"shruthi","7698","2013-02-20","16000","30");
INSERT INTO emp VALUES (7521,"Anvitha","7698","2015-02-22",12500,"30");
INSERT INTO emp VALUES (7566,"Tanvir","7839","2008-04-02","29750","20");
INSERT INTO emp VALUES (7654,"Ramesh","7698","2014-09-28","12500","30");
INSERT INTO emp VALUES (7698,"Kumar","7839","2015-05-01","28500","30");
INSERT INTO emp VALUES (7782,"Clark","7839","2017-06-09","24500","10");
INSERT INTO emp VALUES (7788,"Scott","7566","2010-12-09","30000","20");
INSERT INTO emp VALUES (7839,"king",null,"2009-11-17","500000","10");
INSERT INTO emp VALUES (7844,"Turner","7698","2010-09-08","15000","30");
INSERT INTO emp VALUES (7876,"Adams","7788","2013-01-12","11000","20");
INSERT INTO emp VALUES ("7900","JAMES",7698,"2017-12-03","9500","30");
INSERT INTO emp VALUES ("7902","FORD","7566","2010-12-03","30000","20");
select * from emp;
INSERT INTO incentives VALUES(7499,"2019-02-01",5000.00);
INSERT INTO incentives VALUES(7521,"2019-03-01",2500.00);
INSERT INTO incentives VALUES(7566,"2022-02-01",5070.00);
INSERT INTO incentives VALUES(7654,"2020-02-01",2000.00);
INSERT INTO incentives VALUES(7654,"2022-04-01",879.00);
INSERT INTO incentives VALUES(7521,"2019-02-01",8000.00);
INSERT INTO incentives VALUES(7698,"2019-03-01",500.00);
INSERT INTO incentives VALUES(7698,"2020-03-01",9000.00);
INSERT INTO incentives VALUES(7698,"2022-04-01",4500.00);
select * from incentives ;
INSERT INTO project VALUES(101,"AI Project","BENGALURU");
INSERT INTO project VALUES(102,"IOT","HYDERABAD");
INSERT INTO project VALUES(103,"BLOCKCHAIN","BENGALURU");
INSERT INTO project VALUES(104,"DATA SCIENCE","MYSURU");
INSERT INTO project VALUES(105,"AUTONOMUS SYSTEMS","PUNE");
select * from project ;

INSERT INTO assigned_to VALUES(7499,101,"Software Engineer");
INSERT INTO assigned_to VALUES(7521,101,"Software Architect");
INSERT INTO assigned_to VALUES(7566,101,"Project Manager");
INSERT INTO assigned_to VALUES(7654,102,"Sales");
INSERT INTO assigned_to VALUES(7521,102,'Software Engineer');
INSERT INTO assigned_to VALUES(7499,102,'Software Engineer');
INSERT INTO assigned_to VALUES(7654,103,'Cyber Security');
INSERT INTO assigned_to VALUES(7698,104,'Software Engineer');
INSERT INTO assigned_to VALUES(7900,105,'Software Engineer');
INSERT INTO assigned_to VALUES(7839,104,'General Manager');
select * from  assigned_to;

select distinct empno from emp
where empno not in( select empno from incentives);

SELECT m.ename, count(*)
FROM emp e,emp m
WHERE e.mgr_no = m.empno
GROUP BY m.ename
HAVING count(*) =(SELECT MAX(mycount) 
  			       from (SELECT COUNT(*) mycount
      			       FROM emp
      			        GROUP BY mgr_no) a);

 SELECT *
FROM emp m
WHERE m.empno IN
    (SELECT mgr_no
     FROM emp)
  AND m.sal >
    (SELECT avg(e.sal)
     FROM emp e
     WHERE e.mgr_no = m.empno );  


select distinct m.mgr_no from emp e, emp m
where e.mgr_no=m.mgr_no and e.deptno=m.deptno and e.empno in (
select distinct m.mgr_no from emp e, emp m
where e.mgr_no=m.mgr_no and e.deptno=m.deptno);


SELECT * 
FROM EMP E 
WHERE E.DEPTNO = (SELECT E1.DEPTNO 
FROM EMP E1 
WHERE E1.EMPNO=E.MGR_NO);


select* from emp where emp.empno in(select mgr_no from emp )and emp.sal >( select avg(sal)from emp
);

desc emp;

select m.ename , m.empno, m.sal from emp m
where m.empno in(select mgr_no from emp)
and m.sal > (select avg (e.sal)
from emp e
where e.mgr_no=m.empno);


select distinct m.mgr_no from emp e , emp m
where e.mgr_no=m.mgr_no and e.deptno=m.deptno and e.empno in (
select distinct m.mgr_no from emp e , emp m
where e.mgr_no =m.mgr_no and e.deptno=m.deptno);



select * from emp e,incentives i 
where e.empno=i.empno and 2=(select count(*) from incentives j
where i.incentives_amount<=j.incentives_amount);

select * from emp e 
where e.deptno=(select e1.deptno from emp e1 where e1.empno=e.mgr_no);


select distinct e.ename from emp e, incentives i
where (select max(sal+incentives_amount)
from emp, incentives)>=ANY
(select sal from emp e1
where e.deptno=e1.deptno);



