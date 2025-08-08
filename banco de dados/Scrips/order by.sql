-- clausular de ordenação
use company_constraints;
select * from employee order by Fname;

-- nome do departamento, nome do gerente
select distinct d.Dname, concat(e.Fname, ' ', e.Lname) as Manager, Address
	from departament as d, employee as e, works_on as w, project as p
	where (d.Dnumber = e.Dno and e.Ssn=d.Mgr_ssn and w.Pno = p.Pnumber)
    order by d.Dname;
    
-- recupera todos os empregados e seus projetos em andamento
select distinct d.Dname, concat(e.Fname,' ', e.Lname) as Employee, p.Pname as Project_name, Address
	from departament as d, employee as e, works_on as w, project as p
		where (d.Dnumber = e.Dno and e.Ssn = w.Essn and w.Pno = p.Pnumber)
        order by d.Dname;
        
select count(*) from employee;