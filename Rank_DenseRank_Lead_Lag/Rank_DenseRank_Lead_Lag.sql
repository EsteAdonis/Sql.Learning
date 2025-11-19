Use adonis;
-- drop table employee;
Create Table Employee ( 
  Emp_Id int
, Emp_Name varchar(50)
, Dept_Name varchar(50)
, Salary int
);

Alter table Employee
    Add Gender char(1) 
Go

Update Employee
SET     Gender = 'M'
Where   Emp_Id not in (108, 109, 110, 111, 114, 115, 120, 121)

insert into employee values(101, 'Mohan', 'Admin', 4000);
insert into employee values(102, 'Rajkumar', 'HR', 3000);
insert into employee values(103, 'Akbar', 'IT', 4000);
insert into employee values(104, 'Dorvin', 'Finance', 6500);
insert into employee values(105, 'Rohit', 'HR', 3000);
insert into employee values(106, 'Rajesh',  'Finance', 5000);
insert into employee values(107, 'Preet', 'HR', 7000);
insert into employee values(108, 'Maryam', 'Admin', 4000);
insert into employee values(109, 'Sanjay', 'IT', 6500);
insert into employee values(110, 'Vasudha', 'IT', 7000);
insert into employee values(111, 'Melinda', 'IT', 8000);
insert into employee values(112, 'Komal', 'IT', 10000);
insert into employee values(113, 'Gautham', 'Admin', 2000);
insert into employee values(114, 'Manisha', 'HR', 3000);
insert into employee values(115, 'Chandni', 'IT', 4500);
insert into employee values(116, 'Satya', 'Finance', 6500);
insert into employee values(117, 'Adarsh', 'HR', 3500);
insert into employee values(118, 'Tejaswi', 'Finance', 5500);
insert into employee values(119, 'Cory', 'HR', 8000);
insert into employee values(120, 'Monica', 'Admin', 5000);
insert into employee values(121, 'Rosalin', 'IT', 6000);
insert into employee values(122, 'Ibrahim', 'IT', 8000);
insert into employee values(123, 'Vikram', 'IT', 8000);
insert into employee values(124, 'Dheeraj', 'IT', 11000);



/* **************
   Video Summary
 ************** */

select * from employee;

-- Using Aggregate function as Window Function
-- Without window function, SQL will reduce the no of records.
Select Dept_Name, max(Salary) From Employee
Group by Dept_Name;

Select  e.*, 
        Max(Salary) Over() as max_salary
From    Employee e

Select  e.*, 
        Max(Salary) Over(Partition by Dept_Name order by Salary) as max_salary
From    Employee e

-- This quiery create partions based on Dept_Name and in each partition Enumerate the row belonging to its partition
-- For each partition the RowNumber is reseted to start with a new counter.
Select e.*,
      Row_Number() over(Partition by dept_name order by dept_name) as RowNumber
From  Employee e

-- Fetch the first 2 employess from each deparment to join the company
Select *
From (
    Select e.*,
          Row_Number() over(Partition by dept_name order by emp_name) as RowNumber
    From  Employee e
) x 
Where x.RowNumber < 3  -- Remember: This colum is alredy grouped.

-- Rank()
-- Fetch the top 3 employees in each department earning the max salary

Select * From (
    Select  e.*,
            Rank() Over(Partition by dept_name order by Salary desc) as Rnk
    From Employee e
    ) x
Where x.Rnk < 4;

Select * From (
    Select  e.*,
            Rank() Over(Partition by dept_name order by Salary desc) as Rnk, -- Skip the rank for duplicate value
            Dense_Rank() Over(Partition by dept_name order by Salary desc) as DensRnk, -- does not skip for duplicate value
            Row_Number() Over(Partition by dept_name order by Salary desc) as rn
    From Employee e
    ) x
Where x.Rnk < 4;

-- Fetch a query to display if the salary of an employee i higher, lower or equal to the previous employee.ABORT

Select e.*, null as Prev_emp_Salary
From Employee e Where Dept_Name = 'Admin' 
Select e.*, null as Prev_emp_Salary
From Employee e Where Dept_Name = 'Finance'


Select  e.*,
        lag(Salary) Over(Partition by dept_name order by emp_id) as Prev_emp_Salary,  -- This is a new column.
        lead(Salary) Over(Partition by dept_name order by emp_id) as Next_emp_Salary  -- This is a new column.        
From    Employee e

Select  e.*,
        lag(Salary) Over(Partition by dept_name order by emp_id) as Prev_emp_Salary, 
        Case When e.salary > lag(Salary) Over(Partition by dept_name order by emp_id) then 'Higher than previous employee'
             When e.salary < lag(Salary) Over(Partition by dept_name order by emp_id) then 'Lower than previous employee'
             When e.salary = lag(Salary) Over(Partition by dept_name order by emp_id) then 'Same as than previous employee'
        End Sal_Range
From    Employee e
