-- PHASE 3 Schema

-- User Table
CREATE TABLE user
(
    ssn INT(9) NOT NULL,
    phone_number INT(10),
    f_name VARCHAR(15) NOT NULL,
    l_name VARCHAR(15) NOT NULL,
    home_address VARCHAR(30),
    PRIMARY KEY(ssn)
);

-- Customer Table
CREATE TABLE customer
(
    c_id INT(9) NOT NULL,
    c_password VARCHAR(8 | 16) NOT NULL,
    license_num VARCHAR(10) NOT NULL,
    rental_request VARCHAR(8),
    insurance_claim_num INT(10),
    payment FLOAT,
    FOREIGN KEY (c_id) REFERENCES User(ssn)
);

-- Staff Table
CREATE TABLE staff 
(
    s_id INT(9) NOT NULL,
    s_password VARCHAR(8 | 16) NOT NULL,
    salary INT,
    start_date DATE, 
    birth_date DATE,
    agency VARCHAR(30)
    FOREIGN KEY (s_id) REFERENCES User(ssn)
);

-- Rental Request Table
CREATE TABLE rental_request 
(
    request_id VARCHAR(8) NOT NULL,
    is_approved CHAR,
    rr_start_date DATE,
    rr_end_date DATE,
    car_preference INT(9),
    PRIMARY KEY(request_id)
);

-- Payment Table
CREATE TABLE payment 
(
    transaction_id VARCHAR(8) NOT NULL,
    card_num INT(16) NOT NULL,
    exp_date DATE,
    cardHolder INT(9),
    amount INT,
    payment_date DATE,
    PRIMARY KEY(transaction_id),
    FOREIGN KEY(cardHolder) REFERENCES User(ssn)
);

-- Contract Table
CREATE TABLE rental_contract 
(
    contract_id VARCHAR(10) NOT NULL,
    price INT,
    rc_start_date DATE,
    rc_end_date DATE,
    agency VARCHAR(30),
    car_id VARCHAR(16),
    payment_id VARCHAR(8),
    FOREIGN KEY (payment_id) REFERENCES payment(transaction_id),

);

-- Agency Table
CREATE TABLE agency 
(
    d_num INT NOT NULL,
    address VARCHAR(30),
    PRIMARY KEY(d_num)
);

-- Car Supplier
CREATE TABLE car_supplier
(
    cs_id VARCHAR(30) NOT NULL,
    car_model VARCHAR(10),
    car_vin VARCAHR(30) NOT NULL,
    car_brand CHAR(20),
    car_color CHAR(10),
    car_price INT,
    PRIMARY KEY (cs_id)
);

-- Address Table
CREATE TABLE address_book
(
    street VARCHAR(20),
    city VARCHAR(20),
    state CHAR(20),
    postal_code INT(10),
    country CHAR(20)
);