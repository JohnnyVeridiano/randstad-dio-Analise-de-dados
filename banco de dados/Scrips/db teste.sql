-- union, excepet e intersect

create database teste;
use teste;

create table R (
	A char(2)
);

create table S (
	A char(2)
);

insert into R(A) values ('A1'),('A2'),('A2'),('A3');
insert into S(A) values ('A1'),('A1'),('A2'),('A3'),('A4'),('A5');

select * from S;

-- except --> not int
select * from S where A not in (select A from R);

-- union, já tem o atributo distinct na consulta
(select distinct R.A from R) union (select distinct S.A from S);
(select  R.A from R) union (select  S.A from S);

-- intersect
select distinct R.A from R where R.A in (select S.A from S);

use company_constraints;

select distinct * from works_on
	where (Pno,Hours) in (select Pno,Hours
						  from works_on
                          where Essn=123456789);
                          
-- cláusulas com exist e unique
-- verifica dependentes
select e.Fname, e.Lname from employee as e
	where exists(select * from dependent as d
					where e.Ssn = d.Essn and Relationship = 'Daughter');
-- sem dependentes
select e.Fname, e.Lname from employee as e
	where not exists(select * from dependent as d
					where e.Ssn = d.Essn );
                    

select e.Fname, e.Lname from employee as e
	where exists(select * from dependent as d
					where e.Ssn = d.Essn )
                    and 
                    (select * from departament
						where Ssn = Mgr.ssn );
                        
                        
select * from employee limit 5;