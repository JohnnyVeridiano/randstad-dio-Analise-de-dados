show databases;
create database if not exists first_example;
use first_example;
create table person(
person_id smallint unsigned,
fname varchar(20),
lname varchar(20),
gender enum('M','F'),
birth_date date,
street varchar(20),
city varchar(20),
state varchar(20),
country varchar(20),
postal_code varchar(20),
constraint pk_person primary key (person_id)
);
desc person;

CREATE table favorite_food(
	person_id smallint unsigned,
    food varchar(20),
    constraint pk_favorite_food primary key (person_id, food),
    constraint fk_favorite_food_person_id foreign key (person_id) references person(person_id)
);

desc favorite_food;

show databases;
select * from information_schema.table_constraints
where constraint_schema = 'first_example';

desc person;

insert into person values
 ('2','Carolina','Silva','F','1979-07-21','Rua tal','Cidade J','RJ','Brasil', '260574-89'),
  ('3','Roberta','Silva','F','1979-07-21','Rua tal','Cidade J','RJ','Brasil', '260574-89'),
   ('4','Luiz','Silva','F','1979-07-21','Rua tal','Cidade J','RJ','Brasil', '260574-89');

select * from person;

delete from person where person_id=2 ;

desc favorite_food;


insert into favorite_food values (1,'lasanha'),
								 (3,'carne assada'),
                                 (4,'fetuccine');
                                 
select * from favorite_food                                 
