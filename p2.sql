create table department (department_id int primary key, department_name varchar(20));
create table address (address_id int primary key, street_address varchar(20), city varchar(20), state varchar(20), postal_code int);
create table student  (student_id int primary key, first_name varchar(20), last_name varchar(20), birth_date date, department_id int, address_id int,
constraint fk_student_department foreign key(department_id) references department(department_id),
constraint fk_student_address foreign key(address_id) references address(address_id)
);
drop table student;
drop table address;
drop table department;
insert into department (department_id, department_name) values 
(1, 'Computer Science'),
(2, 'Mechanical Eng'),
(3, 'Electrical Eng'),
(4, 'Civil Eng'),
(5, 'Mathematics'),
(6, 'Biology');

insert into address (address_id, street_address,city,state,postal_code) values
(1,'123 Elm St','Springfield','IL',62701),
(2,'456 Oak St','Decatur','IL',62521),
(3,'789 Pine St','Champaign','IL',61820),
(4,'102 Birch Rd','Peoria','IL',61602),
(5,'205 Cedar Ave','Chicago','IL',62701),
(6,'310 Maple Dr','Urbana','IL',62701),
(7,'415 Oak Blvd','Champaign','IL',618),
(8,'520 Pine Rd','Carbondale','IL',62901);


insert into student (student_id,first_name,last_name,birth_date,department_id,address_id) values
(1, 'John','Doe','1995-04-15',1, 1),
(2, 'Jane','Smith','1996-07-22',2, 2),
(3, 'Alice','Johnson','1994-11-30',3, 3),
(4, 'Michael','Brown', '1997-02-19',4, 4),
(5, 'Sophia','Davis','1998-01-05',5, 5),
(6, 'Daniel','Wilson','1995-06-10',6, 6),
(7, 'Olivia', 'Martinez','1997-11-25',1, 7),
(8, 'Ethan','Miller','1996-03-30',2, 8);


select * from student;
select * from address;
select * from department;

-- total no. of students
select count(*) as total from student;

-- department of john
select d.department_name from department d join student s on s.department_id=d.department_id where s.first_name='John';

-- List All Departments with Their Number of Students (Including Departments with No Students)
select d.department_name, count(s.first_name) from department d left join student s on s.department_id=d.department_id group by d.department_name;

--  Select all students with their department and address.
select s.first_name,s.last_name, d.department_name, a.street_address from department d join student s on s.department_id=d.department_id join address a on a.address_id=s.address_id;

-- students in cs department
select s.first_name, s.last_name from student s join department d on s.department_id=d.department_id where d.department_name='Computer Science';

-- students in spring field
select s.first_name from student s join address a on s.address_id=a.address_id where a.city='Springfield';

-- birthday in february
select s.first_name, s.last_name from student s where extract(month from birth_date)=2; 

-- update jane city name to new york
update address set city='New York' where address_id=(select address_id from student where first_name = 'Jane');

-- delete a student from student 
delete from student where student_id=3;

-- delete student from mechanical engineering department
delete from student s using department d where s.department_id=d.department_id and d.department_id=2;

-- how many students in each department
select count(s.first_name) as total, d.department_name from student s left join department d on s.department_id=d.department_id group by d.department_name;

-- Select all students with their department and address in New York. 
select s.first_name,s.last_name, d.department_name, a.street_address from department d join student s on s.department_id=d.department_id join address a on a.address_id=s.address_id where a.city='New York';

--  Find the name of the student who lives at '520 Pine Rd'
select s.first_name,s.last_name from student s join address a on s.address_id=a.address_id where a.street_address='520 Pine Rd';

-- List all students who have an address in 'Urbana' or 'Peoria'  
select s.first_name,s.last_name from student s join address a on s.address_id=a.address_id where a.city in ('Urbana','Peoria');

-- count total address in champaign city
select count(*) as total_address from address where city='Champaign';

-- count no. of students in each department with city champaign
select count(s.student_id) as total_students, d.department_name from department d join student s on s.department_id=d.department_id join address a on a.address_id=s.address_id where a.city='Champaign' group by d.department_name;

-- students not in computer science department
select s.first_name, s.last_name, d.department_name from student s join department d on s.department_id=d.department_id where d.department_name!='Computer Science';


-- student with highest student id
select first_name,last_name from student where student_id=(select max(student_id) from student);

-- student names with department name sorted by department
select s.first_name, s.last_name, d.department_name from student s left join department d on s.department_id=d.department_id order by d.department_name;

-- student is city chicago and mathematics department
select s.first_name, s.last_name from department d join student s on s.department_id=d.department_id join address a on a.address_id=s.address_id where a.city='Chicago' and d.department_name='Mathematics';

-- average age of students with electrical department
select avg(extract(year from age(current_date, s.birth_date))) as average_age
from student s join department d  on s.department_id = d.department_id where d.department_name = 'Electrical Eng';

-- Find all students who are born within 1995 to 1998 
select student_id, first_name, last_name, birth_date from student where birth_date between '1995-01-01' and '1998-12-31' order by birth_date;

-- list of students living on pine street
select s.first_name,s.last_name from student s join address a on s.address_id=a.address_id where a.street_address like '%Pine%';

--  Update the department of a student with student_id = 6 to 'Mechanical Engineering'  
update student set department_id=(select department_id from department where department_name='Mechanical Eng') where student_id=6;

--  List the students, their department, and the city where they live, but only for those in departments starting with 'M'
select s.first_name,s.last_name,d.department_name,a.city from student s join department d on s.department_id = d.department_id join address a on s.address_id = a.address_id where d.department_name like 'M%' order by d.department_name, s.last_name;

-- Get the department and address details for a specific student, example john
select s.first_name, s.last_name, d.department_name, a.street_address, a.city, a.state, a.postal_code
from student s join department d  on s.department_id = d.department_id join address a on s.address_id = a.address_id where s.first_name ilike 'John';

-- 