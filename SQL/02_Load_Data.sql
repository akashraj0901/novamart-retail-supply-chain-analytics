INSERT INTO Categories (Category_ID, Category_Name)
VALUES
(1, 'Electronics'),
(2, 'Home Appliances'),
(3, 'Furniture'),
(4, 'Fashion'),
(5, 'Footwear'),
(6, 'Groceries'),
(7, 'Beauty & Personal Care'),
(8, 'Sports & Fitness'),
(9, 'Books & Stationery'),
(10, 'Toys & Games'),
(11, 'Automotive'),
(12, 'Health Care'),
(13, 'Kitchen Essentials'),
(14, 'Pet Supplies'),
(15, 'Office Supplies');

Select * from Categories;



Select * from products;

-- Transaction
truncate inventroy;
select * from inventroy;
SELECT Warehouse_ID,
       COUNT(*) AS Products
FROM Inventroy
GROUP BY Warehouse_ID;

select count(*) from customers;

-- Order
SELECT COUNT(*) AS Total_Orders FROM Orders;
SELECT Payment_Method,COUNT(*) AS Orders FROM Orders
GROUP BY Payment_Method;
SELECT Order_Status,COUNT(*) AS Orders FROM Orders 
GROUP BY Order_Status;

-- orders_Details
SELECT * 
FROM Order_Details od
LEFT JOIN Orders o
ON od.Order_ID = o.Order_ID
WHERE o.Order_ID IS NULL;
SELECT *
FROM Order_Details od
LEFT JOIN Products p
ON od.Product_ID = p.Product_ID
WHERE p.Product_ID IS NULL;
SELECT *
FROM Order_Details
WHERE Quantity < 1
   OR Quantity > 5;
SELECT COUNT(*) AS Total_Order_Details
FROM Order_Details;
SELECT AVG(Product_Count) AS Avg_Products_Per_Order
FROM (
    SELECT Order_ID,
           COUNT(*) AS Product_Count
    FROM Order_Details
    GROUP BY Order_ID
) t;

select count(*) from shipment;

SELECT COUNT(*)
FROM Returns;
SELECT Return_Reason,
COUNT(*)
FROM Returns
GROUP BY Return_Reason;




-- final Check 
SELECT *
FROM Returns r
LEFT JOIN Order_Details od
ON r.Order_Detail_ID = od.Order_Details_ID
WHERE od.Order_Details_ID IS NULL;

SELECT
MIN(Return_Amount),
MAX(Return_Amount)
FROM Returns;

SELECT
Return_Reason,
COUNT(*)
FROM Returns
GROUP BY Return_Reason;

select*from order_details;