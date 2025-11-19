use adonis;

drop table if exists cars;
create table cars
(
	model_id		int primary key,
	model_name	varchar(100),
	color			  varchar(100),
	brand			  varchar(100)
);
insert into cars values(1,'Leaf', 'Black', 'Nissan');
insert into cars values(2,'Leaf', 'Black', 'Nissan');
insert into cars values(3,'Model S', 'Black', 'Tesla');
insert into cars values(4,'Model X', 'White', 'Tesla');
insert into cars values(5,'Ioniq 5', 'Black', 'Hyundai');
insert into cars values(6,'Ioniq 5', 'Black', 'Hyundai');
insert into cars values(7,'Ioniq 6', 'White', 'Hyundai');

select * from cars;
-- Delete duplicated data from table cars
-- The goal is to keep only one record for each unique combination of model_name and brand.
-- Soluction 1:

Select * from cars
where model_id not in (
   Select min(model_id) from cars group by model_name, brand
);

-- Soluction 2:
WITH cte AS (
    Select model_id, brand, model_name,
           Row_number() Over (Partition BY model_name, brand Order BY model_id) AS rn
    From cars
) 
Select * from Cte where rn > 1;

-- Soluction 3:
delete from cars
where model_id in ( Select max(model_id) 
                    From cars 
                    Group by model_name, brand 
                    Having count(*) > 1
                  );
