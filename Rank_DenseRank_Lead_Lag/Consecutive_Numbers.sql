-- SQL query to find consecutive numbers. This is an important medium level question asked in Amazon, Adobe and Google.

Create table  Logs (id int, num int);

insert into Logs (id, num) values ('1', '1');
insert into Logs (id, num) values ('2', '1');
insert into Logs (id, num) values ('3', '1');
insert into Logs (id, num) values ('5', '1');

insert into Logs (id, num) values ('4', '2');
insert into Logs (id, num) values ('6', '2');
insert into Logs (id, num) values ('7', '2');
insert into Logs (id, num) values ('8', '3');

select id, num,
       row_number() over (order by num, id) rankBase,
       id - row_number() over (order by num, id) rank 
from logs


Select DISTINCT l1.Num   from Logs l1, Logs l2
where l1.Id=l2.Id-1 
and l1.Num=l2.Num ;

Select DISTINCT l1.Num   
from Logs l1, Logs l2, Logs l3 
where l1.Id=l2.Id-1 
and   l2.Id=l3.Id-1 
and   l1.Num=l2.Num 
and   l2.Num=l3.Num;

select distinct num as ConsecutiveNums from
(select num, id - row_number() over (order by num, id) rank from logs) a
group by num,rank
having count(*) > 1;

