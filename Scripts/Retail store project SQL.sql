CREATE DATABASE invet;
USE invet;

DROP TABLE IF EXISTS Product, Inventory, Supplier, Sales, PurchaseOrder, Category, ProductCategory;

CREATE TABLE Product (
    ProductID INT PRIMARY KEY AUTO_INCREMENT,
    ProductName VARCHAR(100),
    Price DECIMAL(10, 2),
    ReorderLevel INT
);

CREATE TABLE Category (
    CategoryID INT PRIMARY KEY,
    CategoryName VARCHAR(50)
);

CREATE TABLE ProductCategory (
	ProductID INT,
    CategoryID INT,
	FOREIGN KEY (ProductID) REFERENCES Product(ProductID),
    FOREIGN KEY (CategoryID) REFERENCES Category(CategoryID)
);

CREATE TABLE Inventory (
    InventoryID INT PRIMARY KEY AUTO_INCREMENT,
    ProductID INT,
    QuantityInStock INT,
    LastUpdated DATE,
    FOREIGN KEY (ProductID) REFERENCES Product(ProductID)
);


CREATE TABLE Supplier (
    SupplierID INT PRIMARY KEY AUTO_INCREMENT,
    SupplierName VARCHAR(100),
    Phone VARCHAR(15),
    Email VARCHAR(100),
    Address TEXT
);

CREATE TABLE Sales (
    SaleID INT PRIMARY KEY AUTO_INCREMENT,
    ProductID INT,
    QuantitySold INT,
    SaleDate DATE,
    FOREIGN KEY (ProductID) REFERENCES Product(ProductID)
);

CREATE TABLE PurchaseOrder (
    OrderID INT PRIMARY KEY AUTO_INCREMENT,
    SupplierID INT,
    ProductID INT,
    QuantityOrdered INT,
    OrderDate DATE,
    FOREIGN KEY (SupplierID) REFERENCES Supplier(SupplierID),
    FOREIGN KEY (ProductID) REFERENCES Product(ProductID)
);

INSERT INTO Product (ProductID, ProductName, Price, ReorderLevel)
VALUES 
(1, 'Milk', 1.50, 10),
(2, 'Bread', 0.80, 20),
(3, 'Eggs', 2.00, 12),
(4, 'Orange Juice', 2.00, 15),
(5, 'Butter', 2.50, 8),
(6, 'Cheese', 3.00, 10),
(7, 'Croissant', 1.20, 15),
(8, 'Almond Milk', 2.40, 10);

INSERT INTO Category (CategoryID, CategoryName)
VALUES 
(1, 'Dairy'),
(2, 'Bakery'),
(3, 'Beverages'),
(4, 'Gourmet'),
(5, 'Organic'),
(6, 'Snacks'),
(7, 'Gluten-Free'),
(8, 'Frozen');

INSERT INTO ProductCategory (ProductID, CategoryID)
VALUES 
(1, 1), (1, 5),           -- Milk (Dairy, Organic)
(2, 2), (2, 7),           -- Bread (Bakery, Gluten-Free)
(3, 1),                  -- Eggs (Dairy)
(4, 3), (4, 5),           -- Orange Juice (Beverages, Organic)
(5, 1), (5, 4),           -- Butter (Dairy, Gourmet)
(6, 1), (6, 4),           -- Cheese (Dairy, Gourmet)
(7, 2), (7, 4),           -- Croissant (Bakery, Gourmet)
(8, 1), (8, 3), (8, 5);   -- Almond Milk (Dairy, Beverages, Organic)

INSERT INTO Supplier (SupplierName, Phone, Email, Address)
VALUES 
('Fresh Farms Ltd.', '9876543210', 'fresh@farms.com', '123 Farm Lane'),
('Bakery World', '9123456780', 'info@bakeryworld.com', '45 Bread Street'),
('Dairy Deluxe', '9001122334', 'orders@dairydeluxe.com', '56 Cream Ave'),
('Juice Central', '9112233445', 'support@juicecentral.com', '78 Citrus Blvd');

