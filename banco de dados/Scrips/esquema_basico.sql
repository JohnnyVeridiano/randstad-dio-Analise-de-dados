create schema if not exists company_constraints;
use company_constraints;

-- create domain D_num as int check(D_nmum> 0 and D_num< 21);

create table employee(
	Fname varchar(15) not null,
	Minit char,
	Lname varchar(15) not null,
	Ssn char(9) not null,
	Bdate date,
	Address varchar(30),
	sex char,
	Salary decimal(10,2),
	Super_ssn char(9),
	Dno int not null,
    constraint chk_salary_employee check(Salary> 2000.0),
	constraint pk_employee primary key (Ssn)
);
desc employee;
alter table employee
	add constraint fk_employee
    foreign key(Super_ssn) references employee(Ssn)
    on delete set null
    on update cascade;

desc employee;

create table departament(
	Dname varchar(15) not null,
    Dnumber int not null,
    Mgr_ssn char(9),
    Mgr_start_date date,
    Dept_create_date date,
    constraint chk_date_dept check(Dept_create_date < Mgr_start_date),
    constraint pk_dept primary key (Dnumber),
    constraint unique_name_dept unique (Dname),
    foreign key(Mgr_ssn) references employee(Ssn)
);

-- 'def', 'company_constraints', 'departament_ibfk_1', 'company_constraints', 'departament', 'FOREIGN KEY', 'YES'
alter table departament drop constraint departament_ibfk_1;	
alter table departament	
	add constraint fk_dept foreign key(Mgr_ssn) references employee(Ssn) 
    on update cascade;
	
desc departament;

create table dept_locations(
	Dnumber int not null,
    Dlocation varchar(15) not null,
	constraint pk_dept_locations primary key (Dnumber, Dlocation),
    constraint fk_dept_locations foreign key (Dnumber) references departament (Dnumber)
);

alter table dept_locations drop constraint fk_dept_locations;
alter table dept_locations
	add constraint fk_dept_locations foreign key(Dnumber) references departament(Dnumber)
    on delete cascade
    on update cascade;

create table project(
	Pname varchar(15) not null,
    Pnumber int not null,
    Plocation varchar(15),
    Dnum int not null,
    primary key (Pnumber),
    constraint unique_project unique (Pname),
    constraint fk_project foreign key (Dnum) references departament(Dnumber)
);

create table works_on(
	Essn char(9) not null,
    Pno int not null,
    Hours decimal(3,1) not null,
    primary key (Essn, Pno),
    constraint fk_works_on foreign key (Essn) references employee(Ssn),
    constraint fk_works_on_pno foreign key (Pno) references project(Pnumber)
);

alter table works_on drop constraint fk_works_on;
alter table works_on drop constraint fk_works_on_pno;
alter table works_on
	add constraint fk_employye_works_on foreign key(Essn) references employee(Ssn),
    add constraint fk_project_works_on foreign key (Pno) references project(Pnumber)
    on delete cascade
    on update cascade;
    
drop table dependent;
create table dependent(
	Essn char(9) not null,
    Dependent_name varchar(15) not null,
    sex char, 
    Bdate date,
    Relationship varchar(8),
    primary key(Essn, Dependent_name),
    constraint fk_dependent foreign key(Essn) references employee(Ssn)
);


show tables;
desc dependent;

select * from information_schema.table_constraints
	where constraint_schema = 'company_constraints';

-- recolhendo o valor do INSS-*
use company_constraints;    
select Fname, Lname, Salary, Salary*0.011 from employee;
select Fname, Lname, Salary, Salary*0.011 as INSS from employee;
select Fname, Lname, Salary, round(Salary*0.011,2) as INSS from employee;

-- definir um aumento de salário para os gerentes que trabalham no projeto associado ao produtoX

select * 
	from employee e, works_on as w, project as p
	where (e.Ssn = w.Essn and w.Pno = Pnumber);
    
select concat(Fname, ' ' , Lname) as Complete_namem, Salary, round(Salary*1.1,2) as increased_salary
	from employee e, works_on as w, project as p
	where (e.Ssn = w.Essn and w.Pno = Pnumber and p.Pname='ProductX');
    
desc dept_locations;

-- recuperando todos os gerentes que trabalham em Stafford
select Dname as Departament_Name, Mgr_ssn, concat(Fname, ' ', Lname) as Manager from departament d, dept_locations l, employee e
	where d.Dnumber = l.Dnumber and Dlocation ='Stafford' and Mgr_ssn = e.Ssn;
    
-- recuperando todos os gerentes, departamentos e seus nomes
select Dname as Departament_Name,  concat(Fname, ' ', Lname) as Manager, Dlocation from departament d, dept_locations l, employee e
	where d.Dnumber = l.Dnumber  and Mgr_ssn = e.Ssn;


-- recuperando numero do projeto, nome do gerente e localização
select Pnumber, Dnum, Fname, Address, Bdate, p.Plocation from departament d, project p, employee e
	where d.Dnumber = p.Dnum and p.Plocation='Stafford' and Mgr_ssn = e.Ssn;
    
    
-- like between

select * from employee;

select concat(Fname, ' ', Lname) as Complete_name, Dname, Address as Departament_Name from employee, departament
	where ( Dno=Dnumber and Address like '%Houston%');
    
 -- testando between   
select Fname, Lname, Salary from employee where (Salary > 30000 and Salary < 40000);
select Fname, Lname, Salary from employee where (Salary between 20000 and 40000);

-- Operadores lógicos
select * from departament;
select * from departament where Dname = 'Research' or Dname = 'Administration';
select concat(Fname,' ', Lname) as Complete_Name from employee, departament where Dname = 'Research' and Dnumber=Dno;