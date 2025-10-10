-- E-COMMERCE SQL PROJECT
-- Tables, Relationships, and Sample Data

-- 1. CREATE TABLE FOR USERS

CREATE TABLE Users (
    userID SERIAL PRIMARY KEY,
    Name VARCHAR(50),
    emailID VARCHAR(100) UNIQUE NOT NULL,
    PhoneNO VARCHAR(50) UNIQUE NOT NULL,
    Address TEXT,
    registration_Date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ==============================================
-- 2. CREATE TABLE FOR PRODUCTS
-- ==============================================
CREATE TABLE Products (
    ProductID SERIAL PRIMARY KEY,
    Name VARCHAR(100),
    Category VARCHAR(100),
    Price NUMERIC(10,2),
    Brand VARCHAR(50),
    StockQuantity INT DEFAULT 0
);

-- ==============================================
-- 3. CREATE TABLE FOR CART
-- ==============================================
CREATE TABLE Cart (
    CartID SERIAL PRIMARY KEY,
    UserID INT REFERENCES Users(UserID),
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ==============================================
-- 4. CREATE TABLE FOR CART ITEMS
-- ==============================================
CREATE TABLE CartItem (
    CartItemID SERIAL PRIMARY KEY,
    CartID INT REFERENCES Cart(CartID) ON DELETE CASCADE,
    ProductID INT REFERENCES Products(ProductID),
    Quantity INT NOT NULL
);

-- ==============================================
-- 5. CREATE TABLE FOR ORDERS
-- ==============================================
CREATE TABLE Orders (
    OrderID SERIAL PRIMARY KEY,
    UserID INT REFERENCES Users(userID),
    TotalAmount NUMERIC(10,2) NOT NULL,
    OrderStatus VARCHAR(50) DEFAULT 'Pending',
    PaymentMethod VARCHAR(50),
    OrderDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ==============================================
-- 6. CREATE TABLE FOR ORDER ITEMS
-- ==============================================
CREATE TABLE OrderItem (
    OrderItemID SERIAL PRIMARY KEY,
    OrderID INT REFERENCES Orders(OrderID) ON DELETE CASCADE,
    ProductID INT REFERENCES Products(ProductID),
    Quantity INT NOT NULL,
    Price NUMERIC(10,2) NOT NULL
);

-- ==============================================
-- 7. CREATE TABLE FOR DELIVERY AGENTS
-- ==============================================
CREATE TABLE DeliveryAgent (
    AgentID SERIAL PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Phone VARCHAR(15) UNIQUE NOT NULL,
    CurrentLocation VARCHAR(255),
    AvailabilityStatus BOOLEAN DEFAULT TRUE
);

-- ==============================================
-- 8. CREATE TABLE FOR DELIVERY
-- ==============================================
CREATE TABLE Delivery (
    DeliveryID SERIAL PRIMARY KEY,
    OrderID INT REFERENCES Orders(OrderID) ON DELETE CASCADE,
    AgentID INT REFERENCES DeliveryAgent(AgentID),
    PickupTime TIMESTAMP,
    DeliveryTime TIMESTAMP,
    Status VARCHAR(20) DEFAULT 'Assigned'
);

-- ==============================================
-- 9. CREATE TABLE FOR REVIEWS
-- ==============================================
CREATE TABLE Review (
    ReviewID SERIAL PRIMARY KEY,
    UserID INT REFERENCES Users(UserID),
    ProductID INT REFERENCES Products(ProductID),
    Rating INT CHECK (Rating >= 1 AND Rating <= 5),
    Comment TEXT,
    ReviewDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ==============================================
-- 10. INSERT SAMPLE DATA
-- ==============================================

-- Users
INSERT INTO Users (Name, emailID, PhoneNO, Address) VALUES
('Vishesh Singh Latwal', 'vishesh414@example.com', '9876543210', '123 Main St, Lucknow'),
('Ayushi Sharma', 'ananya@example.com', '9123456780', '456 Park Rd, Delhi');

-- Products
INSERT INTO Products (Name, Category, Price, Brand, StockQuantity) VALUES
('Milk 1L', 'Dairy', 55.00, 'Amul', 100),
('Apples 1kg', 'Fruits', 60.00, 'FreshFarms', 50),
('Muffins', 'Bakery', 40.00, 'Britannia', 30),
('Eggs 12pcs', 'Dairy', 70.00, 'LocalFarm', 200);

-- Create Cart
INSERT INTO Cart (UserID) VALUES (1); -- Vishesh's Cart

-- Add items to Cart
INSERT INTO CartItem (CartID, ProductID, Quantity) VALUES
(1, 1, 2),  -- 2 units of Milk
(1, 2, 1);  -- 1 unit of Apples

-- Place an Order
INSERT INTO Orders (UserID, TotalAmount, OrderStatus, PaymentMethod)
VALUES (1, 55*2 + 60*1, 'Pending', 'UPI'); -- Total amount = 170

-- Add items to OrderItem
INSERT INTO OrderItem (OrderID, ProductID, Quantity, Price) VALUES
(1, 1, 2, 55.00),
(1, 2, 1, 60.00);

-- Clear Cart after order is placed
DELETE FROM CartItem WHERE CartID = 1;

-- Assign Delivery Agent
INSERT INTO DeliveryAgent (Name, Phone, CurrentLocation) VALUES
('Yash Gupta', '9988776655', 'Lucknow');

INSERT INTO Delivery (OrderID, AgentID, PickupTime, Status)
VALUES (1, 1, CURRENT_TIMESTAMP, 'Assigned');

-- Add Reviews
INSERT INTO Review (UserID, ProductID, Rating, Comment) VALUES
(1, 1, 5, 'Fresh and good quality milk!'),
(1, 2, 4, 'Apples were fresh and sweet.');
