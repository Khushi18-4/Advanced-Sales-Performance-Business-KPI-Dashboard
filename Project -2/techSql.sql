CREATE DATABASE technova;
USE technova;
USE technova;

CREATE TABLE customers (
    Customer_ID VARCHAR(10) PRIMARY KEY,
    Company_Name VARCHAR(100),
    Region VARCHAR(20),
    Segment VARCHAR(20)
);
CREATE TABLE orders (
    Order_ID VARCHAR(10) PRIMARY KEY,
    Order_Date DATE,
    Customer_ID VARCHAR(10),
    Service_Name VARCHAR(100),
    Service_Category VARCHAR(50),
    Quantity INT,
    Sales_INR DECIMAL(12,2),
    Cost_INR DECIMAL(12,2),
    Profit_INR DECIMAL(12,2),
    Discount_Percent DECIMAL(5,2),
    Order_Status VARCHAR(20),
    Salesperson VARCHAR(50),
    Payment_Mode VARCHAR(30),
    Contract_Months INT,
    FOREIGN KEY (Customer_ID) REFERENCES customers(Customer_ID)
);

SELECT COUNT(*) FROM customers;
SELECT COUNT(*) FROM orders;
SELECT 
    o.Order_ID,
    o.Order_Date,
    c.Company_Name,
    c.Region,
    c.Segment,
    o.Service_Name,
    o.Service_Category,
    o.Quantity,
    o.Sales_INR,
    o.Profit_INR,
    o.Discount_Percent,
    o.Salesperson,
    o.Order_Status
FROM orders o
INNER JOIN customers c 
ON o.Customer_ID = c.Customer_ID;
SELECT 
    c.Region,
    COUNT(o.Order_ID) AS Total_Orders,
    SUM(o.Sales_INR) AS Total_Revenue,
    SUM(o.Profit_INR) AS Total_Profit,
    ROUND(SUM(o.Profit_INR)/SUM(o.Sales_INR)*100, 2) AS Profit_Margin_Percent
FROM orders o
INNER JOIN customers c 
ON o.Customer_ID = c.Customer_ID
WHERE o.Order_Status = 'Completed'
GROUP BY c.Region
ORDER BY Total_Revenue DESC;
SELECT 
    o.Service_Category,
    COUNT(o.Order_ID) AS Total_Orders,
    SUM(o.Sales_INR) AS Total_Revenue,
    SUM(o.Profit_INR) AS Total_Profit,
    ROUND(SUM(o.Profit_INR)/SUM(o.Sales_INR)*100, 2) AS Profit_Margin_Percent,
    ROUND(SUM(o.Sales_INR)/COUNT(o.Order_ID), 2) AS Avg_Deal_Size
FROM orders o
WHERE o.Order_Status = 'Completed'
GROUP BY o.Service_Category
ORDER BY Total_Revenue DESC;
SELECT 
    c.Company_Name,
    c.Region,
    c.Segment,
    COUNT(o.Order_ID) AS Total_Orders,
    SUM(o.Sales_INR) AS Total_Revenue,
    SUM(o.Profit_INR) AS Total_Profit,
    ROUND(SUM(o.Sales_INR)/COUNT(o.Order_ID), 2) AS Avg_Deal_Size
FROM orders o
INNER JOIN customers c 
ON o.Customer_ID = c.Customer_ID
WHERE o.Order_Status = 'Completed'
GROUP BY c.Company_Name, c.Region, c.Segment
ORDER BY Total_Revenue DESC
LIMIT 10;
SELECT 
    MONTH(o.Order_Date) AS Month_Number,
    MONTHNAME(o.Order_Date) AS Month_Name,
    COUNT(o.Order_ID) AS Total_Orders,
    SUM(o.Sales_INR) AS Monthly_Revenue,
    SUM(o.Profit_INR) AS Monthly_Profit,
    ROUND(SUM(o.Profit_INR)/SUM(o.Sales_INR)*100, 2) AS Profit_Margin_Percent
FROM orders o
WHERE o.Order_Status = 'Completed'
GROUP BY MONTH(o.Order_Date), MONTHNAME(o.Order_Date)
ORDER BY Month_Number;
SELECT 
    o.Discount_Percent,
    COUNT(o.Order_ID) AS Total_Orders,
    SUM(o.Sales_INR) AS Total_Revenue,
    SUM(o.Profit_INR) AS Total_Profit,
    ROUND(AVG(o.Profit_INR), 2) AS Avg_Profit_Per_Order,
    ROUND(SUM(o.Profit_INR)/SUM(o.Sales_INR)*100, 2) AS Profit_Margin_Percent
FROM orders o
WHERE o.Order_Status = 'Completed'
GROUP BY o.Discount_Percent
ORDER BY o.Discount_Percent;