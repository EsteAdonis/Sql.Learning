use adonis
Go

Select top 3 * 
From  users 
Go

Select * From Customers 
Order by 1 
LIMIT 3 -- Is for MySql
Go


Select * From Users 
Fetch FIRST 3 ROWS ONLY; -- Oracle

SELECT * FROM Customers
FETCH FIRST 50 PERCENT ROWS ONLY;

Select top 50 Percent * From Users