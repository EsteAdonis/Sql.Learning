Use AdventureWorks2022
Go

-- Scalar Function: Returns full name
CREATE FUNCTION dbo.GetFullName
(
	@FirstName NVARCHAR(50),
	@LastName NVARCHAR(50)
)
RETURNS NVARCHAR(101)
AS
BEGIN
    RETURN @FirstName + ' ' + @LastName;
END;
GO

-- Usage
SELECT dbo.GetFullName('John', 'Doe') AS FullName;
Go
