/*SQL Script for JYA Car Hire
Authors: 
	Joshua Cassidy
	Yotsaphon Sutweha
    Andrew Roux
*/
/* !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!IMPORTNAT NOTICE!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!*/

/*PLEASE MAKE SURE THAT THE CSV FILES THAT ARE USED FOR LOADING DATA ARE LISTED UNDER THE APPROPRIATE URLS*/

DROP DATABASE if exists JYA;
CREATE DATABASE JYA;
USE JYA;

DROP TABLE IF EXISTS Car_model;
CREATE TABLE Car_Model(                           -- This is a look-up table
	model_id INTEGER NOT NULL AUTO_INCREMENT,
    model_name VARCHAR(50),
    fuel_type VARCHAR(25),
    num_seats INTEGER, 
    PRIMARY KEY (model_id)

);
ALTER TABLE Car_Model
ADD CONSTRAINT var CHECK (num_seats in ('5','7'));

DROP TABLE IF EXISTS Rental_class;
CREATE TABLE Rental_Class(
	class_id INTEGER NOT NULL AUTO_INCREMENT,
	class_name VARCHAR	(25), /*Can be A, B, C or D*/
    class_price DOUBLE (5,2),  
	class_deposit DOUBLE(6,2),
    PRIMARY KEY (class_id)    
);
DROP TABLE IF EXISTS Branch;
CREATE TABLE Branch (
    branch_id INTEGER NOT NULL AUTO_INCREMENT,
    branch_name VARCHAR(25),
    branch_address1 VARCHAR(50),
    branch_address2 VARCHAR(50),
    branch_city VARCHAR(50),
    branch_tel VARCHAR(50),
    branch_email VARCHAR(50),
    PRIMARY KEY (branch_id)

);
DROP TABLE IF EXISTS Car; 
CREATE TABLE Car(
	car_id INTEGER NOT NULL AUTO_INCREMENT,
	reg_num VARCHAR	(25),
    year_prod YEAR(4), 
    PRIMARY KEY (car_id),
    class_id INTEGER,
    model_id INTEGER,
    branch_id INTEGER,
    FOREIGN KEY (class_id) REFERENCES Rental_Class(class_id),
    FOREIGN KEY (model_id) REFERENCES Car_Model(model_id),
    FOREIGN KEY (branch_id) REFERENCES Branch(branch_id)

);
DROP TABLE IF EXISTS supplier;
CREATE TABLE Supplier(
	sup_id INTEGER NOT NULL AUTO_INCREMENT,
	sup_name VARCHAR(50),
    sup_address1 VARCHAR(50),
    sup_address2 VARCHAR(50), 
	sup_city VARCHAR (50),
    sup_zipcode VARCHAR(50),
    sup_contact_tel VARCHAR(50),
    sup_contact_email VARCHAR(50),
	sup_credit_term VARCHAR (25),
    sup_contact_person VARCHAR(25),
    PRIMARY KEY (sup_id)
);
DROP TABLE IF EXISTS CarPurch;
CREATE TABLE CarPurch(
	purch_id INTEGER NOT NULL AUTO_INCREMENT,
	purch_date DATE,
    purch_price Double(8,2),
    PRIMARY KEY (purch_id),
    sup_id INTEGER,
    car_id INTEGER,
    FOREIGN KEY (sup_id) REFERENCES Supplier(sup_id),
    FOREIGN KEY (car_id) REFERENCES Car (car_id)
);
DROP TABLE IF EXISTS Garage;
CREATE TABLE Garage (
    gar_id INTEGER NOT NULL AUTO_INCREMENT,
    gar_name VARCHAR(25),
    gar_address1 VARCHAR(25),
    gar_address2 VARCHAR(25),
    gar_city VARCHAR(25),
    gar_zipcode VARCHAR(25),
    gar_contact_tel VARCHAR(10),
    gar_contact_email VARCHAR(50),
    gar_credit_term VARCHAR(25),
    gar_contact_person VARCHAR(25),
    PRIMARY KEY (gar_id)
);

