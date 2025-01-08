USE restaurant_db;

-- TASK 1: EXPLORE THE MENU ITEMS TABLE

-- 1. Return the menu_items table
SELECT * FROM menu_items;

-- 2. Number of items on the menu
 SELECT COUNT(*) FROM menu_items; 

-- 3. The least expensive items on the menu?
SELECT * FROM menu_items 
ORDER BY price;

-- 4. The most expensive items on the menu?
SELECT * FROM menu_items
ORDER BY price DESC;

-- 5. Number of italian dishes are on the menu?
SELECT * FROM menu_items
WHERE category = 'Italian';

-- 6. The least expensive Italian dishes on the menu
SELECT * FROM menu_items
WHERE category = 'Italian'
ORDER BY price;

-- 7. The most expansive Italian dishes on the menu
SELECT * FROM menu_items
WHERE category = 'Italian'
ORDER BY price DESC;

-- 8. Number of dishes by their category
SELECT category, COUNT(category) AS num_dishes
FROM menu_items
GROUP BY category;

-- 9. Average dish price per category
SELECT category, ROUND(AVG(price),2) AS avg_price
FROM menu_items
GROUP BY category;

-- TASK 2: EXPLORE THE ORDER DETAILS TABLE

-- 1. Return the Order Details Table
SELECT * FROM order_details;

-- 2. The date range of the order details table
 SELECT MIN(order_date), MAX(order_date) 
 FROM order_details;
 
-- 3. Orders made within the data range
SELECT COUNT(DISTINCT order_id) AS distinct_orders
FROM order_details;

-- 4. Number of items ordered within the date range
SELECT COUNT(*) AS total_orders FROM order_details;

-- 5. Orders by their number of items
SELECT order_id, COUNT(order_id) AS total_orders
FROM order_details
GROUP BY order_id
ORDER BY total_orders DESC;

-- 6. Number of orders with more than 12 items
SELECT COUNT(*) FROM (SELECT order_id, COUNT(order_id) AS total_orders
FROM order_details
GROUP BY order_id
HAVING total_orders > 12) AS number;

-- TASK 3: ANALYZE CUSTOMER BEHAVIOR

-- 1. Combine the Menu Items and Order Details Table into a single table
SELECT * FROM order_details AS o
LEFT JOIN menu_items AS m 
ON o.item_id = m.menu_item_id;

-- 2. The least ordered items and their category
WITH sales_tbl AS 
(SELECT * FROM order_details AS o
LEFT JOIN menu_items AS m 
ON o.item_id = m.menu_item_id
)

SELECT item_name, category, COUNT(order_id) AS count
FROM sales_tbl
GROUP BY item_name, category
ORDER BY count;

-- 3. Most ordered items and their category
WITH sales_tbl AS 
(SELECT * FROM order_details AS o
LEFT JOIN menu_items AS m 
ON o.item_id = m.menu_item_id
)

SELECT item_name, category, COUNT(order_details_id) AS count
FROM sales_tbl
GROUP BY item_name, category
ORDER BY count DESC;

-- 4. The Top 5 orders that spent the most money
WITH sales_tbl AS 
(SELECT * FROM order_details AS o
LEFT JOIN menu_items AS m 
ON o.item_id = m.menu_item_id
)

SELECT order_id, SUM(price) As sum_amount FROM sales_tbl
GROUP BY order_id
ORDER BY sum_amount DESC LIMIT 5;

-- 5. Details of the order with the highest spend
WITH sales_tbl AS 
(SELECT * FROM order_details AS o
LEFT JOIN menu_items AS m 
ON o.item_id = m.menu_item_id
)

SELECT category, COUNT(category) AS count FROM sales_tbl
WHERE order_id = 440
GROUP BY category
ORDER BY count DESC;

-- 6. Details of the top 5 highest spend orders
WITH sales_tbl AS 
(SELECT * FROM order_details AS o
LEFT JOIN menu_items AS m 
ON o.item_id = m.menu_item_id
)

SELECT category, COUNT(category) AS count 
FROM sales_tbl
WHERE order_id IN (440, 2075, 1957, 330, 2675)
GROUP BY  category
ORDER BY count DESC;
