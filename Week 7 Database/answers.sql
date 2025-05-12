SELECT 
    OrderID, 
    CustomerName, 
    TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(Products, ',', numbers.n), ',', -1)) AS Product
FROM 
    ProductDetail
JOIN 
    (SELECT 1 AS n UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4) numbers 
    ON CHAR_LENGTH(Products) - CHAR_LENGTH(REPLACE(Products, ',', '')) >= numbers.n - 1
ORDER BY 
    OrderI

CREATE TABLE Customers (
    CustomerID INT AUTO_INCREMENT PRIMARY KEY,
    CustomerName VARCHAR(255)
);

INSERT INTO Customers (CustomerName)
SELECT DISTINCT CustomerName FROM OrderDetails;


CREATE TABLE OrderDetailsNew (
    OrderID INT,
    CustomerID INT,
    Product VARCHAR(255),
    Quantity INT,
    PRIMARY KEY (OrderID, Product),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

INSERT INTO OrderDetailsNew (OrderID, CustomerID, Product, Quantity)
SELECT 
    od.OrderID, 
    c.CustomerID, 
    od.Product, 
    od.Quantity
FROM 
    OrderDetails od
JOIN 
    Customers c ON od.CustomerName = c.CustomerName;