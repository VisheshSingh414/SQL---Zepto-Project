
--Q1. List all products that have a stock quantity less than 50.

SELECT ProductID, Name, Category, StockQuantity
FROM Products
WHERE StockQuantity < 50;

-----------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------

--Q2. Find the total revenue generated from all orders.

SELECT SUM(TotalAmount) AS TotalRevenue
FROM Orders;

-----------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------

--Q3. Display the number of orders placed by each user.

SELECT u.Name AS CustomerName, COUNT(o.OrderID) AS TotalOrders
FROM Users u
LEFT JOIN Orders o ON u.UserID = o.UserID
GROUP BY u.Name
ORDER BY TotalOrders DESC;

-----------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------

--Q4. Show each product’s name along with the average rating it has received.

SELECT p.Name AS ProductName, 
       ROUND(AVG(r.Rating), 2) AS AverageRating
FROM Products p
LEFT JOIN Review r ON p.ProductID = r.ProductID
GROUP BY p.Name
ORDER BY AverageRating DESC;

-----------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------

--Q5. Retrieve a list of all orders with the user name and delivery agent name assigned.

SELECT o.OrderID, 
       u.Name AS CustomerName,
       a.Name AS AgentName,
       o.TotalAmount,
       o.OrderStatus
FROM Orders o
JOIN Users u ON o.UserID = u.UserID
LEFT JOIN Delivery d ON o.OrderID = d.OrderID
LEFT JOIN DeliveryAgent a ON d.AgentID = a.AgentID;