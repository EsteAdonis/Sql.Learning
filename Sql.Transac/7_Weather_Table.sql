use adonis
go;

Create Table Weather(
  Id int,
  City varchar(50),
  Temperature int,
  Day date
)
Go

Insert Into Weather Values
(1, 'México', -1, '2021-01-01'),
(2, 'México', -2, '2021-01-02'),
(3, 'México', 4, '2021-01-03'),
(4, 'México', 1, '2021-01-04'),
(5, 'México', -2, '2021-01-05'),
(6, 'México', -5, '2021-01-06'),
(7, 'México', -7, '2021-01-07'),
(8, 'México',  5,  '2021-01-08');


-- Fetch all the records when  México had Extremely cold temperature for 3 consecutive days or more
-- Approach: First using a sub query indentify all the records where the temperatur was very cold
-- and then use a main query to fetch only the records returned as very cold from the subquery. 
-- You will not only need to compare the records following the current row but also need to compare 
-- the records preceding the current row. 
-- And may also need to comprare rows preceding and following the current row.
-- Identify a window function can do this comparision pretty easily.
-- lag: Accesses data from a previous row in the same result set without the use of a self-join


Select Id, City, temperature, day
From (
    Select *, 
      Case 
          When temperature < 0 
                and lead(temperature) Over(Order by Day) < 0
                and lead(temperature,2) Over(Order by day) < 0
              Then 'Y'
          When temperature < 0
                and lag(temperature) Over(Order by day) < 0
                and lead(temperature) Over(Order by day) < 0
              Then 'Y'
          When Temperature < 0
                and lag(temperature) Over(Order by day) < 0
                and lag(temperature, 2) Over(Order by day) < 0
              Then 'Y'
      End as flag
    From Weather ) x
Where x.flag = 'Y'