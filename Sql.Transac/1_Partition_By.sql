Create DataBase Pantheon;
Go

Use Pantheon;
Go




Begin tran
  Create Table [dbo].[Users] (
      User_Id INT NOT NULL,
      User_Name varchar(30) not null,
      User_Description varchar(100), 
      Email varchar(50),
			Manager_Id Int null,
			Salary Decimal(18,2),	
      CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED ([User_Id] ASC)
  );

  Insert Into Users Values
      (1, 'Adonis', 'Dios hermoso y bello desado por las diosas', 'Adonis@gmail.com', 16, floor(Rand() * 100000) + 100),
      (2, 'Atenea', 'Diosa de la sabiduría, la guerra y las artes', 'Atenea@gmail.com', 16, floor(Rand() * 100000) + 100),
      (3, 'Eris', 'Diosa de la discordia y el conflicto',  'Eris@gmail.com', 16, floor(Rand() * 100000) + 100),
      (4, 'Amy Adams', 'Diosa de la belleza y sonrisa', 'amyadams@gmail.com', 16, floor(Rand() * 100000) + 100),
      (5, 'Vanessa', 'Reyna del encanto y del escapismo', 'ferguson@gmail.com', 10, floor(Rand() * 100000) + 100),
      (6, 'Tayde', 'Diosa de la amgura y alegría', 'tedy@gmail.com', 10, floor(Rand() * 100000) + 100),
      (7, 'Evelyn', 'Reyna del desastre y del ocio', 'evelyn@gmail.com', 10, floor(Rand() * 100000) + 100),
      (8, 'Israel', 'Rey de la flojera y de los juegos', 'polin@gmail.com', 10, floor(Rand() * 100000) + 100),
      (9, 'Bombis', 'Rey del conocmiento Maya y Azteca', 'ulises@gmail.com', 10, floor(Rand() * 100000) + 100),
      (10, 'Graciela', 'Diosa y Reina de la familia Ochoa Perez', 'chela@gmail.com', 18, floor(Rand() * 100000) + 100),
      (11, 'Ouito', 'Dios de la talabarteria y de los maestros bolseros', 'ouito@gmail.com', null, floor(Rand() * 100000) + 100),
      (12, 'Hera', 'Queen of the gods, goddess of marriage and family', 'hera@gmail.com', null, floor(Rand() * 100000) + 100),
      (13, 'Annabeth Chase', ' Hija de Atenea', 'annabeth@outlook.com', null, floor(Rand() * 100000) + 100),
      (14, 'Eris', 'Diosa de la discordia y el conflicto',  'Eris@gmail.com', 23, floor(Rand() * 100000) + 100),
      (15, 'Thalia Grace', 'Hijana de Zeus', 'thalia@hotmail.com', 23, floor(Rand() * 100000) + 100),
      (16, 'Dionisio', 'Dios del vino, la fiesta y el teatro',  'dionisio@gmail.com', null, floor(Rand() * 100000) + 100),
      (17, 'Hades', ' God of the underworld',  'hades@gmail.com', 24, floor(Rand() * 100000) + 100),
			(18, 'Aphrodite', 'Goddess of love and beauty',  'aphrodite@gmail.com', 22, floor(Rand() * 100000) + 100),
			(19, 'Poseidon', 'God of the sea, earthquakes, and horses',  'poseidon@gmail.com', null, floor(Rand() * 100000) + 100),
			(20, 'Apollo', 'God of the sun, music, and prophecy',  'apollo@gmail.com', 22, floor(Rand() * 100000) + 100),
			(21, 'Zeus', 'King of the gods, god of the sky, lightning, and thunder',  'zeus@gmail.com', 22, floor(Rand() * 100000) + 100),
			(22, 'Chronos', 'The personification of time',  'chronos@gmail.com', null, floor(Rand() * 100000) + 100),
			(23, 'Rhea', 'Mother of the Olympian gods',  'rhea@gmail.com', 24, floor(Rand() * 100000) + 100),
			(24, 'Styx', 'River that flows - transition between life and deaths',  'styx@gmail.com', null, floor(Rand() * 100000) + 100),
			(25, 'Eos', 'Goddess of the dwan' ,  'styx@gmail.com', 24, floor(Rand() * 100000) + 100);
  Select * From users
Rollback tran 

--  Fetch duplicated records (the Repited User)
Select Count(User_Name) as Counter, User_Name
From  Users
Group by (User_Name)
Having Count(User_Name)> 1

Select User_Name, 
			 User_Description,
       Row_Number() Over(Order by User_Name) as Row_num
From   Users



-- Find the 3rd highest salary - Artifac.
Select 	User_Id,
				Salary, 
				Row_Number() Over(Order by Salary Desc) as Rank
From 		Users
 
-- Find the 3rd highest salary.
Select Salary
From 	Users u inner join 
( Select 	User_Id,
					Row_Number() Over(Order by Salary Desc) as Rank
	From 		Users
) as x 
on u.user_id = x.user_id and Rank = 3


-- Find the 3rd highest salary.
With RankedSalaries as (
	Select 	User_Id, Salary,
					Row_Number() Over(Order by Salary Desc) as Rank
	From 		Users
)
Select Salary
From  RankedSalaries
Where Rank = 3

-- Find the 3rd highest salary.
Select top 1 Salary
From (
			Select distinct top 3 Salary 
			From 	users
			Order by Salary Desc 
	) as TopSalary
Order by Salary Asc

-- Find the 3rd highest salary.
Select Distinct Salary
From 	Users
Order by Salary Desc
Offset 2 rows Fetch Next 1 Rows only

-- Explanation:
-- OFFSET 2 ROWS skips the first two highest salaries.
-- FETCH NEXT 1 ROWS ONLY retrieves the next salary, which is the 3rd highest.


-- Artifact
Select distinct Manager_id   --- 10, 16, 18, 22, 23, 24 
From 	Users

-- Find the manager's name
Select Distinct m.User_Id, m.User_Name
From 		Users u Inner Join Users m
			on u.Manager_Id = m.[User_Id]



-- Getting the 2do Highest Salary
Select Salary
From 	Users u 
Where u.salary = (
	Select 	Max(Salary) as Salary
	From 		Users
	Where   Salary < (Select Max(Salary) from Users)
)  



-- PARTITION BY
-- Divides the query result set into partitions. 
-- The window function is applied to each partition separately and computation restarts for each partition.
-- If PARTITION BY isn't specified, the function treats all rows of the query result set as a single partition.

Select User_Name, User_Description,
       Row_Number() Over(Partition by user_description Order by User_Name) as Row_num
From   Users

Select User_Id, User_Name, User_Description,
       Row_Number() Over(Partition by user_name Order by User_Id) as Row_num
From Users

Select user_id, user_name, email
From (
      Select User_Id, User_Name, email,
             Row_Number() Over(Partition by user_name Order by User_Name) as Repited
      From Users
     ) x
Where x.Repited > 1
