 -- IPL Matches --- 

use adonis;
go

drop table teams;
Go
create table teams
(
  team_code varchar(10),
  team_name varchar(40)
);

insert into teams values ('RCB', 'Royal Challengers Bangalore');
insert into teams values ('MI', 'Mumbai Indians');
insert into teams values ('CSK', 'Chennai Super Kings');
insert into teams values ('DC', 'Delhi Capitals');
insert into teams values ('RR', 'Rajasthan Royals');
insert into teams values ('SRH', 'Sunrisers Hyderbad');
insert into teams values ('PBKS', 'Punjab Kings');
insert into teams values ('KKR', 'Kolkata Knight Riders');
insert into teams values ('GT', 'Gujarat Titans');
insert into teams values ('LSG', 'Lucknow Super Giants');
Select * from teams
Go
-- Soluction 1: Using CTE
with matches as
(
  select row_number() over(order by team_name) as id, t.*
  from   teams t
)   
select team.team_name as team, opponent.team_name as opponent
from   matches team Join matches opponent 
       on team.id < opponent.id
order by team;


-- Soluction 2: Each team plays with every other team Twice
with matches as
(
  select row_number() over(order by team_name) as id, t.*
  from   teams t
)   
select team.team_name as team, opponent.team_name as opponent
from   matches team Join matches opponent 
       on team.id <> opponent.id
order by team;