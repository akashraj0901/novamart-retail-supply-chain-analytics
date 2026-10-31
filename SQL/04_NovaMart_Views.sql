/* vw_monthly_performance*/
CREATE OR REPLACE VIEW vw_monthly_performance AS
SELECT DATE_FORMAT(o.Order_Date, '%Y-%m') AS Month, COUNT(DISTINCT o.Order_ID) AS Total_Orders, SUM(od.Quantity * od.Selling_Price) AS Revenue,
SUM(od.Quantity * (od.Selling_Price - od.Cost_Price)) AS Profit,
ROUND(SUM(od.Quantity * (od.Selling_Price - od.Cost_Price))/NULLIF(SUM(od.Quantity * od.Selling_Price), 0) * 100, 2) AS Profit_Margin 
FROM Orders o
INNER JOIN Order_Details od
ON o.Order_ID = od.Order_ID
GROUP BY DATE_FORMAT(o.Order_Date, '%Y-%m');

SELECT *FROM vw_monthly_performance
ORDER BY Month;


/* vw_category_performance */
CREATE OR REPLACE VIEW vw_category_performance AS
SELECT c.Category_ID, c.Category_Name, SUM(od.Quantity * od.Selling_Price) AS Total_Sales,
SUM(od.Quantity * (od.Selling_Price - od.Cost_Price)) AS Total_Profit, SUM(od.Quantity) AS Units_Sold,
ROUND(SUM(od.Quantity * (od.Selling_Price - od.Cost_Price)) / NULLIF(SUM(od.Quantity * od.Selling_Price), 0) * 100,2) AS Profit_Margin
FROM Categories c
INNER JOIN Products p
ON c.Category_ID = p.Category_ID
INNER JOIN Order_Details od
ON p.Product_ID = od.Product_ID
GROUP BY c.Category_ID, c.Category_Name;

SELECT * FROM vw_category_performance
ORDER BY Total_Sales DESC;


/* vw_product_performance */
CREATE OR REPLACE VIEW vw_product_performance AS
SELECT p.Product_ID, p.Product_Name, c.Category_ID, c.Category_Name, SUM(od.Quantity) AS Units_Sold,
SUM(od.Quantity * od.Selling_Price) AS Total_Sales, SUM(od.Quantity * (od.Selling_Price - od.Cost_Price)) AS Total_Profit,
ROUND(SUM(od.Quantity * (od.Selling_Price - od.Cost_Price)) / NULLIF(SUM(od.Quantity * od.Selling_Price), 0) * 100,2) AS Profit_Margin
FROM Products p
INNER JOIN Categories c
ON p.Category_ID = c.Category_ID
INNER JOIN Order_Details od
ON p.Product_ID = od.Product_ID
GROUP BY p.Product_ID, p.Product_Name, c.Category_ID, c.Category_Name;

SELECT * FROM vw_product_performance
ORDER BY Total_Sales DESC;


/* vw_customer_performance */
CREATE OR REPLACE VIEW vw_customer_performance AS
SELECT c.Customer_ID, c.Customer_Name, COUNT(DISTINCT o.Order_ID) AS Total_Orders, 
COALESCE(SUM(od.Quantity * od.Selling_Price), 0) AS Total_Revenue,
COALESCE(SUM(od.Quantity * (od.Selling_Price - od.Cost_Price)),0) AS Total_Profit, 
ROUND(COALESCE(SUM(od.Quantity * od.Selling_Price), 0) / NULLIF(COUNT(DISTINCT o.Order_ID), 0),2) AS AOV,
CASE
WHEN COALESCE(SUM(od.Quantity * od.Selling_Price), 0) >= 50000
THEN 'Premium'
WHEN COALESCE(SUM(od.Quantity * od.Selling_Price), 0) >= 25000
THEN 'High Value'
WHEN COALESCE(SUM(od.Quantity * od.Selling_Price), 0) >= 10000
THEN 'Regular'
ELSE 'Low Value'
END AS Customer_Segment
FROM Customers c
LEFT JOIN Orders o
ON c.Customer_ID = o.Customer_ID
LEFT JOIN Order_Details od
ON o.Order_ID = od.Order_ID
GROUP BY c.Customer_ID, c.Customer_Name;

SELECT * FROM vw_customer_performance
ORDER BY Total_Revenue DESC;


