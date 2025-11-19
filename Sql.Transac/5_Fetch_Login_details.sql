use adonis;
Go;
-- From the login_details table, fetch the users who logged in consecutively 3 or more times.

--Table Structure:

Create Table login_details(
  Login_Id int primary key,
  User_Name varchar(50) not null,
  Login_date date
);


Begin tran
insert into login_details values
(101, 'Michael', GetDate()),
(102, 'James', GetDate()),
(103, 'Stewart', GetDate()+1),
(104, 'Stewart', GetDate()+1),
(105, 'Stewart', GetDate()+1),
(106, 'Michael', GetDate()+2),
(107, 'Michael', GetDate()+2),
(108, 'Stewart', GetDate()+3),
(109, 'Stewart', GetDate()+3),
(110, 'James', GetDate()+4),
(111, 'James', GetDate()+4),
(112, 'James', GetDate()+5),
(113, 'James', GetDate()+6),
(114, 'Vanessa', GetDate()+4),
(115, 'Vanessa', GetDate()+4),
(116, 'Vanessa', GetDate()+5),
(117, 'Vanessa', GetDate()+6),
(118, 'AmyAdams', GetDate()+4),
(119, 'AmyAdams', GetDate()+4),
(120, 'AmyAdams', GetDate()+5),
(121, 'AmyAdams', GetDate()+6);

select * from login_details;
Rollback tran

-- This is a good example of Partition
Select [User_Name], Login_date,
       Row_Number() Over(Partition by User_Name order by Login_date ) as rn
From login_details

-- From the login_details table, fetch the users who logged in consecutively 3 or more times
-- lead() is used to find data in the next record
-- lead(<column_name>, 2) is used to find data in the next two records

Select Distinct( User_Name )
From (
      Select *,
            Case When User_Name = lead(User_Name) Over(Order by login_Id) 
                          And User_Name = lead(User_Name, 2) Over(order by login_Id)
                Then User_Name
              else Null
            end as Repeated_Users
      from login_details ) x
Where x.Repeated_Users is not null 