DROP TABLE IF EXISTS CarService;
CREATE TABLE CarService(
	carserv_id INTEGER NOT NULL AUTO_INCREMENT,
    serv_type VARCHAR(50),
    serv_date DATE,
    serv_cost DOUBLE (6,2),
    PRIMARY KEY (carserv_id),
    gar_id INTEGER,
    car_id INTEGER,
    FOREIGN KEY (car_id) REFERENCES Car(car_id),
    FOREIGN KEY	(gar_id) REFERENCES Garage(gar_id)
);

DROP TABLE IF EXISTS Customer;
CREATE TABLE Customer (
    cust_id INTEGER NOT NULL AUTO_INCREMENT,
    f_name VARCHAR(25),
    l_name VARCHAR(25),
    sex VARCHAR (1),
    cust_DOB DATE,
    pass_num VARCHAR(50),
    cust_address1 VARCHAR(50),
    cust_address2 VARCHAR(50),
    cust_city VARCHAR(25),
    zip_code VARCHAR(25),
    cust_contact_tel VARCHAR(25),
    cust_contact_email VARCHAR(50),
    licence_number VARCHAR(50),
    PRIMARY KEY (cust_id)
);


DROP TABLE IF EXISTS Staff; 
CREATE TABLE Staff (
    staff_id INTEGER NOT NULL AUTO_INCREMENT,
    f_name VARCHAR(25),
    l_name VARCHAR(25),
    sex VARCHAR (1),
    staff_DOB DATE,
    staff_ppsn VARCHAR(25),
    staff_position VARCHAR(50),
    staff_address1 VARCHAR(50),
    staff_address2 VARCHAR(50),
    staff_city VARCHAR(50),
    staff_cont_tel VARCHAR(50),
    staff_cont_email VARCHAR(50),
    staff_salary DOUBLE(8,2),
    PRIMARY KEY (staff_id),
    branch_id INTEGER, 
    FOREIGN KEY (branch_id) REFERENCES Branch(branch_id)

);
DROP TABLE IF EXISTS Rentalcontract;
CREATE TABLE RentalContract(
	rent_id INTEGER NOT NULL AUTO_INCREMENT,
    start_date DATE,
    end_date DATE,
    PRIMARY KEY (rent_id),
    cust_id INTEGER,
    car_id INTEGER,
    staff_id INTEGER,
    FOREIGN KEY (car_id) REFERENCES Car(car_id),
    FOREIGN KEY	(cust_id) REFERENCES Customer(cust_id),
    FOREIGN KEY	(staff_id) REFERENCES Staff(staff_id)
);
DROP TABLE IF EXISTS Payment;
CREATE TABLE Payment(
	pay_id INTEGER NOT NULL AUTO_INCREMENT,
    pay_date DATE,
    rent_id INTEGER,
    PRIMARY KEY (pay_id),
    FOREIGN KEY	(rent_id) REFERENCES RentalContract(rent_id)
);
-- Loading Customers
/*PLEASE MAKE SURE THAT THE CSV FILES THAT ARE USED FOR LOADING DATA ARE LISTED UNDER THE APPROPRIATE URLS*/
LOAD DATA LOCAL INFILE 'C:/Users/TEMP/Downloads/Databases-ERD-Project/Data3/Customer.csv'
    INTO TABLE Customer
    COLUMNS TERMINATED BY ','
	OPTIONALLY ENCLOSED BY '"'
	ESCAPED BY '"'
	LINES TERMINATED BY '\n';


-- Setting up the set for Car Models (more or less constant)
DELETE from Car_Model;
INSERT INTO Car_Model  	(model_name,fuel_type, num_seats)
VALUES 					('Mercedes C180', 'petrol', '5'),  -- 1
				        ('Mercedes C220', 'petrol', '5'),  
                        ('BMW 520', 'petrol', '5'),
                        ('BMW 318', 'petrol', '5'),
                        ('BMW M3', 'petrol', '5'),
                        ('VW Polo', 'petrol', '5'),
                        ('VW Golf', 'petrol', '5'),
                        ('Audi A3', 'petrol', '5'),
                        ('Opel Corsa', 'petrol', '5'),
                        ('Opel Zafira', 'petrol', '5');          -- 10
                        
                        
 UPDATE car_model
 SET num_seats = '7'
 WHERE model_name LIKE '%Zafira%';
 UPDATE car_model
 SET fuel_type = 'Diesel'
 WHERE model_name LIKE '%BMMW_318%' OR model_name LIKE '%Audi%' OR model_name LIKE '%Golf%';
 
 
 DELETE FROM Rental_Class;
 INSERT INTO Rental_Class  	(class_name, class_price, class_deposit)
 VALUES  							('A', 70.00, 600.00),
									('B', 55.00, 500.00),
									('C', 50.00, 400.00),
									('D', 40.00, 300.00);

