--Task 4: Inner Join,Full Outer Join, Cross Join, Left Outer Join,Right Outer Join

--23. Retrieve Payments with Courier Information
select * from payment
select * from Courier

select p.PaymentID,p.Amount,p.PaymentDate,c.CourierID,c.Sendername,c.ReceiverName from Payment p
inner join Courier c on p.CourierID = c.CourierID

--24. Retrieve Payments with Location Information
select * from Location
select p.PaymentID,p.Amount,P.paymentDate,p.LocationID from Payment p 
inner join Location l on p.LocationID = l.LocationID

--25. Retrieve Payments with Courier and Location Information
select p.paymentID,p.Amount,p.PaymentDate,c.CourierID,c.SenderName,c.ReceiverName,l.LocationID,l.LocationName
from Payment p inner join Courier c on c.CourierID = p.CourierID
inner join Location l on p.LocationID = l.LocationID

--26. List all payments with courier details

select p.paymentID,p.Amount,p.PaymentDate,c.CourierID,c.SenderName,c.ReceiverName from Payment p
left outer join Courier c on p.CourierID = c.CourierID

--27. Total payments received for each courier
select c.CourierID , Sum(Amount) as TotalPayment from Payment p 
inner join Courier c on p.CourierID = c.CourierID
Group by c.CourierID

--28. List payments made on a specific date 

select p.PaymentID,p.Amount,p.PaymentDate,c.CourierID,c.SenderName,c.ReceiverName
from Payment p inner join Courier c on p.CourierID = c.CourierID
where p.PaymentDate = '2024-10-10'

--29. Get Courier Information for Each Payment
select p.PaymentID,p.Amount,p.PaymentDate,c.CourierID,c.SenderName,c.ReceiverName
from Payment p left join Courier c on p.CourierID = c.CourierID

--30. Get Payment Details with Location
select * from Location
select p.PaymentID,p.Amount,p.PaymentDate,l.LocationID,l.LocationName from Payment p
left join Location l on p.LocationID = l.LocationID

--31. Calculating Total Payments for Each Courier
Select c.CourierID,c.SenderName,c.ReceiverName, Sum(p.Amount) as TotalPayment from Courier c
inner join Payment p on c.CourierID = p.CourierID
Group by c.CourierID,c.SenderName,c.ReceiverName
order by TotalPayment

--32. List Payments Within a Date Range
select* from Payment
select p.PaymentId,p.Amount,p.PaymentDate,c.CourierID,c.SenderName,c.ReceiverName from Payment p
inner join Courier c on p.CourierID = c.CourierID
where PaymentDate Between '2024-09-30' and '2024-10-15'


--33. Retrieve a list of all users and their corresponding courier records, including cases where there are no matches on either side
select * from Users
select * from Courier
select u.UserID,u.Name,c.CourierID,c.SenderName,c.ReceiverName from Users u
full outer join Courier c on u.UserID = c.UserID

--34. Retrieve a list of all couriers and their corresponding services, including cases where there are no matches on either side
select * from CourierServices

SELECT c.CourierID,c.SenderName,c.ReceiverName,s.ServiceName,s.Cost
FROM Courier c CROSS JOIN CourierServices s; 

--35. Retrieve a list of all employees and their corresponding payments, including cases where there are no matches on either side
SELECT e.EmployeeID,e.Name,p.PaymentID,p.Amount,p.PaymentDate
FROM Employee e CROSS JOIN Payment p;

--36. List all users and all courier services, showing all possible combinations.
select * from Users
select u.UserID,u.Name,s.ServiceID,s.ServiceName,s.Cost
from Users u cross join CourierServices s

--37. List all employees and all locations, showing all possible combinations:
select * from Employee
Select e.EmployeeID,e.Name,l.LocationID,l.LocationName from Employee e
cross join Location l

--38. Retrieve a list of couriers and their corresponding sender information (if available)
select CourierID,SenderName,SenderAddress from Courier 

--39. Retrieve a list of couriers and their corresponding receiver information (if available):
select CourierID,ReceiverName,ReceiverAddress from Courier 

--40. Retrieve a list of couriers along with the courier service details (if available):

SELECT c.CourierID,c.SenderAddress,c.ReceiverName,cs.ServiceID,cs.ServiceName,cs.Cost
FROM Courier c LEFT JOIN CourierServices cs ON 
(CASE WHEN c.Status = 'In Transit' THEN 'Standard Delivery'
      WHEN c.Status = 'Delivered' THEN 'Express Delivery'
      ELSE 'Same-Day Delivery'
      END = cs.ServiceName);


