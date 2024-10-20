-- Sales data w.r.t each Branch/City
SELECT 
    c.Branch,
    c.City,
    AVG(s.Quantity) AS avg_quantity,
    AVG(s.`Tax 5%`) AS avg_tax,
    SUM(s.Total) AS sum_total,
    AVG(s.cogs) AS avg_cogs,
    AVG(s.`gross margin percentage`) AS avg_gross_margin,
    AVG(s.`gross income`) AS avg_gross_income,
    AVG(s.Rating) AS avg_rating
FROM 
    `66d_demo.sales` s
JOIN 
    `66d_demo.customers` c ON s.`Branch` = c.`Branch`
GROUP BY 
    c.Branch,
    c.City;

------------------------------------------------------------------------------------------------------------------------------
-- Monthly Sales
SELECT 
    FORMAT_TIMESTAMP('%Y-%m', `Order Timestamp`) AS month,
    ROUND(SUM(Total), 2) AS total_sales
FROM 
    `66d_demo.sales`
GROUP BY 
    month
ORDER BY 
    month;

------------------------------------------------------------------------------------------------------------------------------
-- Sales by Gender
SELECT 
    c.Gender, 
    ROUND(SUM(s.Total), 2) AS total_sales
FROM 
    `66d_demo.sales` s
JOIN 
    `66d_demo.customers` c ON s.Branch = c.Branch  -- Assuming 'Branch' relates to gender
GROUP BY 
    c.Gender
ORDER BY 
    total_sales DESC;

------------------------------------------------------------------------------------------------------------------------------
-- Top Selling Products
SELECT 
    p.`Product line`,
    SUM(s.Quantity) AS total_quantity_sold,
    SUM(s.Total) AS total_sales
FROM 
    `66d_demo.sales` s
JOIN 
    `66d_demo.products` p ON s.`Product line` = p.`Product line`
GROUP BY 
    p.`Product line`
ORDER BY 
    total_sales DESC
LIMIT 10;

------------------------------------------------------------------------------------------------------------------------------
-- Average Rating by Product
SELECT 
    p.`Product line`,
    ROUND(AVG(s.Rating), 2) AS average_rating
FROM 
    `66d_demo.sales` s
JOIN 
    `66d_demo.products` p ON s.`Product line` = p.`Product line`
GROUP BY 
    p.`Product line`
ORDER BY 
    average_rating DESC;

------------------------------------------------------------------------------------------------------------------------------
-- Total and Average sales by Customer type

SELECT 
    c.`Customer type`, 
    ROUND(SUM(s.Total), 2) AS total_sales,
    ROUND(AVG(s.Total), 2) AS avg_sales
FROM 
    `66d_demo.sales` s
JOIN 
    `66d_demo.customers` c ON s.Branch = c.Branch  -- Assuming 'Branch' relates to customer type
GROUP BY 
    c.`Customer type`
ORDER BY 
    total_sales DESC;

------------------------------------------------------------------------------------------------------------------------------
-- Total payment count per Branch per payment type

SELECT 
    s.Branch, 
    s.Payment AS payment_method, 
    COUNT(*) AS payment_count
FROM 
    `66d_demo.sales` s
GROUP BY 
    s.Branch, 
    s.Payment
ORDER BY 
    s.Branch, 
    payment_count DESC;

------------------------------------------------------------------------------------------------------------------------------
-- Total revenue generated per day

SELECT 
    DATE(`Order Timestamp`) AS sales_date, 
    ROUND(SUM(Total), 2) AS total_revenue
FROM 
    `66d_demo.sales`
GROUP BY 
    sales_date
ORDER BY 
    sales_date;

------------------------------------------------------------------------------------------------------------------------------
-- Total customer per gender per Branch/City

SELECT 
    s.Branch,
    c.City ,
    c.Gender, 
    COUNT(*) AS customer_count
FROM 
    `66d_demo.sales` s
JOIN 
    `66d_demo.customers` c ON s.Branch = c.Branch  -- Assuming 'Branch' relates to customers
GROUP BY 
    s.Branch, 
    c.City,
    c.Gender
ORDER BY 
    s.Branch,
    c.City ,
    c.Gender;