DELETE FROM Branch;
INSERT INTO Branch (branch_name, branch_address1, branch_address2, branch_city, branch_tel, branch_email)
VALUES 
('Dublin', '169 Park Heights', 'James Street', 'Dublin 8', '08367324156', 'jyadublin@jya.com'),
('Cork', '47H River Bank ', 'Cork Tech Park', 'Cork', '0831268473', 'jyacork@jya.com'), 
('Kerry', '12B Mutual Place', 'Dustfield Estate', 'Kerry', '0832789123', 'jyakerry@gmail.com');

/*PLEASE MAKE SURE THAT THE CSV FILES THAT ARE USED FOR LOADING DATA ARE LISTED UNDER THE APPROPRIATE URLS*/
-- Loading Staff
LOAD DATA LOCAL INFILE 'C:/Users/TEMP/Downloads/Databases-ERD-Project/Data3/Staff.csv'
    INTO TABLE Staff
    COLUMNS TERMINATED BY ','
	OPTIONALLY ENCLOSED BY '"'
	ESCAPED BY '"'
	LINES TERMINATED BY '\n';
    
    
-- Assigning staff city to branches
UPDATE staff
SET staff_city = 'Dublin'
WHERE branch_id = 1;     

UPDATE staff
SET staff_city = 'Cork'
WHERE branch_id = 2;

UPDATE staff
SET staff_city = 'Kerry'
WHERE branch_id = 3;

UPDATE staff
SET staff_position = 'Assistant'
WHERE staff_position LIKE '%Assisstant%';

UPDATE staff
SET staff_salary = 22499
WHERE staff_position LIKE '%Assistant%'; 

/*PLEASE MAKE SURE THAT THE CSV FILES THAT ARE USED FOR LOADING DATA ARE LISTED UNDER THE APPROPRIATE URLS*/    
-- Loading Cars
LOAD DATA LOCAL INFILE 'C:/Users/TEMP/Downloads/Databases-ERD-Project/Data3/Cars.csv'
    INTO TABLE Car
    COLUMNS TERMINATED BY ','
	OPTIONALLY ENCLOSED BY '"'
	ESCAPED BY '"'
	LINES TERMINATED BY '\n';

-- Assigning Rental Classes
UPDATE Car 
SET 	class_id = 1
WHERE 	model_id IN ('1','2','10');

UPDATE Car 
SET 	class_id = 2
WHERE 	model_id IN ('3','4','5');

UPDATE Car
SET   class_id = 3
WHERE model_id IN ('6','7');

UPDATE car
SET class_id = 4
WHERE model_id IN ('8', '9');

-- Entering Suppliers
DELETE FROM Supplier;
INSERT INTO Supplier(sup_name,sup_address1,sup_address2,sup_city,sup_zipcode,sup_contact_tel,sup_contact_email,sup_credit_term,sup_contact_person)
VALUES  
		('CD Motors','9A Richmond Ave','Fionnradharc','Dublin','D3','018360636','cdmotors@gmail.com','30','John Peters'),
		('Claremont Toyota','114 Charles Town','Claremont','Dublin','D11','8667056708','claremonttoyota@gmail.com','30','James Henry'),
        ('Cassidys Motors','Knockmitten Ln','Western Industrial Estate','Dublin','D12','014501533','cassidys@gmail.com','30','Mark Cassidys'),
		('Lions Motors','Knockmitten Ln','Eastern West town','Dublin','D13','014556778','lions@gmail.com','30','Mark Wynes');
