
-----Task 3: GroupBy, Aggregate Functions, Having, Order By, where

----14. Find the total number of couriers handled by each employee.
ALTER TABLE Courier
ADD EmployeeID INT;


ALTER TABLE Courier
ADD FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID);

UPDATE Courier SET EmployeeID = 1 WHERE CourierID = 1 AND EmployeeID IS NULL;
UPDATE Courier SET EmployeeID = 2 WHERE CourierID = 2 AND EmployeeID IS NULL;
UPDATE Courier SET EmployeeID = 3 WHERE CourierID = 3 AND EmployeeID IS NULL;
UPDATE Courier SET EmployeeID = 4 WHERE CourierID = 4 AND EmployeeID IS NULL;
UPDATE Courier SET EmployeeID = 5 WHERE CourierID = 5 AND EmployeeID IS NULL;
UPDATE Courier SET EmployeeID = 6 WHERE CourierID = 6 AND EmployeeID IS NULL;

select * from courier

SELECT e.EmployeeID, e.Name, COUNT(c.CourierID) AS TotalCouriers
FROM Employee e
JOIN Courier c ON e.EmployeeID = c.EmployeeID
GROUP BY e.EmployeeID, e.Name
ORDER BY TotalCouriers DESC;


----15. Calculate the total revenue generated by each location
select * from payment
select * from Location

SELECT c.SenderLocationID,SUM(p.Amount) AS TotalRevenue            
FROM Courier c
JOIN Payment p ON c.CourierID = p.CourierID  
GROUP BY c.SenderLocationID                         
                       

----16. Find the total number of couriers delivered to each location.
select c.SenderLocationID, Count(c.CourierID) As TotalDeliverd
from Courier c where c.Status = 'Delivered'
Group by c.SenderLocationID

----17. Find the courier with the highest average delivery time:
select * from Courier

alter table Courier
add OrderDate date;
UPDATE Courier SET OrderDate = '2024-10-7'  WHERE CourierID = 1;
UPDATE Courier SET OrderDate = '2024-09-20'  WHERE CourierID = 2;
UPDATE Courier SET OrderDate = '2024-09-25'  WHERE CourierID = 3;
UPDATE Courier SET OrderDate = '2024-10-1'  WHERE CourierID = 4;
UPDATE Courier SET OrderDate = '2024-10-5'  WHERE CourierID = 5;
UPDATE Courier SET OrderDate = '2024-10-15'  WHERE CourierID = 6;

SELECT c.CourierID, AVG(DATEDIFF(Day,c.OrderDate,c.DeliveryDate)) AS AverageDeliveryTime
FROM Courier c
GROUP BY c.CourierID;

----18. Find Locations with Total Payments Less Than a Certain Amount
select * from Payment
select LocationID,Sum(Amount) as totalPayment
from Payment group by LocationID 
having SUM(Amount)>150

----19. Calculate Total Payments per Location
select LocationID , SUm(Amount) as TotalPayment
from Payment group by LocationID

---20. Retrieve couriers who have received payments totaling more than $150 in a specific location (LocationID = X):
select * from Courier
select * from Payment
select p.CourierID, SUM(Amount) as TotalPayment from Payment p
where LocationID = 5 and CourierID in 
(select CourierID from Payment where LocationID = 5 group by CourierID having Sum(Amount)>150)
group by p.CourierID

---21. Retrieve couriers who have received payments totaling more than $100 after a certain date (PaymentDate > 'YYYY-MM-DD'):
select p.CourierID , Sum(p.Amount) as TotalPayment from Payment p
where p.PaymentDate > '2024-09-29'
group by p.CourierID having Sum(Amount)>100

---22. Retrieve locations where the total amount received is more than $100 before a certain date (PaymentDate > 'YYYY-MM-DD'
select * from payment
select p.LocationID, Sum(p.Amount) as TotalPayment from Payment p
where p.PaymentDate < '2024-10-10'
group by p.LocationID having Sum(p.Amount)>100


