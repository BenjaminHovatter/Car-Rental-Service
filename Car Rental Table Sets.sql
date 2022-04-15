-- PHASE 3 Schema
DROP DATABASE IF EXISTS car_rental_service;
CREATE DATABASE car_rental_service;
USE car_rental_service;

-- User Table
CREATE TABLE `user`
(
    ssn INT(9) NOT NULL,
    user_password VARCHAR(20) NOT NULL,
    f_name VARCHAR(15) NOT NULL,
    l_name VARCHAR(15) NOT NULL,
	phone_number VARCHAR(20),
    street VARCHAR(30),
    city VARCHAR(20),
    state CHAR(2),
    zip INT(5),
    PRIMARY KEY(ssn),
    
    CONSTRAINT PK_User UNIQUE (ssn)
);

-- Test Data into User Table
INSERT INTO `user` VALUES (123456789,'Babara','MacCaffrey','781-932-9754','0 Sage Terrace','Waltham','MA',2273);
INSERT INTO `user` VALUES (987654321,'Ines','Brushfield','804-427-9456','14187 Commercial Trail','Hampton','VA',947);
INSERT INTO `user` VALUES (320498176,'Freddi','Boagey','719-724-7869','251 Springs Junction','Colorado Springs','CO',2967);
INSERT INTO `user` VALUES (410923874,'Ambur','Roseburgh','407-231-8017','30 Arapahoe Terrace','Orlando','FL',457);
INSERT INTO `user` VALUES (589783429,'Clemmie','Betchley','123-456-7890','5 Spohn Circle','Arlington','TX',3675);
INSERT INTO `user` VALUES (689888783,'Elka','Twiddell','312-480-8498','7 Manley Drive','Chicago','IL',3073);
INSERT INTO `user` VALUES (123443127,'Ilene','Dowson','615-641-4759','50 Lillian Crossing','Nashville','TN',1672);
INSERT INTO `user` VALUES (893701935,'Thacher','Naseby','941-527-3977','538 Mosinee Center','Sarasota','FL',205);
INSERT INTO `user` VALUES (959038919,'Romola','Rumgay','559-181-3744','3520 Ohio Trail','Visalia','CA',1486);
INSERT INTO `user` VALUES (193793010,'Levy','Mynett','404-246-3370','68 Lawn Avenue','Atlanta','GA',796);

-- Rental Request Table
CREATE TABLE rental_request
(
    request_id VARCHAR(8) NOT NULL,
    is_approved CHAR,
    PRIMARY KEY(request_id),
    
    CONSTRAINT PK_RR UNIQUE (request_id)
);

-- Initial Rents Babara MacAffrey & Freddi Boagey
INSERT INTO rental_request VALUES('JM7DUNUQ', 'Y');
INSERT INTO rental_request VALUES('DK5UBT29', 'Y');

-- Customer Table
CREATE TABLE customer
(
    c_id INT(9) NOT NULL,
    c_password VARCHAR(16) NOT NULL,
    license_num VARCHAR(10) NOT NULL,
    request_id VARCHAR(8),
    FOREIGN KEY (c_id) REFERENCES `user`(ssn),
    
    CONSTRAINT FK_C_ID UNIQUE (c_id),
    CONSTRAINT Check_license UNIQUE (license_num)
);

-- Test Data for Customer Table
INSERT INTO customer VALUES (123456789,'4RZC9LyJ','UMF4VFFVSH','JM7DUNUQ');
INSERT INTO customer VALUES (320498176,'FhKHx4U6','GBEA9894WW','DK5UBT29');

-- Customers who have not placed rental requests
INSERT INTO customer VALUES (410923874,'Hr9EKNeo','D2HX8Q7HUZ','');
INSERT INTO customer VALUES (589783429,'FAVz2Gkg','XJWLJRX6JX','');
INSERT INTO customer VALUES (689888783,'87EPrCim','2DVXYCMBLF','');
INSERT INTO customer VALUES (893701935,'Mb95Rvng','W64F5S7TWR','');
INSERT INTO customer VALUES (959038919,'vrkVe7Mo','AZ7AAW26JX','');
INSERT INTO customer VALUES (193793010,'ALkkR6dx','HFTGW9Y332','');

