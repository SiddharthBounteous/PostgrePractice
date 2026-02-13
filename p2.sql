create table department (department_id int primary key, department_name varchar(20));
create table address (address_id int primary key, street_address varchar(20), city varchar(20), state varchar(20), postal_code int);
create table student  (student_id int primary key, first_name varchar(20), last_name varchar(20), birth_date date, department_id int, address_id int,
constraint fk_student_department foreign key(department_id) references department(department_id),
constraint fk_student_address foreign key(address_id) references address(address_id)
);

insert into department (department_id, department_name) values 
(1, 'Computer Science'),
(2, 'Mechanical Eng'),
(3, 'Electrical Eng'),
(4, 'Civil Eng'),
(5, 'Mathematics'),
(6, 'Biology');

insert into address (address_id, street_address,city,state,postal_code) values
(1,'123 Elm St','Springfield','IL',62701),
(2,'456 Oak St','Springfield','IL',62521),
(3,'789 Pine St','Springfield','IL',61820),
(4,'102 Birch Rd','Springfield','IL',61602),
(5,'205 Cedar Ave','Springfield','IL',62701),
(6,'310 Maple Dr','Springfield','IL',62701),
(7,'415 Oak Blvd','Springfield','IL',618),
(8,'520 Pine Rd','Springfield','IL',62901);


select * from student;
select * from address;
select * from department;

-- total no. of students
select count(*) as total from student;

-- department of john
select d.department_name from department d join student s on s.department_id=d.department_id where s.first_name='John';

-- 
