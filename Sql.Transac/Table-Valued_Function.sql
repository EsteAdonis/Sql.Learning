Use AdventureWorks2022
Go

-- Table-Valued Function: Returns orders above a certain amount
CREATE FUNCTION dbo.GetOrdersAboveAmount
(
    @Amount DECIMAL(10,2)
)
RETURNS TABLE
AS
RETURN
(
    SELECT OrderID, CustomerID, OrderDate, TotalAmount
    FROM Orders
    WHERE TotalAmount > @Amount
);
GO

-- Usage
SELECT * FROM dbo.GetOrdersAboveAmount(500);