use adonis
-- QUERY 1 :
drop table emp;
Create table Emp( 
    Emp_ID int
  , Emp_NAME varchar(50)
  , SALARY int
);

insert into emp values(101, 'Mohan', 40000);
insert into emp values(102, 'James', 50000);
insert into emp values(103, 'Robin', 60000);
insert into emp values(104, 'Carol', 70000);
insert into emp values(105, 'Alice', 80000);
insert into emp values(106, 'Jimmy', 90000);

select * from emp;


-- WITH common_table_expression (Transact-SQL)
-- Specifies a temporary named result set, known as a common table expression (CTE). 
-- This is derived from a simple query and defined within the execution scope of a single 
-- SELECT, INSERT, UPDATE, DELETE, or MERGE statement. This clause can also be used in a 
-- CREATE VIEW statement as part of its defining SELECT statement. 
-- A common table expression can include references to itself. 
-- This is referred to as a recursive common table expression.

-- Fetch employees who earn more than average salary of all employees

With Avg_Sal_CTE(Avg_Salary_Column) as (
  Select cast(avg(salary) as int) From Emp
)
Select *
From Emp e
Join Avg_Sal_CTE av on e.salary > av.Avg_Salary_Column



-- QUERY 2 :
Drop table sales ;
create table Sales (
	Store_id  		int,
	Store_name  	varchar(50),
	Product			varchar(50),
	Quantity		int,
	Cost			int
);

insert into sales values
(1, 'Apple Originals 1','iPhone 12 Pro', 1, 1000),
(1, 'Apple Originals 1','MacBook pro 13', 3, 2000),
(1, 'Apple Originals 1','AirPods Pro', 2, 280),
(2, 'Apple Originals 2','iPhone 12 Pro', 2, 1000),
(3, 'Apple Originals 3','iPhone 12 Pro', 1, 1000),
(3, 'Apple Originals 3','MacBook pro 13', 1, 2000),
(3, 'Apple Originals 3','MacBook Air', 4, 1100),
(3, 'Apple Originals 3','iPhone 12', 2, 1000),
(3, 'Apple Originals 3','AirPods Pro', 3, 280),
(4, 'Apple Originals 4','iPhone 12 Pro', 2, 1000),
(4, 'Apple Originals 4','MacBook pro 13', 1, 2500);

select * from sales;


-- Find total sales per each store
Select s.Store_id, sum(s.Cost) as total_sales_per_store
From Sales s
Group by s.store_id;


-- Find average sales with respect to all stores
Select cast(avg(total_sales_per_store) as int) avg_sale_for_all_store
From (
    Select s.store_id, sum(s.cost) as total_sales_per_store
	  From sales s
	  Group by s.store_id
)  x;



-- Find stores who's sales where better than the average sales accross all stores
select *
from   (
        Select s.store_id, sum(s.cost) as total_sales_per_store
				From sales s
				Group by s.store_id
	   ) total_sales
join   (select cast(avg(total_sales_per_store) as int) avg_sale_for_all_store
				from (
          select s.store_id, sum(s.cost) as total_sales_per_store
		  	  From sales s
			  	Group by s.store_id
        ) x
	   ) avg_sales
on total_sales.total_sales_per_store > avg_sales.avg_sale_for_all_store;


-- Find Stores Who's sales where better than the average sales accross all stores
-- 1) Total sales per each store -- Total_Sales

    Select Store_id, Sum(Cost) as Total_per_store
    From  sales
    Group by Store_id

-- 2) Find the average sales with respect all the stores. -- Ave_Sales.\

    Select Cast(avg(Total_per_store) as int) as Avg_Sales_all_stores
    From  (
          Select Store_id, Sum(Cost) as Total_per_store
          From  sales
          Group by Store_id      
    ) x

-- 3) Find the stores where Total_Sales > Avg_Sales of all Stores.

Select *
From  (
      Select Store_id, Sum(Cost) as Total_per_store
      From  sales
      Group by Store_id
    ) Total_Sales
Join  (
    Select Cast(avg(Total_per_store) as int) as Avg_Sales_all_stores
    From  (
          Select Store_id, Sum(Cost) as Total_per_store
          From  sales
          Group by Store_id      
    ) x
) avg_sales

On Total_Sales.Total_per_store > avg_sales.Avg_Sales_all_stores
Go


-- Specifies a temporary named result set, known as a common table expression (CTE). 
-- This is derived from a simple query and defined within the execution scope of a single 
-- Select, Insert, Update, Delete, or Merge statement. 
-- This clause can also be used in a CREATE VIEW statement as part of its defining SELECT statement. 
-- A common table expression can include references to itself. 
-- This is referred to as a recursive common table expression.

-- Using WITH clause
WITH Total_Sales as (
    Select s.store_id, sum(s.cost) as Total_Sales_Per_Store
		From sales s
		Group by s.store_id
  ),
	Avg_Sales as
		(
      select cast(avg(Total_Sales_Per_Store) as int) Avg_Sale_For_All_Store
		  from Total_Sales
    )

Select *
From   Total_Sales Join Avg_Sales
On     Total_Sales.Total_Sales_Per_Store > Avg_Sales.Avg_Sale_For_All_Store;
----

-- More CTE's

With CTE_Employee as 
(
  Select Emp_Name, Dept_Name, Gender, Salary,
          Count(Gender) Over(Partition by Gender) as TotalGender,
          Avg(Salary) Over(Partition by Gender) as AvgSalary
  From Employee 
)
Select  e.Salary, e.AvgSalary
From    CTE_Employee e
Where   e.Salary > e.AvgSalary
AND     e.Gender = 'M'


























