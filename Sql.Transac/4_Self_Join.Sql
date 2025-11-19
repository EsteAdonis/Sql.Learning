use adonis;
GO

Select * from sysobjects where xtype = 'u'
Go;

Create Table Doctors (
  Id int primary key,
  [Name] varchar(50) not null,
  Speciality varchar(100),
  Hospital varchar(50),
  City varchar(50),
  Consultation_fee int
);
Go;

insert into doctors values
(1, 'Dr. Shashank', 'Ayurveda', 'Apollo Hospital', 'Bangalore', 2500),
(2, 'Dr. Abdul',  'Homeopathy', 'Fortis Hospital', 'Bangalore', 2000),
(3, 'Dr. Shwetha', 'Homeopathy', 'KMC Hospital', 'Manipal', 1000),
(4, 'Dr. Murphy', 'Dermatology', 'KMC Hospital', 'Manipal', 1500),
(5, 'Dr. Farhana', 'Physician', 'Gleneagles Hospital', 'Bangalore', 1700),
(6, 'Dr. Maryam', 'Physician', 'Gleneagles Hospital', 'Bangalore', 1500),
(7, 'Dr. Alexandro', 'X-Rays', 'San Javier', 'Guadalajara', 1500),
(8, 'Dr. Gonzalo', 'Urología', 'San Javier', 'Guadalajara', 1500);
Go;

Select * From doctors
Go

-- Use case: Fetch the Doctor's detail who work in the same hsopital but in different specialty
-- Approach: Use Self Join to solve this problem. Self Join is when you join the same table by itsel.
Select d.[name], h.Hospital, d.Speciality, h.Speciality
From   Doctors d Inner Join Doctors h
On     d.Hospital = h.Hospital 
And    d.Speciality != h.Speciality

-- Additional Query: Write Sql query to fetch the doctors who work in same hospital irrespective of their speciality
Select d.[name], h.Hospital, h.Speciality
From   Doctors d Inner Join Doctors h
On     d.Hospital = h.Hospital 
And    d.[name] != h.[Name]


Use AdventureWorks2022
GO

Select * from Person.Person