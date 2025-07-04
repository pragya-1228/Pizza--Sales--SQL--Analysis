-- 1. Find the total quantity of each pizza category ordered
SELECT 
    pt.category,
    SUM(od.quantity) AS total_quantity
FROM 
    pizza_types pt
    JOIN pizzas p ON pt.pizza_type_id = p.pizza_type_id
    JOIN order_details od ON od.pizza_id = p.pizza_id
GROUP BY 
    pt.category
ORDER BY 
    total_quantity DESC;

-- 2. Determine the distribution of orders by hour of the day
SELECT 
    HOUR(order_time) AS order_hour,
    COUNT(order_id) AS total_orders
FROM 
    orders
GROUP BY 
    order_hour
ORDER BY 
    order_hour;

-- 3. Find the category-wise distribution of pizzas
SELECT 
    category,
    COUNT(name) AS pizza_count
FROM 
    pizza_types
GROUP BY 
    category;

-- 4. Group the orders by date and calculate the average number of pizzas ordered per day
SELECT 
    ROUND(AVG(quantity), 0) AS avg_pizzas_per_day
FROM (
    SELECT 
        o.order_date,  
        SUM(od.quantity) AS quantity
    FROM 
        orders o
        JOIN order_details od ON o.order_id = od.order_id
    GROUP BY 
        o.order_date
) AS daily_orders;

-- 5. Determine the top 3 most ordered pizza types based on revenue
SELECT 
    pt.name AS pizza_name,
    SUM(od.quantity * p.price) AS total_revenue
FROM 
    pizza_types pt
    JOIN pizzas p ON pt.pizza_type_id = p.pizza_type_id
    JOIN order_details od ON od.pizza_id = p.pizza_id
GROUP BY 
    pt.name
ORDER BY 
    total_revenue DESC
LIMIT 3;