--41. Retrieve a list of employees and the number of couriers assigned to each employee:


--42. Retrieve a list of locations and the total payment amount received at each location:
select * from Location
select l.LocationID,l.LocationName, Sum(p.Amount) as TotalPayment from Payment p
join Location l on p.LocationID = l.LocationID
group by l.LocationID,l.LocationName

--43. Retrieve all couriers sent by the same sender (based on SenderName).
SELECT 
    c1.CourierID AS CourierID,
    c1.SenderName AS SenderName,
    c1.ReceiverName AS ReceiverName,
    c1.Status AS CourierStatus,
    c1.SenderAddress AS SenderAddress,
    c1.ReceiverAddress AS ReceiverAddress
FROM Courier c1
JOIN Courier c2 ON c1.SenderName = c2.SenderName
WHERE c1.CourierID <> c2.CourierID;  

--44. List all employees who share the same role.
SELECT e1.EmployeeID,e1.Name,e1.Role
FROM Employee e1
JOIN Employee e2 ON e1.Role = e2.Role
WHERE e1.EmployeeID <> e2.EmployeeID

--45. Retrieve all payments made for couriers sent from the same location.
SELECT 
    p.PaymentID, 
    p.Amount, 
    p.PaymentDate, 
    c.CourierID, 
    c.SenderName, 
    c.SenderAddress
FROM 
    Payment p
INNER JOIN 
    Courier c ON p.CourierID = c.CourierID
WHERE 
    CAST(c.SenderAddress AS NVARCHAR(MAX)) IN (
        SELECT 
            CAST(SenderAddress AS NVARCHAR(MAX))
        FROM 
            Courier
        GROUP BY 
            CAST(SenderAddress AS NVARCHAR(MAX))
        HAVING 
            COUNT(*) > 1
    );




--47. List employees and the number of couriers they have delivered:
select * from Employee
select * from Courier
SELECT 
    e.EmployeeID,
    e.Name,
    COUNT(c.CourierID) AS NumberOfDeliveredCouriers
FROM 
    Employee e
LEFT JOIN 
    Courier c ON e.EmployeeID = c.EmployeeID 
WHERE 
    c.Status = 'Delivered'
GROUP BY 
    e.EmployeeID, e.Name
ORDER BY 
    e.EmployeeID;


--48. Find couriers that were paid an amount greater than the cost of their respective courier services
select * from Courier
SELECT 
    c.CourierID,
    c.SenderName,
    c.ReceiverName,
    p.Amount AS PaidAmount,
    cs.ServiceName,
    cs.Cost AS ServiceCost
FROM 
    Courier c
JOIN 
    Payment p ON p.CourierID = c.CourierID 
JOIN 
    CourierServices cs ON 
        ((c.Status = 'In Transit' AND cs.ServiceName = 'Standard Delivery') OR
         (c.Status = 'Delivered' AND cs.ServiceName = 'Express Delivery') OR
         (c.Status != 'In Transit' AND c.Status != 'Delivered' AND cs.ServiceName = 'Same-Day Delivery'))
WHERE 
    p.Amount > cs.Cost; 

--49. Find couriers that have a weight greater than the average weight of all couriers
SELECT c.CourierID,c.SenderName,c.ReceiverName,c.Weight
FROM Courier c
WHERE c.Weight > (SELECT AVG(Weight) FROM Courier);

--50. Find the names of all employees who have a salary greater than the average salary:
SELECT e.Name
FROM Employee e
WHERE e.Salary > (SELECT AVG(Salary) FROM Employee);

--51. Find the total cost of all courier services where the cost is less than the maximum cost
SELECT SUM(Cost) AS TotalCost
FROM CourierServices
WHERE Cost < (SELECT MAX(Cost) FROM CourierServices);

--52. Find all couriers that have been paid for
SELECT c.* FROM Courier c
INNER JOIN Payment p ON c.CourierID = p.CourierID;

--53. Find the locations where the maximum payment amount was made
SELECT l.LocationID, l.LocationName 
FROM Payment p
JOIN Location l ON p.LocationID = l.LocationID
WHERE p.Amount = (SELECT MAX(Amount) FROM Payment);


--54. Find all couriers whose weight is greater than the weight of all couriers sent by a specific sender (e.g., 'SenderName'): 
SELECT c.*
FROM Courier c
WHERE c.Weight > (
    SELECT MAX(c2.Weight)
    FROM Courier c2
    WHERE c2.SenderName = 'SenderName'
);
