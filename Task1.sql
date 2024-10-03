--Courier Managment System

--Task 1
Create Database Courier
go 
Use Courier
go
 
CREATE TABLE Users (
UserID INT Primary Key,
NAME VARCHAR(255),
Email VARCHAR(255) UNIQUE,
Password VARCHAR(255),
ContactNumber VARCHAR(20),
Address TEXT);

CREATE TABLE Courier(
CourierID INT Primary Key,
SenderName VARCHAR(255),
SenderAddress TEXT,
ReceiverName VARCHAR(255),
ReceiverAddress TEXT,
Weight DECIMAL(5,2),
Status VARCHAR(50),
TrackingNumber VARCHAR(20) UNIQUE,
DeliveryDate Date,
SenderLocationID INT,--foreign key for sender location
ReceiverLocationID INT, ---foreign for receiver location
Foreign key (UserID) References Users(UserID) ,
Foreign key (SenderLocationID) References Location(LocationID),
Foreign key (ReceiverLocationID) References Location(LocationID)

);

Alter Table Courier
add UserID INT,
SenderLocationID INT,
ReceiverLocationID INT;

Alter Table Courier
ADD CONSTRAINT FK_Courier_Users FOREIGN KEY (UserID) REFERENCES Users(UserID),
CONSTRAINT FK_Courier_SenderLocation FOREIGN KEY (SenderLocationID) REFERENCES Location(LocationID),
CONSTRAINT FK_Courier_ReceiverLocation FOREIGN KEY (ReceiverLocationID) REFERENCES Location(LocationID);

CREATE TABLE CourierServices(
ServiceID INT Primary Key,
ServiceName VARCHAR(100),
Cost DECIMAL(8,2));

CREATE TABLE Employee(
EmployeeID INT Primary Key,
Name VARCHAR(255),
Email VARCHAR(255) UNIQUE,
ContactNumber VARCHAR(20),
Role VARCHAR(50),
Salary DECIMAL(10,2));

CREATE TABLE Location(
LocationID INT Primary Key,
LocationName VARCHAR(100),
Address TEXT);


CREATE TABLE Payment(
PaymentID INT Primary Key,
CourierID INT,
LocationID INT,
Amount DECIMAL(10,2),
PaymentDate DATE,
FOREIGN KEY(CourierID) REFERENCES Courier(CourierID),
FOREIGN KEY(LocationID) REFERENCES Location(LocationID));

---Insert the sample data

Insert into Users(UserID ,NAME ,Email,Password,ContactNumber,Address) Values

(2,'Ranul','Rahul12@gmail.com','rh1245','7896540971','Tilak Road,kopargaon'),
(3,'Tejas','Tejas@gmail.com','TG789','7654987221','CBS,Nashik'),
(4,'Atul','Atul04@gmail.com','ATUL889','9873476912','Kalika Nagar,Kopargaon'),
(5,'Ritu','RITUS@gmail.com','RPSI12','8876941230','Om Nagar,Pune');

select * from Users

Insert into Location(LocationID,LocationName,Address)  values
(1,'Balaji Nagar','Balaji Nagar'),
(2, 'Kopargaon', 'Tilak Road, Kopargaon'),
(3, 'Nashik', 'CBS, Nashik'),
(4, 'Kopargaon', 'Kalika Nagar, Kopargaon'),
(5, 'Pune', 'Om Nagar, Pune');
Insert into Location(LocationID,LocationName,Address)  values
(6,'Pune','23 D7 Sangam Society');

select * from Location

INSERT INTO Courier 
(CourierID, UserID, SenderName, SenderAddress, ReceiverName, ReceiverAddress, 
 Weight, Status, TrackingNumber, DeliveryDate, SenderLocationID, ReceiverLocationID) 
VALUES 
(1, 1, 'Tanu', 'balaji Nagar', 'Santosh', 'Hadapsar, Pune', 
 3.0, 'In Transit', '1234', '2024-10-10', 1, 2);

 Select * from Courier
 INSERT INTO Courier (CourierID, UserID, SenderName, SenderAddress, ReceiverName, ReceiverAddress, 
 Weight, Status, TrackingNumber, DeliveryDate, SenderLocationID, ReceiverLocationID) 
VALUES (2,2,'Ranul','Tilak Road, Kopargaon','Rupal Shah','SBI Colony,Delhi',2.0,'Delivered','SP456','2024-9-29',2,3),
(3,3,'Tejas','CBS,Nashik','Sumit Tiwari','Mukund Nagar, Kolhapur',5.0,'Delivered','Sp789','2024-9-30',3,4),
(4,4,'Atul','Kalika Nagar,Kopargaon','Sangam Sharma','Phase2,Sangamner',2.0,'In Transit','SP567','2024-10-10',4,5),
(5,5,'Ritu','Om Nagar,Pune','Sunita Pawar','23 D7 Sangam Society,Pune',7.0,'In Transit','SP987','2024-10-15',5,4);

INSERT INTO Courier 
(CourierID, UserID, SenderName, SenderAddress, ReceiverName, ReceiverAddress, 
 Weight, Status, TrackingNumber, DeliveryDate, SenderLocationID, ReceiverLocationID) 
VALUES 
(6, 5, 'Ritu','Om Nagar,Pune','Sunita Pawar','23 D7 Sangam Society,Pune', 
 8.0, 'Not Delivered', 'Sp99021', '2024-10-20', 5, 6);

 select * from Courier

UPDATE Courier
SET ReceiverLocationID = 6
WHERE CourierID = 5;

---insert into Courier Service
Insert into CourierServices(ServiceID ,ServiceName,Cost)Values
(1,'Standard Delivery',100),
(2,'Express Delivery',200),
(3,'Same-Day Delivery',400);

Select * from CourierServices

---insert into Employee
Insert into Employee(EmployeeID ,Name,Email,ContactNumber,Role,Salary) values
(1,'Raj Patel','rajP@gmail.com',9567890423,'Delivery Executive',22000),
(2,'Piyush Kumar','Piyushh@gmail.com',7788945672,'Delivery Executive',22000),
(3,'Aryan Patil','AryanP@gmail.com',8876955434,'Manager',30000),
(4,'Priti Sharma','pritiSharma@gmail.com',9970654890,'Manager',30000),
(5,'Vijay Naik','vijay07@gmail.com',7789654232,'Customer Support',15000);

INSERT INTO Employee (EmployeeID, Name, Email, ContactNumber, Role, Salary) VALUES
(6, 'John Doe', 'john.doe@example.com', '1234567890', 'Sales Manager', 40000.00),
(7, 'Johnathan Davis', 'johnathan.davis@example.com', '1122334455', 'Software Engineer', 55000.00);

select * from Employee

INSERT INTO Payment (PaymentID, CourierID, LocationID, Amount, PaymentDate) 
VALUES
(1, 1, 1, 150.00, '2024-10-01'),
(2, 2, 2, 100.00, '2024-09-29'),
(3, 3, 3, 200.00, '2024-09-30'),
(4, 4, 4, 150.00, '2024-10-10'),
(5, 5, 5, 250.00, '2024-10-15');

INSERT INTO Payment (PaymentID, CourierID, LocationID, Amount, PaymentDate) 
VALUES (6, 6, 5, 40.00, '2024-10-20');

SELECT * FROM Payment;