-- Entering Garages
DELETE FROM Garage;
INSERT INTO Garage(gar_name,gar_address1,gar_address2,gar_city,gar_zipcode,gar_contact_tel,gar_contact_email,gar_credit_term,gar_contact_person)
VALUES
		('FixIT','5B Richmond Ave','Fionn','Dublin','D3','0183345','fixit@gmail.com','31','John Peters'),
		('Claremont Repairs','134 Charles Town','Claremont','Dublin','D11','8667056708','claremont@gmail.com','31','James Gits'),
        ('Cassidys Fix','Knock Jn','Western Side','Dublin','D12','014501533','cassidysfix@gmail.com','31','Mark James'),
		('Lions Repairs','Knockmir JU','Eastern West town','Dublin','D13','014556778','lionsrepaire@gmail.com','31','Mark Hons'),
		('Advance Pitstop','Townsend Street','Dublin City','Dublin','D2','014536378','advance@advancepitstop.com','31','Mark Dunnes');

/*PLEASE MAKE SURE THAT THE CSV FILES THAT ARE USED FOR LOADING DATA ARE LISTED UNDER THE APPROPRIATE URLS*/
-- Loading Rentals
LOAD DATA LOCAL INFILE 'C:/Users/TEMP/Downloads/Databases-ERD-Project/Data3/Rental.csv'      -- NB Only 10000 Customers 
    INTO TABLE rentalcontract
    COLUMNS TERMINATED BY ','
	OPTIONALLY ENCLOSED BY '"'
	ESCAPED BY '"'
	LINES TERMINATED BY '\n';

/*PLEASE MAKE SURE THAT THE CSV FILES THAT ARE USED FOR LOADING DATA ARE LISTED UNDER THE APPROPRIATE URLS*/     
/*Load Payments here*/
LOAD DATA LOCAL INFILE 'C:/Users/TEMP/Downloads/Databases-ERD-Project/Data3/Payment.csv'
    INTO TABLE Payment
    COLUMNS TERMINATED BY ','
	OPTIONALLY ENCLOSED BY '"'
	ESCAPED BY '"'
	LINES TERMINATED BY '\n';

/*PLEASE MAKE SURE THAT THE CSV FILES THAT ARE USED FOR LOADING DATA ARE LISTED UNDER THE APPROPRIATE URLS*/
-- Load Car Servicing
LOAD DATA LOCAL INFILE 'C:/Users/TEMP/Downloads/Databases-ERD-Project/Data3/CarService.csv'  -- NB only 600 cars with 600 ids 
    INTO TABLE carservice
    COLUMNS TERMINATED BY ','
	OPTIONALLY ENCLOSED BY '"'
	ESCAPED BY '"'
	LINES TERMINATED BY '\n';
    
/*PLEASE MAKE SURE THAT THE CSV FILES THAT ARE USED FOR LOADING DATA ARE LISTED UNDER THE APPROPRIATE URLS*/    
LOAD DATA LOCAL INFILE 'C:/Users/TEMP/Downloads/Databases-ERD-Project/Data3/CarPurch.csv'  -- NB only 600 cars 
    INTO TABLE CarPurch
    COLUMNS TERMINATED BY ','
	OPTIONALLY ENCLOSED BY '"'
	ESCAPED BY '"'
	LINES TERMINATED BY '\n';    
-- Assigning Car Prices according to models
UPDATE carpurch AS p
INNER JOIN car AS c ON p.car_id = c.car_id
INNER JOIN car_model AS m ON c.model_id = m.model_id
SET purch_price = 33000   
WHERE m.model_id IN ('1', '2', '3');

UPDATE carpurch AS p
INNER JOIN car AS c ON p.car_id = c.car_id
INNER JOIN car_model AS m ON c.model_id = m.model_id
SET purch_price = 27000   
WHERE m.model_id IN ('4', '5', '6');

UPDATE carpurch AS p
INNER JOIN car AS c ON p.car_id = c.car_id
INNER JOIN car_model AS m ON c.model_id = m.model_id
SET purch_price = 12000   
WHERE m.model_id BETWEEN 7 AND 9;

UPDATE carpurch AS p
INNER JOIN car AS c ON p.car_id = c.car_id
INNER JOIN car_model AS m ON c.model_id = m.model_id
SET purch_price = 15000   
WHERE m.model_id = 10;