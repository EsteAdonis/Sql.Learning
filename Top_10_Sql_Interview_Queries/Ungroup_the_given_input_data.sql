 -- Ungroup the given input data --- 
use adonis;

drop table travel_items;
Go
create table travel_items
(
	id              int,
	item_name       varchar(50),
	total_count     int
);
insert into travel_items values (1, 'Water Bottle', 2);
insert into travel_items values (2, 'Tent', 1);
insert into travel_items values (3, 'Apple', 4);

With cte as
(
    Select id, item_name, total_count, 1 as level
    From travel_items
    Union all
    Select cte.id, cte.item_name, cte.total_count -1, level + 1 as level
    From cte Join travel_items t on t.item_name = cte.item_name and t.id = cte.id
    Where cte.total_count > 1
)
Select id, item_name, total_count, level
from cte Order by item_name