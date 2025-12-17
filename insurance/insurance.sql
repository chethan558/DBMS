
create database insurance;
use insurance;
create table person (
driver_id varchar(20),
name varchar(20),
address varchar(20),
primary key(driver_id));
drop table person;
select * from person;
insert into person values("A01","Richard","Srinivasnagar");
insert into person values("A02","Pradeep","Rajajinagar");
insert into person values("A03","Smith","Ashoknagar");
insert into person values("A04","venu","NR colony");
insert into person values("A05","Richard","Hanumanth nagar");
select * from person;
create table car(reg_num varchar(20),model varchar(20),year int,primary key(reg_num));
create table owns(
driver_id varchar(10),
reg_num varchar(20),
foreign key(driver_id)references person(driver_id),
foreign key(reg_num)references car(reg_num));
create table accident(
report_num int,
accident_date date,
location varchar(20),
primary key(report_num));
create table participated(
driver_id varchar(20),
reg_num varchar(20),
report_num int,
damage_amount int,
primary key(driver_id,reg_num,report_num),
foreign key(driver_id) references person(driver_id),
foreign key(reg_num) references car(reg_num),
foreign key(report_num) references accident(report_num));
select*from person;
select*from owns;
insert into car values("KA052250","Indica","1990");
insert into car values("KA031181","Lancer","1957");
insert into car values("KA095477","Toyota","1998");
insert into car values("KA053408","Honda","2008");
insert into car values("KA041702","Audi","2005");
insert into accident values("11","2003-01-03","Mysore road");
insert into accident values("12","2004-02-02","South end circle");
insert into accident values("13","2003-01-21","Bull temple road");
insert into accident values("14","2008-02-17","Mysore road");
insert into accident values("15","2005-03-04","Kanakpura road");
select*from accident;
insert into owns values("A01","KA052250");
insert into owns values("A02","KA031181");
insert into owns values("A03","KA095477");
insert into owns values("A04","KA053408");
insert into owns values("A05","KA041702");

select*from owns;
commit;
insert into participat 

values("A01","KA052250","11","10000");
insert into participated values("A02","KA031181","12","50000");
insert into participated values("A03","KA095477","13","25000");
insert into participated values("A04","KA053408","14","3000");
insert into participated values("A05","KA041702","15","5000");
select* from participated;


update participated set damage_amount="26000" where reg_num="KA053408";
 commit;
 select accident_date, location from accident;
 
 select driver_id from participated where damage_amount="3000";
 
 
 select reg_num from participated where damage_amount>="10000";

 select count(*) from person;


show databases;



select * from participated
order by damage_amount desc;


select avg(damage_amount) from participated;

select name from person join participated 
where person.driver_id = participated.driver_id and damage_amount>(select avg(damage_amount) from participated);

select max(damage_amount) from participated;

DELETE FROM participated 
WHERE damage_amount < 18600 ;
select * from participated;







