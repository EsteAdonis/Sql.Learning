use adonis
-- https://www.youtube.com/watch?v=zAmJPdZu8Rg
-- DROP TABLE product;
Create Table Product
( 
	Product_Category varchar(255),
	Brand varchar(255),
	Product_Name varchar(255),
	Price int
);

INSERT INTO product VALUES
('Phone', 'Apple', 'iPhone 12 Pro Max', 1300),
('Phone', 'Apple', 'iPhone 12 Pro', 1100),
('Phone', 'Apple', 'iPhone 12', 1000),
('Phone', 'Samsung', 'Galaxy Z Fold 3', 1800),
('Phone', 'Samsung', 'Galaxy Z Flip 3', 1000),
('Phone', 'Samsung', 'Galaxy Note 20', 1200),
('Phone', 'Samsung', 'Galaxy S21', 1000),
('Phone', 'OnePlus', 'OnePlus Nord', 300),
('Phone', 'OnePlus', 'OnePlus 9', 800),
('Phone', 'Google', 'Pixel 5', 600),
('Laptop', 'Apple', 'MacBook Pro 13', 2000),
('Laptop', 'Apple', 'MacBook Air', 1200),
('Laptop', 'Microsoft', 'Surface Laptop 4', 2100),
('Laptop', 'Dell', 'XPS 13', 2000),
('Laptop', 'Dell', 'XPS 15', 2300),
('Laptop', 'Dell', 'XPS 17', 2500),
('Earphone', 'Apple', 'AirPods Pro', 280),
('Earphone', 'Samsung', 'Galaxy Buds Pro', 220),
('Earphone', 'Samsung', 'Galaxy Buds Live', 170),
('Earphone', 'Sony', 'WF-1000XM4', 250),
('Headphone', 'Sony', 'WH-1000XM4', 400),
('Headphone', 'Apple', 'AirPods Max', 550),
('Headphone', 'Microsoft', 'Surface Headphones 2', 250),
('Smartwatch', 'Apple', 'Apple Watch Series 6', 1000),
('Smartwatch', 'Apple', 'Apple Watch SE', 400),
('Smartwatch', 'Samsung', 'Galaxy Watch 4', 600),
('Smartwatch', 'OnePlus', 'OnePlus Watch', 220);

-- All the SQL Queries written during the video

select * from product;


-- FIRST_VALUE 
-- Write query to display the most expensive product under each category (corresponding to each record)
Select *,
      First_Value(Product_Name) Over(Partition by Product_category order by price desc) as most_exp_product
from  product;


-- LAST_VALUE 
-- Write query to display the least expensive product under each category (corresponding to each record)
Select *,
        First_Value(product_name) 
            Over(Partition by Product_Category Order By Price desc) 
            as Most_Exp_Product,
        Last_Value(product_name) 
            Over(Partition by Product_Category Order by price desc
                 Range between unbounded preceding and unbounded following) -- Frame Clause is a subset of partition
            as least_exp_product    
from product
WHERE product_category ='Phone';



-- Alternate way to write SQL query using Window functions
Select *,
        First_value(product_name) over w as most_exp_product,
        Last_value(product_name) over w as least_exp_product    
From product
Where   product_category ='Phone'
Window w as (partition by product_category order by price desc
             range between unbounded preceding and unbounded following);
            

            
-- NTH_VALUE 
-- Write query to display the Second most expensive product under each category.
select *,
first_value(product_name) over w as most_exp_product,
last_value(product_name) over w as least_exp_product
-- NTH_VALUE(product_name, 5) over w as second_most_exp_product
from product
window w as (partition by product_category order by price desc
            range between unbounded preceding and unbounded following);



-- NTILE
-- The NTILE function in SQL is a window function that distributes rows of an ordered partition into a specified number of approximately equal groups, or buckets. It assigns each group a bucket number starting from one
-- Write a query to segregate all the expensive phones, mid range phones and the cheaper phones.
Select  x.product_name, 
        Case When x.buckets = 1 Then 'Expensive Phones'
            When x.buckets = 2 Then 'Mid Range Phones'
            When x.buckets = 3 Then 'Cheaper Phones' 
        END as Phone_Category, 
        Price, 
        Buckets
from (
        Select *,
        Ntile(3) over (order by price desc) as buckets  -- It's creates their owrn distribution
        From product
        Where product_category = 'Phone'
    ) x;




-- CUME_DIST (cumulative distribution):
-- In SQL Server, you can use the CUME_DIST() window function to calculate the cumulative distribution 
-- of a value within a result set. This function returns a value between 0 and 1, 
-- representing the proportion of rows with values less than or equal to the current row's value.
/*  Formula = Current Row no (or Row No with value same as current row) / Total no of rows */

Select  *, 
        Cume_Dist() Over(Order by price desc) as Cume_Distribution,
        Round(Cume_Dist() Over(Order by price desc) * 100, 2) as Cume_dist_percentage
From Product;


-- Query to fetch all products which are constituting the first 30% 
-- of the data in products table based on price.
-- 1/27, 2/27, 3/27... 26/27, 27/27

Select product_name, cume_dist_percetage
from (
    Select *,
            Cume_dist() over (order by price desc) as Cume_Distribution,
            Round(Cume_dist() over (order by price desc) * 100,2) as cume_dist_percetage
    From product ) x
where x.cume_dist_percetage <= 30;



-- PERCENT_RANK (relative rank of the current row / Percentage Ranking)
/* Formula = Current Row No - 1 / Total no of rows - 1 */

-- Query to identify how much percentage more expensive is "Galaxy Z Fold 3" when compared to all products.
-- Keep in mind that that the percent_rank is order by price
Select product_name, per_rank
From (
        select *,
                percent_rank() over(order by price) as Percentage_Rank ,
                round(percent_rank() over(order by price) * 100, 2) as per_rank
        From product
    ) x
where x.product_name='Galaxy Z Fold 3';

