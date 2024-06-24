select * from pizza_sales;
select sum(total_price) as Total_Revenue from pizza_sales;
select sum(total_price)/count(distinct order_id) as Average_ord_value from pizza_sales;
Select sum(quantity) as Total_Pizza_sold from pizza_sales
select count(distinct order_id) as Total_orders from pizza_sales
select Cast (sum(quantity) as decimal(10,2)) /cast (count(distinct order_id) as decimal(10,2)) as Total_orders from pizza_sales

--Hourly Trend for totoal Pizzas sold

Select DATEPART(Hour,order_time) as order_hour, sum(quantity) as Total_Pizzas_sold
from pizza_sales
Group by DATEPART(Hour,order_time)
order by DATEPART(Hour,order_time) ASC;

--- Weekly Trend for Total orders
Select DATEPART(ISO_Week, Order_date) as week_order,Year(order_date) as year, count(distinct order_id) as Total_orders from pizza_sales
group by DATEPART(ISO_Week, Order_date),Year(order_date)
order by DATEPART(ISO_Week, Order_date), Year(order_date) 

--Monthly Trend for Total order
Select DATEPART(Month,order_date) as Order_Month, year(order_date) as year, count(Distinct order_id) As total_orders
from pizza_sales
group by DATEPART(Month,order_date), year(order_date)
order by DATEPART(Month,order_date), year(order_date) Asc;

--Percentage of sales by Pizza Category for first month
select pizza_category,cast(sum(total_price) as decimal (10,2)) as total_price, cast(sum(total_price)*100/(select sum(total_price) from pizza_sales Where month(order_date)=1) as decimal(10,2))  as Percentage_of_sales
from pizza_sales
Where month(order_date)=1
group by pizza_category;

--Percentage of sales by Pizza Size - first quarter
select pizza_size, count(pizza_size) as total_orders, cast(sum(total_price) as decimal (10,2)) as total_price, cast(sum(total_price)*100/(select sum(total_price) from pizza_sales Where datepart(quarter,order_date)=1) as decimal(10,2))  as Percentage_of_sales
from pizza_sales
where datepart(quarter,order_date)=1
group by pizza_size
order by Percentage_of_sales desc;

---Top 5 selling Pizza Name -price
select top 5 pizza_name, sum(total_price) as Total_revenue
from pizza_sales
group by pizza_name
order by Total_revenue Desc;

--Bottom 5 selling Pizza Name - price
select top 5 pizza_name, sum(total_price) as Total_revenue
from pizza_sales
group by pizza_name
order by Total_revenue Asc;

---Top 5 selling Pizza Name - quantity
select top 5 pizza_name, sum(quantity) as Total_quantity
from pizza_sales
group by pizza_name
order by Total_quantity Desc;

--Bottom 5 selling Pizza Name - price
select top 5 pizza_name, sum(quantity) as Total_quantity
from pizza_sales
group by pizza_name
order by Total_quantity Asc;

---Top 5 selling Pizza Name - order_id
select top 5 pizza_name, count(distinct order_id) as Total_order
from pizza_sales
group by pizza_name
order by Total_order Desc;









