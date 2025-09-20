use sql_projects;
select * from sql_projects.storesales_data;
alter table sql_projects.storesales_data rename to superstoresales;
select * from superstoresales;
# Retriving all columns for the record where the ship mmode is "Standardclas"
select * from superstoresales where `Ship Mode` = 'Standard Class';
# "Lose making Transections"
select * from superstoresales where Profit <0;
# sort first by region ascending order than  profit by decending order
select * from  superstoresales order by Region asc ,Profit desc;
# Aggregation Calculating the total sales, average profit, and maximum discount for all transactions..
select sum(Sales) as Total_sales,avg(Profit) as Average_profit, max(Discount) as maximum_Discount from superstoresales;
# retrive avgage sales,profit for each region
select Region , sum(Sales) as Total_sales ,sum(Profit) as Total_profit from superstoresales group by Region;
# For each segment calculate avg discount,quantity for each segment
select Segment , avg(Discount) as Average_Discount, avg(Quantity) as Average_Quantity from superstoresales group by Segment;
#  Sub categories where the avg profit is less than o
select `Sub-Category`,avg(Profit) from superstoresales group by `Sub-Category`  having avg(Profit) <0;
# transition with sales greter than avg sales
select * from superstoresales where Sales >(select avg(Sales) from superstoresales);
# Region where the total profit exceeds the total profit in the "Cental region
select Region  from superstoresales group by Region having  sum(Profit) >(select sum(Profit) from superstoresales where Region = "Central");
# CTE to find the top 5 profitable subcategory
with sub_category_profit as (select `Sub-Category` ,sum(Profit) as Total_profit from superstoresales group by `Sub-Category`) select * from sub_category_profit order by Total_profit desc limit 5;
# ANOTHER WAY  NOT USING CTE
select `Sub-Category` ,sum(Profit) as Total_profit From superstoresales group by `Sub-Category` order by  Total_profit desc limit 5;
#  Cities where the highest sales are greater thanthe avg sales across all region
select city
from superstoresales
where sales in (
    select max(Sales)
    from superstoresales
    group by Region
    having max(Sales) > (select avg(Sales) from superstoresales)
);
#   Rank products by thier profit with in each category
select Category,`sub-category`,profit ,rank()over (partition by Category order by profit desc) as profit_rank from superstoresales;
#   Pivot table showing total sales for each category across region
select Region,
sum(case when Category = "Furniture" then Sales else 0 end ) as Furniture_Sales,
sum(case when Category = 'Office Supplies' then Sales else 0 end ) as Office_Supplies_Sales,
sum(case when Category = "Technology" then Sales else 0 end ) as Technology_Sales
from  superstoresales
group by Region



