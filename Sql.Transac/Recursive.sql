use adonis;
Go
Create table Family_members
(
    Person_Id varchar(10) PRIMARY KEY,
    Relative_Id1 nvarchar(10),
    Relative_Id2 nvarchar(10)
);

EXEC sp_rename 'Relatives', 'Family_members';
Insert Family_members Values ( 'ATR-1', 'ATR-2', null),
                        ( 'ATR-2', 'ATR-2', null),
                        ( 'ATR-3', 'ATR-2', null),                        
                        ( 'ATR-4', 'ATR-2', null),
                        ( 'ATR-5', 'ATR-2', null),

                        ( 'BTR-1', null, null),
                        ( 'BTR-2', null, 'BTR-1'),
                        ( 'BTR-3', null, 'BTR-2'),
                        ( 'BTR-4', null, 'BTR-3'),
                        ( 'BTR-5', null, 'BTR-4'),

                        ( 'CTR-1', null, null),
                        ( 'CTR-2', 'CTR-1', null),
                        ( 'CTR-3', null, null),  

                        ( 'DTR-1', 'DTR-3', 'ETR-2'),
                        ( 'DTR-2', null, null),
                        ( 'DTR-3', null, null),

                        ( 'ETR-1', null, 'DTR-2'),
                        ( 'ETR-2', null, null),
                        ( 'FTR-1', null, null),
                        ( 'FTR-2', null, null),
                        ( 'FTR-3', null, null),

                        ( 'GTR-1', 'GTR-1', null),
                        ( 'GTR-2', 'GTR-1', null),
                        ( 'GTR-3', 'GTR-1', null),
                        ( 'HTR-1', 'GTR-1', null),
                        ( 'HTR-2', 'GTR-1', null),
                        ( 'HTR-3', 'GTR-1', null),
                        ( 'ITR-1', null, null),
                        ( 'ITR-2', 'ITR-3', 'ITR-1');
Go;

Select * From Family_members

With  Related_fam_members as 
  (
    Select * From base_query
    union
    Select fam.Person_id, r.fam_group
    from Related_fam_members r
    Join Family_members fam
         on fam.relative_id1 = r.relatives 
         or fam.relative_id2 = r.relatives ),
    base_query as
    ( Select Relative_Id1 as relatives, substring(person_id,1,3) as fam_group
      from Family_members where relative_id1 is not NULL
      union 
      Select relative_id2 as relatives, substring(person_id, 1, 3 ) as fam_group
      from Family_members where relative_id2 is not NULL order by 1 )

    Select string_agg(relatives, ', ') as relatives
    from   Related_fam_members
    order by 1
           fam_group
    -- from related_fam_memebers
    -- group by fam_group
    -- order by 1;
  
-----
Go

-- -- Recursive CTE in Sql Server - Sintax
-- With expression_name (column_list) as (
--   -- Anchor member
--   -- Initial Query
--   Union all
--   -- Recursive member
--   -- Query that references the CTE itself or Recursive memeber CTE
-- )
-- Select * From expression_name

-- A recursive CTE consists of three main parts:
-- 1. Anchor Member: The initial query that returns the base result set.
-- 2. Recursive Member: The query that references the CTE itself and is union-ed with the anchor member using the UNION ALL operator.
-- 3. Termination Condition: A condition in the recursive member that stops the recursion


With cte_numbers(n, weekday) as (
  Select 0, DateName(dw, 0)
  Union all
  Select n + 1, DateName(dw, n + 1)
  From cte_numbers
  Where n < 6
)
Select weekday from cte_numbers
-- In this example:
-- 1. The anchor member returns Monday.
-- 2. The recursive member returns the next day, incrementing the day number until it reaches 6 (Saturday).
-- 3. The termination condition is n < 6, which stops the recursion when n is 6
Go;

-- Display number from 1 to 10 using Recursive CTE
With Numbers as 
(
  Select 1 as Number
  Union All
  Select Number + 1
  From   Numbers
  Where  Number < 10
)
Select * From Numbers


-- Find the hierarchy of employees under a given manager "Amy Adamas".
-- Select * From sys.objects 
-- Where name = 'Emp_Details' and type = 'U';
-- Select Object_id('Emp_Details') as ObjectId;

Use Adonis;
Go

Create Table Emp_Details
(
    Emp_Id int primary key,
    Emp_Name nvarchar(50),
    Manager_Id int,
    Salary int, 
    Designation varchar(30)
);

Insert into Emp_Details Values
(1, 'Amy Adamas', null, 100000, 'Manager'),
(2, 'Eris', 5, 80000, 'Team Lead'),
(3, 'Vanessa', 5, 70000, 'Team Lead'),
(4, 'Kirby', 5, 60000, 'Developer'),
(5, 'Elizabeth', 7, 60000, 'Developer'),
(6, 'Adonis', 7, 60000, 'Developer'),
(7, 'Prometeo', 1, 60000, 'Developer'),
(8, 'Poseidon', 1, 50000, 'Tester'),
(9, 'Tayde', 8, 50000, 'Tester'),
(10, 'Evelyn', 8, 50000, 'Tester');
Go

With cte_emp_hierarchy as (
  Select Emp_Id, Emp_Name, Manager_Id, Salary, Designation
  From   Emp_Details
  Where  Emp_Name = 'Amy Adamas'
  Union  All
  Select e.Emp_Id, e.Emp_Name, e.Manager_Id, e.Salary, e.Designation
  From   cte_emp_hierarchy h Inner Join Emp_Details e 
         On h.Emp_Id = e.Manager_Id
)
Select * From cte_emp_hierarchy



