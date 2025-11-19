-- SQL Query to fetch “N” consecutive records from a table based on a certain condition

use adonis;

Create Table Wheather
(
    Id INT PRIMARY KEY,
    City NVARCHAR(50),
    Temperature Int,
    RecordedAt Date
);
insert into Wheather values
	(1, 'London', -1, '2021-01-01'),
	(2, 'London', -2, '2021-01-02'),
	(3, 'London', 4, '2021-01-03'),
	(4, 'London', 1, '2021-01-04'),
	(5, 'London', -2, '2021-01-05'),
	(6, 'London', -5, '2021-01-06'),
	(7, 'London', -7, '2021-01-07'),
	(8, 'London', 5, '2021-01-08'),
	(9, 'London', -20, '2021-01-09'),
	(10, 'London', 20, '2021-01-10'),
	(11, 'London', 22, '2021-01-11'),
	(12, 'London', -1, '2021-01-12'),
	(13, 'London', -2, '2021-01-13'),
	(14, 'London', -2, '2021-01-14'),
	(15, 'London', -4, '2021-01-15'),
	(16, 'London', -9, '2021-01-16'),
	(17, 'London', 0, '2021-01-17'),
	(18, 'London', -10, '2021-01-18'),
	(19, 'London', -11, '2021-01-19'),
	(20, 'London', -12, '2021-01-20'),
	(21, 'London', -11, '2021-01-21');

Select * From Wheather
Go;
  
With myrecords as
  (
    Select * , count(*) over(partition by difference) as no_of_records
    From (
          SELECT *,
              Row_Number() over (order by id ) as RowNum,
              id - (Row_Number() over (order by id)) as difference
          FROM   Wheather
          WHERE Temperature < 0
        ) as result
  )
  Select * From myrecords
  Where no_of_records = 5

---
-- Fetch Record from Table Where there are orders for 3 consecutive days

Create Table Orders_Searching_N
(
    Order_Id varchar(20) PRIMARY KEY,
    OrderDate Date,
);

Insert Orders_Searching_N Values('Order1001', '2021-01-01'),
('Order1002', '2021-01-02'),
('Order1003', '2021-02-01'),
('Order1004', '2021-02-02'),
('Order1005', '2021-02-03'),
('Order1006', '2021-02-03'),
('Order1007', '2021-03-01'),
('Order1008', '2021-06-01'),
('Order1009', '2021-12-25'),
('Order1010', '2021-12-26');  

Select * From Orders
Go;



With ConsecutiveOrders as
(
    Select *,
        Row_Number() over (order by order_id) as RowNum,
        DateAdd(dd, - cast (Row_Number() over (order by Order_Id) as int), OrderDate) as Difference
    From Orders_Searching_N
), 
ConsecutiveOrdersWithCount as
(
Select * , count(*) over(partition by Difference) as NoOfRecords
From ConsecutiveOrders
)
Select * From ConsecutiveOrdersWithCount
Where NoOfRecords = 3 
