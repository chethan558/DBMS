create database bankenterprise;
use bankenterprise;
create table branch(
branch_name varchar(20),
branch_city varchar(20),
assets real,
primary key(branch_name));
create table bankaccount(
accno int,
branch_name varchar(20),
balance real,
primary key(accno),
foreign key(branch_name) references branch(branch_name)); 
create table bankcustomer(
customer_name varchar(20),
customer_street varchar(20),
city varchar(20),
primary key (customer_name));
create table depositer(
customer_name varchar(20),
accno int,
foreign key(customer_name) references bankcustomer(customer_name),
foreign key(accno) references bankaccount(accno));
create table loan(
loan_number int primary key,
branch_name varchar(20),
amount int);
insert into branch values("SBI_Chamarajpet","bangalore","50000");
insert into branch values("SBI_Residencyroad","bangalore","10000");
insert into branch values("SBI_Shivajiroad","bombay","20000");
insert into branch values("SBI_Parlimentroad","delhi","10000");
insert into branch values("SBI_Jantramantar","dehli","20000");
select*from branch;
insert into bankaccount values("1","SBI_Chamarajpet","2000");
insert into bankaccount values("2","SBI_Residencyroad","5000");
insert into bankaccount values("3","SBI_Shivajiroad","6000");
insert into bankaccount values("4","SBI_Parlimentroad","9000");
insert into bankaccount values("5","SBI_Jantramantar","8000");
insert into bankaccount values("6","SBI_Shivajiroad","4000");
insert into bankaccount values("8","SBI_Residencyroad","4000");
insert into bankaccount values("9","SBI_Parlimentroad","3000");
insert into bankaccount values("10","SBI_Residencyroad","5000");
insert into bankaccount values("11","SBI_Jantramantar","2000");
select*from bankaccount;
insert into bankcustomer values("Avinash","Bull_temple_road","bangalore");
insert into bankcustomer values("Dinesh","Bannergatta","bangalore");
insert into bankcustomer values("Mohan","Nationalcollege_road","bangalore");
insert into bankcustomer values("Nikil","AKbar_road","delhi");
insert into bankcustomer values("Ravi","prithviraj_road","delhi");
select*from bankcustomer;
insert into depositer values("Avinash","1");
insert into depositer values("Dinesh","2");
insert into depositer values("Nikil","4");
insert into depositer values("Ravi","5");
insert into depositer values("Avinash","8");
insert into depositer values("Nikil","9");
insert into depositer values("Dinesh","10");
insert into depositer values("Nikil","11");
select*from depositer;
insert into loan values("1","SBI_Chamarajpet","1000");
insert into loan values("2","SBI_Residencyroad","2000");
insert into loan values("3","SBI_Shivajiroad","3000");
insert into loan values("4","SBI_Parlimentroad","4000");
insert into loan values("5","SBI_Jantramantar","5000");
desc depositer;
select customer_name from depositer natural join bankcustomer group by customer_name having count(*)>=2;



SELECT d.customer_name
FROM depositer d
JOIN bankaccount ba ON d.accno = ba.accno
JOIN branch b ON ba.branch_name = b.branch_name
WHERE b.branch_city = 'delhi'
GROUP BY d.customer_name
HAVING COUNT(DISTINCT b.branch_name) = (
    SELECT COUNT(*)
    FROM branch
    WHERE branch_city = 'delhi'
);

SELECT customer_name
FROM bankcustomer
WHERE customer_name NOT IN (
  SELECT DISTINCT customer_name FROM depositer
);
SELECT DISTINCT d.customer_name
FROM depositer d
JOIN bankaccount ba ON d.accno = ba.accno
JOIN loan l ON ba.branch_name = l.branch_name
JOIN branch b ON ba.branch_name = b.branch_name
WHERE b.branch_city = 'bangalore';

SELECT branch_name
FROM branch
WHERE assets > ALL (
    SELECT assets
    FROM branch
    WHERE branch_city = 'bangalore'
);


DELETE FROM bankaccount
WHERE branch_name IN (
    SELECT branch_name
    FROM branch
    WHERE branch_city = 'bombay'
);
select*from bankaccount;

UPDATE bankaccount
SET balance = balance * 1.05;
















