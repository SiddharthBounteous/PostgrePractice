create database mydb;
create table employee(emp_id int, emp_name varchar(12) ,emp_salary int);

insert into employee(emp_id,emp_name,emp_salary) values 
(1,'Siddharth',12000),
(2,'Rahul',23000),
(3,'Rohan',10000),
(4,'Barun',15000),
(5,'Karan',17000);

insert into employee(emp_id,emp_name,emp_salary) values 
(6,'Proya',12000);


drop table employee;

select * from employee;

select max(emp_salary) from employee where emp_salary < (select max(emp_salary) from employee);

select emp_id,count(*) from employee group by emp_id having count(*)>1;

alter table employee add column manager_id int;

update employee set manager_id = 3 where emp_id in (1,2);
update employee set manager_id = 4 where emp_id in(3);
update employee set manager_id = 5 where emp_id in(4);
update employee set manager_id = NULL where emp_id in(5);

select e1.emp_name from employee e1 join employee e2 on e1.manager_id = e2.emp_id where e1.emp_salary>e2.emp_salary;

alter table employee add column dept_id int;

update employee set dept_id = 101 where emp_id in (1,2,3);
update employee set dept_id = 102 where emp_id in(4);
update employee set dept_id = 103 where emp_id in(5);
update employee set dept_id = 104 where emp_id in(6);

select dept_id from employee group by dept_id having count(dept_id)>2;


alter table employee add column join_date date;

update employee set join_date='2026-01-12' where emp_id=1;
update employee set join_date='2026-01-18' where emp_id=2;
update employee set join_date='2026-01-23' where emp_id=3;
update employee set join_date='2026-01-24' where emp_id=4;
update employee set join_date='2026-02-09' where emp_id=5;

select emp_name from employee where join_date >= current_date - interval '6 months';

create table department(dept_id int,dept_name varchar(12));

insert into department(dept_id,dept_name) values
(101,'Management'),
(102,'HR'),
(103,'Sales');

select * from department;

insert into department(dept_id,dept_name) values
(104,'IT'),
(105,'Operations');

select d.dept_name from department d left join employee e on d.dept_id=e.dept_id where e.emp_id is null;

-- Running Salary

select emp_name,dept_id,emp_salary, sum(emp_salary) over (partition by dept_id order by emp_id) as running_total from employee;

select emp_name,dept_id,emp_salary, sum(emp_salary) over (partition by dept_id) as running_total from employee;


select emp_name, rank() over (order by emp_salary) from employee;

select emp_name, dept_id, rank() over (partition by dept_id order by emp_salary) from employee;

alter table employee add column gender varchar(2);

update employee set gender = 'M' where emp_id in (1,2,3,4,5);
update employee set gender = 'F' where emp_id in (6);

select dept_id,
count(case when gender in ('M') then 1 end) as male,
count(case when gender in ('F') then 1 end) as female
from employee group by dept_id;

-- difference between current row and previous salary
select emp_name, emp_salary, emp_salary-lag(emp_salary) over (order by emp_id) as salary_diff from employee;   -- doing previous one

select emp_name, emp_salary, emp_salary-lead(emp_salary) over (order by emp_id) as salary_diff from employee;  -- doing next one


-- homework
-- corporate questions on lead and lag functions

-- find dept with highest average salary

select avg(emp_salary) as avg_salary, dept_id from employee group by dept_id order by avg_salary desc limit 1;

--CTE
with avg_salaries as (select dept_id, avg(emp_salary) as avg_salary from employee group by dept_id)
select * from avg_salaries where avg_salary=(select max(avg_salary) from avg_salaries);

-- Orders recieved
-- id prod_id   units
-- 1     A       10
-- 2     B       20
-- 3     C       30
-- 1     A       20

-- Orders Completed
-- id prod_id   units
-- 1     A       5
-- 2     B       15
-- 3     C       30
-- 1     A       15