INSERT INTO Inventory (ProductID, QuantityInStock, LastUpdated)
VALUES 
(1, 50, '2025-05-15'),  -- Milk
(2, 30, '2025-05-15'),  -- Bread
(3, 100, '2025-05-15'), -- Eggs
(4, 5, '2025-05-15'),   -- Orange Juice
(5, 6, '2025-05-15'),   -- Butter (low stock)
(6, 25, '2025-05-15'),  -- Cheese
(7, 8, '2025-05-15'),   -- Apple Juice (low stock)
(8, 12, '2025-05-15');  -- Croissant

INSERT INTO Sales (ProductID, QuantitySold, SaleDate)
VALUES 
(1, 10, '2025-05-14'),  -- Milk
(2, 5, '2025-05-14'),   -- Bread
(3, 20, '2025-05-14'),  -- Eggs
(4, 3, '2025-05-14'),   -- Orange Juice
(5, 2, '2025-05-13'),   -- Butter
(6, 6, '2025-05-13'),   -- Cheese
(7, 5, '2025-05-13'),   -- Apple Juice
(8, 8, '2025-05-14');   -- Croissant

INSERT INTO PurchaseOrder (SupplierID, ProductID, QuantityOrdered, OrderDate)
VALUES 
(1, 1, 100, '2025-05-10'), -- Milk from Fresh Farms
(2, 2, 80, '2025-05-11'),  -- Bread from Bakery World
(3, 5, 50, '2025-05-12'),  -- Butter from Dairy Deluxe
(3, 6, 60, '2025-05-12'),  -- Cheese from Dairy Deluxe
(4, 4, 100, '2025-05-11'), -- Orange Juice from Juice Central
(4, 7, 120, '2025-05-13'), -- Apple Juice from Juice Central
(2, 8, 100, '2025-05-14'); -- Croissant from Bakery World

#Top Selling Products
SELECT P.ProductName, SUM(S.QuantitySold) AS TotalSold
FROM Sales S
JOIN Product P ON S.ProductID = P.ProductID
GROUP BY P.ProductName
ORDER BY TotalSold DESC;

#Low Stock Alert
SELECT P.ProductName, I.QuantityInStock, P.ReorderLevel
FROM Inventory I
JOIN Product P ON I.ProductID = P.ProductID
WHERE I.QuantityInStock < P.ReorderLevel;

#To get current stock for each product:
SELECT P.ProductName, I.QuantityInStock, I.LastUpdated
FROM Product P
JOIN Inventory I ON P.ProductID = I.ProductID;

#Purchase Order History
SELECT PO.OrderID, P.ProductName, S.SupplierName, PO.QuantityOrdered, PO.OrderDate
FROM PurchaseOrder PO
JOIN Product P ON PO.ProductID = P.ProductID
JOIN Supplier S ON PO.SupplierID = S.SupplierID
ORDER BY PO.OrderDate DESC;

#Daily Sales Report
SELECT SaleDate, P.ProductName, QuantitySold
FROM Sales
JOIN Product P ON Sales.ProductID = P.ProductID
ORDER BY SaleDate DESC;

#To get the name of product where quantity sold equals to 10
SELECT productName AS 'Product Name', sum(QuantitySold) AS 'Qauntity Sold' FROM product p
JOIN sales s ON (p.ProductID = s.ProductID)
WHERE SaleDate = '2025-05-14'
GROUP BY productName
HAVING sum(QuantitySold) = 10;

#Get all products with their categories
SELECT p.ProductName, c.CategoryName FROM Product p
JOIN ProductCategory pc ON (p.ProductID = pc.ProductID)
JOIN Category c ON (pc.CategoryID = c.CategoryID)
ORDER BY p.ProductName;

#Get all products in a specific category Dairy
SELECT p.ProductName FROM Category c
JOIN ProductCategory pc ON (c.CategoryID = pc.CategoryID)
JOIN Product p ON (pc.ProductID = p.ProductID)
WHERE c.CategoryName = 'Dairy';

desc Product;
desc Inventory; 
desc Supplier;
desc Sales;
desc PurchaseOrder;