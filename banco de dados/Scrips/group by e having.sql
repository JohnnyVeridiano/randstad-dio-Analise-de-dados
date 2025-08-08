-- funções e cláusulas de agrupamento
use company_constraints;
select * from employee;

select count(*) from employee, departament
	where Dno=Dnumber and Dname = 'Research';
    
select count(*) as total , round(avg(Salary), 2) as Salary_avg from employee
	group by Dno;
    
select Pnumber,Pname, count(*)
	from project, works_on
    where Pnumber = Pno
    group by Pnumber, Pname;
    
select count(distinct Salary) from employee;
select round(sum(Salary),2) as Total_sal, max(Salary) as Max_sal, min(Salary), round(avg(Salary),2 ) as avg_sal from employee;




-- group by e having

select Pnumber, Pname, count(*) as Number_of_register, round(avg(Salary), 2) as AVG_Salary
	from project, works_on, employee
    where Pnumber = Pno and Ssn = Essn
    group by Pnumber, Pname
    having count(*) > 2;
    
select Dno, count(*)
	from employee
    where Salary > 20000
    group by Dno
    having count(*)>=2;
    
select Dno as Departament, count(*) as NumberOfEmployees from employee
	where Salary > 20000 and Dno in (select Dno from employee
									 group by Dno
                                     having count(*)>2)
    group by Dno;
