create database Personal;
use Personal;
create table Personal
(
	codigoPersonal int primary key,
    nomePersonal varchar(50) not null,
    emailPersonal varchar(20) not null
);

select* from personal;