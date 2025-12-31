Begin tran

	Create table #TempEmployeeSalaries (
		FirstName nvarchar(50),
		LastName nvarchar(50)
	)

	Insert Into #TempEmployeeSalaries (FirstName, LastName) 
	Values	('Adonis', 'Eris'), ('Adonis', 'Eris'),  ('Adonis', 'Eris'), 
					('Amy', 'Adamas'), ('Amy', 'Adamas'), ('Amy', 'Adamas'), 
					('Vanessa', 'Ferguson'), ('Vanessa', 'Ferguson'), 
					('Sandra', 'Bulock'), ('Sandra', 'Bulock'), ('Sandra', 'Bulock')


	With Cte as (
		Select FirstName, LastName,
					Row_Number() Over (Partition by FirstName, LastName Order by FirstName) as RowNumber
		From #TempEmployeeSalaries 
	)
	Delete From Cte Where RowNumber > 1;

	Select Distinct * From #TempEmployeeSalaries 

	Select FirstName, LastName 
	From #TempEmployeeSalaries 
	Group by FirstName, LastName 



	-- 1. Get unique rows into a temp table
	SELECT DISTINCT * INTO #TempTable FROM #TempEmployeeSalaries ;

	-- 2. Clear the original table
	TRUNCATE TABLE #TempEmployeeSalaries ;

	-- 3. Put the unique rows back
	INSERT INTO #TempEmployeeSalaries  SELECT * FROM #TempTable;

	-- 4. Cleanup
	DROP TABLE #TempTable;
Rollback tran 



Begin tran
	Create table #TempEmployeesDuplicated (
		Id int identity(1,1) primary key,
		FirstName nvarchar(50),
		LastName nvarchar(50)
	)

	Insert Into #TempEmployeesDuplicated (FirstName, LastName) 
	Values	('Adonis', 'Eris'), ('Adonis', 'Eris'),
					('Amy', 'Adamas'), ('Amy', 'Adamas'), ('Amy', 'Adamas'), 
					('Vanessa', 'Ferguson'), ('Vanessa', 'Ferguson'), 
					('Sandra', 'Bulock'), ('Sandra', 'Bulock')

	Select * From #TempEmployeesDuplicated

	-- Groping by more one column
	Select Min(Id) as Id, FirstName, LastName 
	From #TempEmployeesDuplicated	
	Group by FirstName, LastName
	Order by id

	-- Deleting Duplicates
	Delete From #TempEmployeesDuplicated	
	Where Id Not in (
    Select Min(Id)
    From 	#TempEmployeesDuplicated	
    Group BY FirstName, LastName
 );

Rollback tran


