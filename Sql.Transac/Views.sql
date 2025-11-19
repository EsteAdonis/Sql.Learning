Use [SQL-Learning];
GO

Insert Employee values(-345, 'Prometeo', '19980218')

Insert Employee values(-5, 'Cronos', '19810714')
Insert Employee values(401, 'Eris', '19890927')
GO

Select * From Employee
GO


Use AdventureWorks2022;
Go 
With OrderdOrders As
(
	Select SalesOrderId, OrderDate,
			Row_Number() Over(Order by OrderDate) as Row#
	From Sales.SalesOrderHeader
)

Select SalesOrderId,  OrderDate, Row#
From	OrderdOrders 
Where	Row# Between 50 and 60;

