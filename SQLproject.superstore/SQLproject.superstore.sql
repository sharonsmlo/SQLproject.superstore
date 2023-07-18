-- Find the minimum and maximum values for order_date
SELECT MIN(order_date) AS min_order_date, MAX(order_date) AS max_order_date
FROM orders;

-- Examine if there are any full years of data missing
SELECT DISTINCT YEAR(order_date) AS order_year
FROM orders
ORDER BY order_year;

-- Find out the total profit and total sales across all time periods
SELECT SUM(profit) AS total_profit, SUM(sales) AS total_sales
FROM orders;

-- Identify the top 5 customers with the highest total sales
SELECT TOP 5 customer_id, customer_name, SUM(sales) AS total_sales
FROM orders
GROUP BY customer_id, customer_name
ORDER BY total_sales DESC;

-- Determine the shipping modes and their corresponding average profits
SELECT ship_mode, AVG(profit) AS average_profit
FROM orders
GROUP BY ship_mode;

-- Find the regional supervisors with the highest number of orders
SELECT p.person, COUNT(o.order_id) AS order_count
FROM people p
JOIN orders o ON p.region = o.region
GROUP BY p.person
ORDER BY order_count DESC;

-- Retrieve the order details along with information on whether the order was returned or not
SELECT o.order_id, o.order_date, o.customer_id, r.returned
FROM orders o
LEFT JOIN returns r ON o.order_id = r.order_id;

-- Calculate the total number of returns and the return rate as a percentage
SELECT COUNT(DISTINCT r.order_id) AS total_returns,
       COUNT(DISTINCT r.order_id) * 100.0 / COUNT(DISTINCT o.order_id) AS return_rate_percentage
FROM orders o
LEFT JOIN returns r ON o.order_id = r.order_id;
