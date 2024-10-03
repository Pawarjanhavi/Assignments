

---Task 2---Select,where

---1. List all customers:
Select * from Users
SELECT UserID, Name, Email, ContactNumber, Address FROM Users;

---2. List all orders for a specific customer:

Select c.CourierID,c.SenderName,c.ReceiverName,c.weight,c.Status,c.TrackingNumber,c.DeliveryDate from Courier c 
JOIN Users u ON c.CourierID = u.UserID where u.UserID in (1,5);

---3. List all couriers:
select * from Courier
select CourierID,SenderName,ReceiverName,weight,Status,TrackingNumber,DeliveryDate from Courier

----4. List all packages for a specific order:
--without package table
SELECT CourierID,SenderName,ReceiverName,Weight,Status,TrackingNumber,DeliveryDate
FROM Courier WHERE UserID = 1;  


----5. List all deliveries for a specific courier:

select CourierID,SenderName,ReceiverName,weight,Status,TrackingNumber,DeliveryDate from Courier 
where CourierID = 2;

----6. List all undelivered packages:

select CourierID,SenderName,ReceiverName,weight,Status,TrackingNumber,DeliveryDate from Courier 
where Status in ('Not delivered','In Transit');

---7. List all packages that are scheduled for delivery today:
SELECT CourierID, SenderName, ReceiverName, Weight, Status, TrackingNumber, DeliveryDate 
FROM Courier WHERE DeliveryDate = CAST(GETDATE() AS DATE);

---8. List all packages with a specific status:
SELECT CourierID, SenderName, ReceiverName, Weight, Status, TrackingNumber, DeliveryDate 
FROM Courier WHERE Status = 'In Transit';

---9. Calculate the total number of packages for each courier.
SELECT CourierID, COUNT(*) AS TotalPackages 
FROM  Courier GROUP BY CourierID;

---10. Find the average delivery time for each courier
SELECT CourierID, AVG(DATEDIFF(DAY, GETDATE(), DeliveryDate)) AS AverageDeliveryTime
FROM Courier WHERE DeliveryDate IS NOT NULL GROUP BY CourierID;

---11. List all packages with a specific weight range:
SELECT * FROM Courier
WHERE Weight BETWEEN 2.0 AND 5.0;

---12. Retrieve employees whose names contain 'John'
SELECT * FROM Employee WHERE Name LIKE '%John%';

---13. Retrieve all courier records with payments greater than $50. 
SELECT c.CourierID,c.SenderName,c.ReceiverName,c.weight,c.Status,c.TrackingNumber,c.DeliveryDate
FROM Courier c JOIN Payment p ON c.CourierID = p.CourierID
WHERE p.Amount > 50;