/* vw_inventory */
CREATE OR REPLACE VIEW vw_inventory AS
SELECT i.Product_ID, p.Product_Name, c.Category_ID, c.Category_Name, i.WareHouse_ID, w.WareHouse_Name, i.Stock_Quantity, 
i.Recorder_Level AS Reorder_Level, i.Stock_Quantity * p.Current_Price AS Inventory_Value,
CASE
WHEN i.Stock_Quantity = 0
THEN 'Out of Stock'
WHEN i.Stock_Quantity <= i.Recorder_Level
THEN 'Low Stock'
ELSE 'Healthy Stock'
END AS Stock_Status FROM Inventroy i
INNER JOIN Products p
ON i.Product_ID = p.Product_ID
INNER JOIN Categories c
ON p.Category_ID = c.Category_ID
INNER JOIN Warehouses w
ON i.WareHouse_ID = w.WareHouse_ID;

SELECT * FROM vw_inventory
ORDER BY Inventory_Value DESC;


/* vw_returns */
CREATE OR REPLACE VIEW vw_returns AS
SELECT r.Return_ID, r.Return_Date, o.Order_ID, o.Order_Date, c.Customer_ID, c.Customer_Name, p.Product_ID, p.Product_Name, cat.Category_ID,
cat.Category_Name, r.Return_Reason, r.Return_Amount
FROM Returns r
INNER JOIN Order_Details od
ON r.Order_Detail_ID = od.Order_Details_ID
INNER JOIN Orders o
ON od.Order_ID = o.Order_ID
INNER JOIN Customers c
ON o.Customer_ID = c.Customer_ID
INNER JOIN Products p
ON od.Product_ID = p.Product_ID
INNER JOIN Categories cat
ON p.Category_ID = cat.Category_ID;

SELECT * FROM vw_returns
ORDER BY Return_Date;

show databases;





CREATE OR REPLACE VIEW vw_dashboard_activity AS
SELECT
    o.Order_ID,
    o.Customer_ID,
    DATE_FORMAT(o.Order_Date, '%Y-%m') AS Month,

    c.Category_ID,
    c.Category_Name,

    od.Order_Details_ID,

    r.Return_ID,

    CASE
        WHEN r.Return_ID IS NOT NULL THEN 1
        ELSE 0
    END AS Is_Returned

FROM Orders o

INNER JOIN Order_Details od
    ON o.Order_ID = od.Order_ID

INNER JOIN Products p
    ON od.Product_ID = p.Product_ID

INNER JOIN Categories c
    ON p.Category_ID = c.Category_ID

LEFT JOIN Returns r
    ON od.Order_Details_ID = r.Order_Detail_ID;

SELECT *
FROM vw_dashboard_activity
LIMit 20;



CREATE OR REPLACE VIEW vw_fact_sales AS
SELECT
    o.Order_ID,
    o.Customer_ID,
    c.Customer_Name,

    o.Order_Date,
    DATE_FORMAT(o.Order_Date, '%Y-%m') AS Month,

    od.Order_Details_ID,
    od.Product_ID,
    p.Product_Name,

    p.Category_ID,
    cat.Category_Name,

    od.Quantity,
    od.Selling_Price,
    od.Cost_Price,

    od.Quantity * od.Selling_Price AS Revenue,

    od.Quantity * (od.Selling_Price - od.Cost_Price) AS Profit,

    r.Return_ID,
    r.Return_Date,
    r.Return_Reason,

    CASE
        WHEN r.Return_ID IS NOT NULL THEN 1
        ELSE 0
    END AS Is_Returned

FROM Orders o

INNER JOIN Customers c
    ON o.Customer_ID = c.Customer_ID

INNER JOIN Order_Details od
    ON o.Order_ID = od.Order_ID

INNER JOIN Products p
    ON od.Product_ID = p.Product_ID

INNER JOIN Categories cat
    ON p.Category_ID = cat.Category_ID

LEFT JOIN Returns r
    ON od.Order_Details_ID = r.Order_Detail_ID;
    
SELECT *
FROM vw_fact_sales
LIMIT 20;
SELECT
    COUNT(*) AS Total_Rows,
    COUNT(DISTINCT Order_ID) AS Total_Orders,
    COUNT(DISTINCT Customer_ID) AS Total_Customers,
    SUM(Revenue) AS Total_Revenue,
    SUM(Profit) AS Total_Profit,
    SUM(Is_Returned) AS Returned_Order_Lines
FROM vw_fact_sales;