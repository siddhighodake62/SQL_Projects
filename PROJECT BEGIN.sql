create database if not exists pizzas;
USE PIZZAS;

-- CREATE DATABASE -> GOTO DATAABSE NAME -> RIGHT CLICK -> SELECT TABLE DATA IMPORT WIZARD(5TH OPTION) -> SELECT FILE -> CREATE TABLE ->NEXT ->FINISH

SELECT * FROM PIZZA_TYPES;
SELECT * FROM PIZZAS;
SELECT * FROM ORDER_DETAILS;
SELECT * FROM ORDERS;

-- Basic:
-- 1. Retrieve the total number of orders placed.
	SELECT COUNT(ORDER_ID) FROM ORDERS;
    -- OR 
    SELECT COUNT(distinct ORDER_ID) FROM ORDER_DETAILS;
    
-- 2. Calculate the total revenue generated from pizza sales.
	SELECT SUM(OD.QUANTITY * P.PRICE) AS TOTAL_REVENUE
    FROM ORDER_DETAILS OD
    JOIN PIZZAS P ON OD.PIZZA_ID= P.PIZZA_ID;
    
-- 3. Identify the highest-priced pizza.
       SELECT
		pt.name AS pizza_name,
		p.price FROM pizzas p 
        JOIN pizza_types pt ON p.pizza_type_id = pt.pizza_type_id
        where p.price = (SELECT MAX(PRICE)FROM PIZZAS) ;
        
		-- order by price desc
        -- limit 1;
       
-- 4. Identify the most common pizza size ordered.
		select
        p.size as size,
        sum(od.quantity) as total_order
        from order_details od
        join pizzas as p on p.pizza_id=od.pizza_id
        group by p.size
		order by total_order desc
        limit 1;

-- 5. List the top 5 most ordered pizza types along with their quantities.
		select pt.name as pizza_type,
       sum( od.quantity) as orders
        from order_details od
		join pizzas as p on p.pizza_id=od.pizza_id
        join pizza_types as pt on p.pizza_type_id= pt.pizza_type_id
        group by name
		order by orders desc
        limit 5;
        
-- Intermediate:
-- 6. Join the necessary tables to find the total quantity of each pizza category ordered.
		select pt.category as pizza_type,
       sum( od.quantity) as Total_quantity
        from order_details od
		join pizzas as p on p.pizza_id=od.pizza_id
        join pizza_types as pt on p.pizza_type_id= pt.pizza_type_id
        group by category;
        
-- 7. Determine the distribution of orders by hour of the day.
		select hour(o.time) as hour_of_day,
        sum(od.quantity) as total_quantity
        from order_details od
        join orders o on od.order_id=o.order_id
        group by hour_of_day;
        
        
-- 8. Join relevant tables to find the category-wise distribution of pizzas.
	select pt.category as categoty_wise,
        count(p.pizza_id) as pizzas
        from pizzas p
        join pizza_types pt on p.pizza_type_id=pt.pizza_type_id
        group by categoty_wise;
        
-- 9. Group the orders by date and calculate the average number of pizzas ordered per day.
		select o.date ,avg(od.quantity) as average_pizza
        from order_details od
        join orders o 
        on od.order_id=o.order_id
        group by date;
        
-- 10. Determine the top 3 most ordered pizza types based on revenue.
	SELECT SUM(OD.QUANTITY * P.PRICE) AS TOTAL_REVENUE,
    PT.NAME AS PIZZA_TYPES 
    FROM PIZZAS P
    JOIN ORDER_DETAILS OD ON P.PIZZA_ID= OD.PIZZA_ID
	JOIN PIZZA_TYPES PT ON P.PIZZA_TYPE_ID= PT.PIZZA_TYPE_ID
	group by PIZZA_TYPES
	order by total_revenue desc
    LIMIT 3;
    
-- Advanced:

-- 11. Calculate the percentage contribution of each pizza type to total revenue.
SELECT pt.name AS pizza_type,
ROUND(SUM(od.quantity * p.price), 2) AS revenue,
ROUND((SUM(od.quantity * p.price) / (SELECT SUM(od2.quantity * p2.price) FROM order_details od2
JOIN pizzas p2 ON od2.pizza_id = p2.pizza_id)) * 100, 2) AS percentage_contribution
FROM order_details od
JOIN pizzas p ON od.pizza_id = p.pizza_id
JOIN pizza_types pt ON p.pizza_type_id = pt.pizza_type_id
GROUP BY pt.name
ORDER BY percentage_contribution DESC;

-- 12. Analyze the cumulative revenue generated over time.
SELECT o.date,
ROUND(SUM(od.quantity * p.price), 2) AS daily_revenue,
ROUND(SUM(SUM(od.quantity * p.price)) OVER (ORDER BY o.date), 2) AS cumulative_revenue FROM orders o
JOIN order_details od ON o.order_id = od.order_id
JOIN pizzas p ON od.pizza_id = p.pizza_id
GROUP BY o.date
ORDER BY o.date;

-- 13.* Determine the top 3 most ordered pizza types based on revenue for each pizza category.

SELECT category, name AS pizza_type, revenue
FROM (
  SELECT
    pt.category,
    pt.name,
    ROUND(SUM(od.quantity * p.price), 2) AS revenue,
    RANK() OVER (
      PARTITION BY pt.category
      ORDER BY SUM(od.quantity * p.price) DESC
    ) AS rank_in_category
  FROM order_details od
  JOIN pizzas p ON od.pizza_id = p.pizza_id
  JOIN pizza_types pt ON p.pizza_type_id = pt.pizza_type_id
  GROUP BY pt.category, pt.name
) AS ranked
WHERE rank_in_category <= 3
ORDER BY CATEGORY,revenue DESC;  -- OK here!



-- 14 Determine the top 3 most ordered pizza based on revenue for each pizza category.
	SELECT SUM(OD.QUANTITY * P.PRICE) AS TOTAL_REVENUE,
    PT.CATEGORY AS CATEGORY
    FROM PIZZAS P
    JOIN ORDER_DETAILS OD ON P.PIZZA_ID= OD.PIZZA_ID
	JOIN PIZZA_TYPES PT ON P.PIZZA_TYPE_ID= PT.PIZZA_TYPE_ID
	group by CATEGORY
    order by total_revenue desc
LIMIT 3;

-- select o.date ,avg(od.quantity) as average_pizza
--         from order_details od
--         left join orders o 
--         on od.order_id=o.order_id
--         group by date
--         union 
--         select o.date ,avg(od.quantity) as average_pizza
--         from order_details od
--         left join orders o 
--         on od.order_id=o.order_id
--         group by date;

