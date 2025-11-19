Use BikeStores;
Go

With cte_org AS (
  Select staff_id, first_name, manager_id
  From   sales.staffs
  Where  manager_id is null
  Union All
  Select e.staff_id, e.first_name, e.manager_id
  From   sales.staffs e
  Inner Join cte_org o ON o.staff_id = e.manager_id
)
Select * From cte_org;