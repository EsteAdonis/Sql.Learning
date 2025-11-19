use adonis
Select * From sys.tables

Select * From Customers

Delete From Customers 
Where Id in ( 9, 10, 14)

Select * From Customers
Go

With Sequence as (
  Select 1 as Number
  Union ALL
  Select Number + 1
  From Sequence
  Where Number <= (Select Max(id) From Customers)
)
Select Sequence.Number as MissingId
From Sequence 
Left Join Customers
On Sequence.Number = Customers.Id
Where Customers.Id Is NULL
Option (MaxRecursion 0);
Go

/*
  Today's Topic: CTEs
*/

Select *, ROW_NUMBER() over (partition by FirstName order by Id)
From Customers

Select * From SalesLT.ProductCategory



Select *
From (
Select Object_id
			, Row_Number() Over(Order by Object_id) as  Rank
from sys.columns
) x 
Where Rank > 200 and Rank < 500
And   Rank not in ( 301, 428, 499 )


Select COunt(*) From sys.columns
