
CREATE TABLE CUSTOMERS
(
	CUSTOMER_ID		VARCHAR(20) primary key,
	FIRST_NAME		VARCHAR(40) not null,
	LAST_NAME		VARCHAR(40) ,
	PHONE_NO		INT unique,
	ADDRESS			VARCHAR(100),
	DOB				DATE,
	IS_ACTIVE		varchar(10) check (IS_ACTIVE in ('active', 'inactive'))
);


--Primary Key Constraint
-- It is a combination of UNIQUE and NOT NULL constraints. It does not allow duplicate 
-- values as well as null values for the primary key column


insert into customers (customer_id, first_name, last_name, phone_no, address, dob, is_active)
values ('CID1', 'Vignesh', 'Raja', 76765, 'Chennai', '1985-07-17', 'active');


insert into customers (customer_id, first_name, last_name, phone_no, address, dob, is_active)
values ('CID1', 'Sachin', 'Tendulkar', 74565, 'Mumbai', '1975-04-24', 'active');

-- ERROR:  duplicate key value violates unique constraint "customers_pkey"
-- DETAIL:  Key (customer_id)=(CID1) already exists.
-- SQL state: 23505

-- Errors out as it cannot accept null
insert into customers (customer_id, first_name, last_name, phone_no, address, dob, is_active)
values (null, 'Sachin', 'Tendulkar', 74565, 'Mumbai', '1975-04-24', 'active');

-- This will work because it is string null
insert into customers (customer_id, first_name, last_name, phone_no, address, dob, is_active)
values ('null', 'Sachin', 'Tendulkar', 74565, 'Mumbai', '1975-04-24', 'active');


-- Check Constraint 
-- We define a condition for the column and the values meeting the condition only can be inserted


insert into customers (customer_id, first_name, last_name, is_active)
values ('CID3', 'Mohan', 'Kumar', 'new');

-- ERROR:  new row for relation "customers" violates check constraint "customers_is_active_check"
-- DETAIL:  Failing row contains (CID3, Mohan, Kumar, null, null, null, new).
-- SQL state: 23514


-- Foreign Key Constraint 
-- It helps to build a parent to child relationship or dependency between two tables. 


CREATE TABLE PRODUCTS
(
	PROD_ID	 		VARCHAR(10),
	PROD_NAME		VARCHAR(20) unique,
	PROD_DESC		VARCHAR(200)
);


CREATE TABLE ORDERS
(
	ORDER_ID	 		VARCHAR(10) PRIMARY KEY,
	PROD_NAME		VARCHAR(20) REFERENCES PRODUCTS(prod_name),
	ORDER_AMOUNT		INT
);

INSERT INTO PRODUCTS VALUES ('1', 'Iphone14', 'Iphone 14 Model');
INSERT INTO PRODUCTS VALUES ('2', 'Macbook Pro14', 'Mac Laptop 14 Inch');

INSERT INTO ORDERS VALUES ('1', 'Iphone14', 74000);
INSERT INTO ORDERS VALUES ('2', 'Macbook Pro14', 175000);

INSERT INTO ORDERS VALUES ('3', 'Macbook Pro16', 275000);

--ERROR:  insert or update on table "orders" violates foreign key constraint "orders_prod_name_fkey"
--DETAIL:  Key (prod_name)=(Macbook Pro16) is not present in table "products".
--SQL state: 23503

-- Now the record can be inserted only when the Prod name is added to the parent table - Products
INSERT INTO PRODUCTS VALUES ('3', 'Macbook Pro16', 'Mac Laptop 16 Inch');

INSERT INTO ORDERS VALUES ('3', 'Macbook Pro16', 275000);
