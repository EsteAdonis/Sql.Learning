-- Numbers the output of a result set. More specifically, returns the sequential number of a row within a partition of a result set, starting at 1 for the first row in each partition.
-- ROW_NUMBER and RANK are similar. ROW_NUMBER numbers all rows sequentially (for example 1, 2, 3, 4, 5). RANK provides the same numeric value for ties (for example 1, 2, 2, 4, 5).

use AdventureWorks2022
Go
Select Row_Number() over(Order by name Asc) as Row#,
	   Name, recovery_model_desc
From sys.databases
Where database_id < 5


-- The PARTITION BY Clause on the recovery_model_desc column, 
-- When the recovery_model_desc value changes, restarts the numbering.

Select Row_Number() Over(Partition By recovery_model_desc Order by name Asc) as Row#,
	   name, recovery_model_desc
From sys.databases Where database_id < 5;

use AdventureWorks2022
Go
-- The following example calculates a row number for the salespeople in Adventure Works Cycles based on their year-to-date sales ranking.
Select Row_Number() Over(Order by SalesYTD Desc) as Row#,
				FirstName, LastName, Round(SalesYTD, 2,1) as "Sales YTD"
From 		Sales.vSalesPerson
Where 	TerritoryName is Not Null and SalesYTD <> 0


Select 	FirstName, lastName, TerritoryName, Round(SalesYTD, 2,1) as SalesYTD,
				Row_Number() Over(Partition by TerritoryName Order by SalesYTD Desc) as Row#
From 		Sales.vSalesPerson
Where 	TerritoryName Is not Null and SalesYTD <> 0
Order by TerritoryName;

SELECT p.FirstName, p.LastName  
    	,NTILE(4) OVER(ORDER BY SalesYTD DESC) AS Quartile  
    	,CONVERT(NVARCHAR(20),s.SalesYTD,1) AS SalesYTD  
    	,a.PostalCode  
FROM Sales.SalesPerson AS s   
INNER JOIN Person.Person AS p   
    ON s.BusinessEntityID = p.BusinessEntityID  
INNER JOIN Person.Address AS a   
    ON a.AddressID = p.BusinessEntityID  
WHERE TerritoryID IS NOT NULL  


DECLARE @NTILE_Var INT = 4;  
-- For each PostCode divided for group of four
SELECT p.FirstName, p.LastName  
    ,NTILE(@NTILE_Var) OVER(PARTITION BY PostalCode ORDER BY SalesYTD DESC) AS Quartile  
    ,CONVERT(NVARCHAR(20),s.SalesYTD,1) AS SalesYTD  
    ,a.PostalCode  
FROM Sales.SalesPerson AS s   
INNER JOIN Person.Person AS p   
    ON s.BusinessEntityID = p.BusinessEntityID  
INNER JOIN Person.Address AS a   
    ON a.AddressID = p.BusinessEntityID  
WHERE TerritoryID IS NOT NULL   
    AND SalesYTD <> 0;  
GO  


SELECT BusinessEntityID, YEAR(QuotaDate) AS SalesYear, SalesQuota AS CurrentQuota,   
       LAG(SalesQuota, 1,0) OVER (ORDER BY YEAR(QuotaDate)) AS PreviousQuota  
FROM Sales.SalesPersonQuotaHistory  
WHERE BusinessEntityID = 275 AND YEAR(QuotaDate) IN ('2005','2006'); 

SELECT TerritoryName, BusinessEntityID, SalesYTD,   
       LAG (SalesYTD, 1, 0) OVER (PARTITION BY TerritoryName ORDER BY SalesYTD DESC) AS PrevRepSales  
FROM Sales.vSalesPerson  
WHERE TerritoryName IN (N'Northwest', N'Canada')   
ORDER BY TerritoryName;

SELECT BusinessEntityID,
    YEAR(QuotaDate) AS SalesYear,
    SalesQuota AS CurrentQuota,
    LEAD(SalesQuota, 1, 0) OVER (ORDER BY YEAR(QuotaDate)) AS NextQuota
FROM Sales.SalesPersonQuotaHistory
WHERE BusinessEntityID = 275 

SELECT TerritoryName, BusinessEntityID, SalesYTD,
       LEAD (SalesYTD, 1, 0) OVER (PARTITION BY TerritoryName ORDER BY SalesYTD DESC) AS NextRepSales
FROM Sales.vSalesPerson
WHERE TerritoryName IN (N'Northwest', N'Canada')
ORDER BY TerritoryName;

-- AND YEAR(QuotaDate) IN ('2005','2006');