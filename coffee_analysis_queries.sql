
-- Q1. Coffee Consumers Count
-- How many people in each city are estimated to consume coffee, given that 25% of the population does?
SELECT 
    c.city_name,
    (c.population * 0.25) / 1000000 AS coffee_consumer_in_million,
    c.city_rank
FROM coffee.city c 
ORDER BY 2 DESC;


-- Q2. Total Revenue from Coffee Sales
-- What is the total revenue generated from coffee sales across all cities in the last quarter of 2023?
SELECT 
    c2.city_name,
    EXTRACT(YEAR FROM s.sale_date) AS year,
    EXTRACT(QUARTER FROM s.sale_date) AS quarter,
    SUM(s.total) AS total_sales
FROM coffee.sales s 
JOIN coffee.customers c ON s.customer_id = c.customer_id
JOIN coffee.city c2 ON c.city_id = c2.city_id
WHERE EXTRACT(YEAR FROM s.sale_date) = 2023
  AND EXTRACT(QUARTER FROM s.sale_date) = 4
GROUP BY 1,2,3;


-- Q3. Sales Count for Each Product
-- How many units of each coffee product have been sold?
SELECT 
    p.product_name,
    COUNT(s.sale_id) AS total_units_sold
FROM coffee.products p 
JOIN coffee.sales s ON p.product_id = s.product_id
GROUP BY 1
ORDER BY 2 DESC;


-- Q4. Average Sales Amount per City
-- What is the average sales amount per customer in each city?
WITH average_sales_amount AS (
    SELECT 
        ci.city_name,
        COUNT(DISTINCT c.customer_id) AS unique_total_customer,
        SUM(s.total) AS total_sales
    FROM coffee.sales s 
    JOIN coffee.customers c ON s.customer_id = c.customer_id
    JOIN coffee.city ci ON ci.city_id = c.city_id
    GROUP BY 1
)
SELECT 
    city_name,
    unique_total_customer,
    total_sales,
    ROUND((total_sales::NUMERIC / unique_total_customer::NUMERIC),2) AS avg_sale_per_cx
FROM average_sales_amount
ORDER BY 4 DESC;


-- Q5. City Population and Coffee Consumers
-- Provide a list of cities along with their populations and estimated coffee consumers.
WITH city_info AS (
    SELECT 
        c.city_name,
        c.population,
        (c.population * 0.25) / 1000000 AS coffee_consumer_in_million,
        COUNT(DISTINCT c2.customer_id) AS unique_cx
    FROM coffee.city c 
    JOIN coffee.customers c2 ON c.city_id = c2.city_id
    JOIN coffee.sales s ON s.customer_id = c2.customer_id
    GROUP BY 1,2
)
SELECT * FROM city_info ORDER BY unique_cx DESC;


-- Q6. Top Selling Products by City
-- What are the top 3 selling products in each city based on sales volume?
WITH top_selling_product AS (
    SELECT 
        c.city_name,
        p.product_name,
        COUNT(s.sale_id) AS total_units_sold
    FROM coffee.city c 
    JOIN coffee.customers c2 ON c.city_id = c2.city_id
    JOIN coffee.sales s ON c2.customer_id = s.customer_id
    JOIN coffee.products p ON s.product_id = p.product_id
    GROUP BY c.city_name, p.product_name
)
SELECT city_name, product_name, total_units_sold
FROM (
    SELECT 
        city_name,
        product_name,
        total_units_sold,
        DENSE_RANK() OVER (PARTITION BY city_name ORDER BY total_units_sold DESC) AS rnk
    FROM top_selling_product
) t
WHERE rnk <= 3;


-- Q7. Customer Segmentation by City
-- How many unique customers are there in each city who have purchased coffee products?
SELECT 
    c.city_name,
    COUNT(DISTINCT c2.customer_id) AS unique_customer
FROM coffee.city c 
JOIN coffee.customers c2 ON c.city_id = c2.city_id
JOIN coffee.sales s ON s.customer_id = c2.customer_id
JOIN coffee.products p ON p.product_id = s.product_id
WHERE p.product_category = 'Coffee'
GROUP BY 1
ORDER BY unique_customer DESC;


-- Q8. Average Sale vs Rent
-- Find each city and their average sale per customer and avg rent per customer
WITH average_sales_pr_cx AS (
    SELECT 
        c.city_name,
        SUM(c.estimated_rent) AS total_rent, 
        COUNT(DISTINCT c2.customer_id) AS unique_customer,
        SUM(s.total) AS total_sales
    FROM coffee.city c 
    JOIN coffee.customers c2 ON c.city_id = c2.city_id
    JOIN coffee.sales s ON s.customer_id = c2.customer_id
    GROUP BY 1
)
SELECT 
    city_name,
    unique_customer,
    total_rent,
    total_sales,
    ROUND((total_sales::NUMERIC / unique_customer::NUMERIC),2) AS avg_sale_per_cx,
    ROUND((total_rent::NUMERIC / unique_customer::NUMERIC),2) AS avg_rent_per_cx
FROM average_sales_pr_cx;


-- Q9. Monthly Sales Growth
-- Calculate the percentage growth (or decline) in sales over different time periods (monthly) by each city
WITH sales_growth AS (
    SELECT 
        c.city_name,
        EXTRACT(YEAR FROM s.sale_date) AS year,
        EXTRACT(MONTH FROM s.sale_date) AS month,
        SUM(s.total) AS total_sales
    FROM coffee.city c 
    JOIN coffee.customers c2 ON c.city_id = c2.city_id
    JOIN coffee.sales s ON s.customer_id = c2.customer_id
    GROUP BY 1,2,3
)
SELECT 
    city_name,
    year,
    month,
    total_sales,
    total_sales - py_sales AS monthly_growth,
    ROUND(((total_sales - py_sales)/py_sales)*100,2) AS growth_percentage
FROM (
    SELECT 
        city_name,
        year,
        month,
        total_sales,
        LAG(total_sales,1) OVER(PARTITION BY city_name ORDER BY year, month) AS py_sales
    FROM sales_growth
) t
WHERE py_sales IS NOT NULL
ORDER BY city_name, year, month;


-- Q10. Market Potential Analysis
-- Identify top 3 city based on highest sales, return city name, total sale, total rent, total customers, estimated coffee consumer
WITH market_analysis AS (
    SELECT
        c.city_name,
        SUM(s.total) AS total_sales,
        COUNT(DISTINCT c2.customer_id) AS total_customer,
        SUM(c.estimated_rent) AS total_rent,
        (SUM(c.population) * 0.25) / 1000000 AS coffee_consumer_in_million
    FROM coffee.city c 
    JOIN coffee.customers c2 ON c.city_id = c2.city_id
    JOIN coffee.sales s ON c2.customer_id = s.customer_id
    GROUP BY c.city_name
)
SELECT 
    city_name,
    total_sales,
    total_customer,
    total_rent,
    coffee_consumer_in_million
FROM market_analysis
ORDER BY total_sales DESC
LIMIT 3;