-- Agency Table
CREATE TABLE agency
(
    d_num INT NOT NULL,
    street VARCHAR(20),
    city VARCHAR(20),
    state CHAR(2),
    PRIMARY KEY(d_num)
);

-- Agency Test Data
INSERT INTO agency VALUES ('1', '123 Main Street', 'Big City', 'TX');
INSERT INTO agency VALUES ('2', '984 Little Street', 'Dallas', 'TX');

-- Staff Table
CREATE TABLE staff 
(
    s_id INT(9) NOT NULL,
    salary INT,
    start_date DATE, 
    birth_date DATE,
    agency INT,
    FOREIGN KEY (s_id) REFERENCES `user`(ssn),
    FOREIGN KEY(agency) REFERENCES agency(d_num)
);

-- Staff Test Data
INSERT INTO staff VALUES ('123443127','kLsTSEK7', '30000', '2019-01-11','1991-09-04','1');
INSERT INTO staff VALUES (987654321,'YePuz6V5','28000','2019-02-12','1992-05-23','2');

-- Payment Table
CREATE TABLE payment
(
    transaction_id INT(8) NOT NULL AUTO_INCREMENT,
    card_num INT(16) NOT NULL,
    exp_date DATE NOT NULL,
    card_holder VARCHAR(20) NOT NULL,
    amount INT NOT NULL,
    PRIMARY KEY(transaction_id),
    FOREIGN KEY(card_holder) REFERENCES customer(c_id),
    
    CONSTRAINT PK_Payment UNIQUE (transaction_id),
    CONSTRAINT Check_Exp_Date CHECK(exp_date > CURRENT_DATE())
);

-- Test Data for Payments
INSERT INTO payment VALUES (1,'9646753542274646','2024-12-02', 123456789, '59');
INSERT INTO payment VALUES (2,'8884484394877566','2024-06-30', 589783429, '36');

-- Car Supplier
CREATE TABLE car_supplier
(
    cs_id VARCHAR(30) NOT NULL,
	vin VARCHAR(30) NOT NULL,
    make VARCHAR(10),
    model CHAR(20),
    color CHAR(10),
    price_per_day INT,
    PRIMARY KEY (vin),
    
    CONSTRAINT PK_Car_Supplier UNIQUE (vin)
);

-- Test Data for Car Supplier
INSERT INTO car_supplier VALUES('WGHK', '6WWR8XUZEW', 'Ford', 'Focus RS', 'Blue', '500');
INSERT INTO car_supplier VALUES('WGHK', 'LW8BYCER3R', 'Volkswagen', 'GOLF R', 'Black', '560');
INSERT INTO car_supplier VALUES('VJMQ', 'SSVQYA2GS9', 'Ford', 'Fiesta ST', 'Yellow', '280');
INSERT INTO car_supplier VALUES('VJMQ', 'PQW7WPG2R6', 'Volkswagen', 'GOLF GTI', 'White', '340');

-- Contract Table
CREATE TABLE rental_contract 
(
    contract_id VARCHAR(10) NOT NULL,
    price INT,
    rc_start_date DATE,
    rc_end_date DATE,
    agency INT,
    car_id VARCHAR(30),
	payment_id INT(8),
    PRIMARY KEY (contract_id),
    FOREIGN KEY (payment_id) REFERENCES payment(transaction_id),
    FOREIGN KEY (agency) REFERENCES agency (d_num),
    FOREIGN KEY (car_id) REFERENCES car_supplier(vin),
    
    CONSTRAINT PK_Rental_Contract UNIQUE (contract_id),
    CONSTRAINT Check_Car_and_Date CHECK ((SELECT R.car_id
										  FROM rental_contract AS R
										  WHERE EXISTS(SELECT *
													   FROM car_supplier AS C
													   WHERE R.car_id = C.cs_id AND rc_start_date < rc_end_date)))
);

-- Test Data for Rental Contracts
INSERT INTO rental_contract VALUES('3M39L8MSE5', '100', '2022-02-01', '2022-03-01', 1, 'LW8BYCER3R', 1);
INSERT INTO rental_contract VALUES('BX8SV4JAK4', '75', '2022-02-16', '2022-03-16', 2, '6WWR8XUZEW', 2);