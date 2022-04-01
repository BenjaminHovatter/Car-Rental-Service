-- PHASE 3 Schema
DROP DATABASE IF EXISTS car_rental_service;
CREATE DATABASE car_rental_service;
USE car_rental_service;

-- User Table
CREATE TABLE `user`
(
    ssn INT(9) NOT NULL,
    f_name VARCHAR(15) NOT NULL,
    l_name VARCHAR(15) NOT NULL,
	phone_number VARCHAR(20),
    street VARCHAR(30),
    city VARCHAR(20),
    state CHAR(2),
    zip INT(5),
    PRIMARY KEY(ssn)
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

-- Customer Table
CREATE TABLE customer
(
    c_id INT(9) NOT NULL,
    c_password VARCHAR(16) NOT NULL,
    license_num VARCHAR(10) NOT NULL,
    rental_request VARCHAR(8),
    insurance_claim INT(10),
    payment INT(8),
    FOREIGN KEY (c_id) REFERENCES `user`(ssn)
);

-- Staff Table
CREATE TABLE staff 
(
    s_id INT(9) NOT NULL,
    s_password VARCHAR(16) NOT NULL,
    salary INT,
    start_date DATE, 
    birth_date DATE,
    agency VARCHAR(30),
    FOREIGN KEY (s_id) REFERENCES `user`(ssn)
);

-- Payment Table
CREATE TABLE payment
(
    transaction_id INT(8) NOT NULL AUTO_INCREMENT,
    card_num INT(16) NOT NULL,
    exp_date DATE,
    card_holder INT(9),
    amount INT,
    payment_date DATE,
    PRIMARY KEY(transaction_id),
    FOREIGN KEY(card_holder) REFERENCES customer(c_id)
);

-- Rental Request Table
CREATE TABLE rental_request
(
    request_id VARCHAR(8) NOT NULL,
    is_approved CHAR,
    PRIMARY KEY(request_id)
);

-- Agency Table
CREATE TABLE agency
(
    d_num INT NOT NULL,
	street_number VARCHAR(20),
    street_name VARCHAR(20),
    city VARCHAR(20),
    state CHAR(2),
    car_preferences VARCHAR(30),
    PRIMARY KEY(d_num)
);

-- Car Supplier
CREATE TABLE car_supplier
(
    cs_id VARCHAR(30) NOT NULL,
    car_model VARCHAR(10),
    car_vin VARCHAR(30) NOT NULL,
    car_brand CHAR(20),
    car_color CHAR(10),
    car_price INT,
    PRIMARY KEY (cs_id)
);

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
    FOREIGN KEY (car_id) REFERENCES car_supplier(cs_id)
);