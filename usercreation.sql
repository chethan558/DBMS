show databases;
create database if not exists newdatabase;
use newdatabase;
create table uno(name varchar(20));
select*from uno;
use mysql;
create user chethan identified by "chethan123";
grant all privileges on *.* to "chethan"
FLUSH privileges;
drop database newdatabase;