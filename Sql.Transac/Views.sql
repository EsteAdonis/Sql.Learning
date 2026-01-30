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
Go

-- CTE Recursiva
-- Step 1: Create the view with schemabinding
CREATE VIEW dbo.vwProductSales
WITH SCHEMABINDING
AS
	SELECT 
			od.ProductID,
			SUM(od.Quantity) AS TotalQty,
			COUNT_BIG(*) AS RowCount
	FROM dbo.Orders o
	INNER JOIN dbo.OrderDetails od
			ON o.OrderID = od.OrderID
	GROUP BY od.ProductID;1
Go

-- Step 2: Create a unique clustered index on the view
CREATE UNIQUE CLUSTERED INDEX IX_vwProductSales
ON dbo.vwProductSales(ProductID);
