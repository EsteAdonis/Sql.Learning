use Adonis;
-- Query 9:
-- Find the top 2 accounts with the maximum number of unique patients on a monthly basis.
-- Note: Prefer the account if with the least value in case of same number of unique patients
--Table Structure:

-- drop table patient_logs;
Create Table Patient_logs (
  Account_id int,
  Date date,
  Patient_id int
);

insert into patient_logs values (1, '2020-01-02', 100);
insert into patient_logs values (1, '2020-01-27', 200);
insert into patient_logs values (2, '2020-01-01', 300);
insert into patient_logs values (2, '2020-01-21', 400);
insert into patient_logs values (2, '2020-02-21', 300);
insert into patient_logs values (2, '2020-01-01', 500);
insert into patient_logs values (3, '2020-01-20', 400);
insert into patient_logs values (1, '2020-03-04', 500);
insert into patient_logs values (3, '2020-01-20', 450);

select * from patient_logs Order by 1

-- Note: Prefer the account Id with the least value in case of save number of unique patients
-- Approach: First convert the date to month format since we need the output specific to each month.
-- Then group together all data bases on each month and account Id so you get the total num of patiens
-- belonging to each account per month basis.

-- Then rank this data as per no of patients in descendingt order and account Id in ascending order
-- so in case there are same num of patients present under multiple account if then the ranking will
-- prefer the account if with lower value. Finally, choose upto 2 records only per month to arrive at the final ouput.

-- Solution:
select a.month, a.account_id, a.no_of_unique_patients
from (
		select x.month, x.account_id, no_of_unique_patients,
			row_number() over (partition by x.month order by x.no_of_unique_patients desc) as rn
		from (
				select pl.month, pl.account_id, count(1) as no_of_unique_patients
				from (select distinct to_char(date,'month') as month, account_id, patient_id
						from patient_logs) pl
				group by pl.month, pl.account_id) x
     ) a
where a.rn < 3;

Select month, account_id, no_of_patients
From (

Select *,
      rank() Over(partition by month order by No_of_Patients desc, account_id) as Rnk
From (

Select Month, Account_Id, count(1) as No_of_Patients
  From  (
        Select Distinct Format(Date, 'MMMM') as Month, Account_Id, Patient_Id
        From Patient_logs
      ) pl 
Group by month, account_Id ) x
) temp
Where temp.rnk in (1, 2)


