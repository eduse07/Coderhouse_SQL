-- Creación del esquema 
CREATE SCHEMA proyect_coffee; 
USE proyect_coffee; 

-- Creación tabla zone
CREATE TABLE zone (
	id_zone INT NOT NULL,
    zone_name VARCHAR(40) NOT NULL,
    state VARCHAR(30) NOT NULL,
    PRIMARY KEY (id_zone)
    );
 
 -- Creación tabla purchase_warehouse
CREATE TABLE purchase_warehouse (
	id_warehouse VARCHAR(4) NOT NULL,
    warehouse_name VARCHAR(30) NOT NULL,
    zone INT NOT NULL,
    PRIMARY KEY (id_warehouse),
    FOREIGN KEY (zone) REFERENCES zone(id_zone)
    );

-- Creación tabla suppliers
CREATE TABLE suppliers (
	id_supplier INT NOT NULL,
    supplier_name VARCHAR(60) NOT NULL,
    document_type VARCHAR(3),
    adress VARCHAR(80),
    zone INT NOT NULL,
    PRIMARY KEY (id_supplier),
    FOREIGN KEY (zone) REFERENCES zone(id_zone)
    );

-- Creación tabla purchases
CREATE TABLE purchases (
	id_purchase VARCHAR(8) NOT NULL,
    purchase_date DATE NOT NULL,
    supplier INT NOT NULL,
    warehouse VARCHAR(4) NOT NULL,
    PRIMARY KEY (id_purchase),
    FOREIGN KEY (supplier) REFERENCES suppliers(id_supplier),
    FOREIGN KEY (warehouse) REFERENCES purchase_warehouse(id_warehouse)
    );
    
-- Creación tabla product
CREATE TABLE product (
	id_product VARCHAR(7) NOT NULL,
    product_description VARCHAR(50) NOT NULL,
    measurement_unit VARCHAR(2) NOT NULL,
    PRIMARY KEY (id_product)
    );
    
-- Creación tabla purchases_detail
CREATE TABLE purchases_detail (
	id_purchase VARCHAR(8) NOT NULL,
    id_lot VARCHAR(12) NOT NULL,
    weight FLOAT NOT NULL,
    unit_price FLOAT NOT NULL,
    id_product VARCHAR(7) NOT NULL,
    PRIMARY KEY (id_lot),
    FOREIGN KEY (id_purchase) REFERENCES purchases(id_purchase),
    FOREIGN KEY (id_product) REFERENCES product(id_product)
    ); 
    
-- Creación tabla customers
CREATE TABLE customers (
	id_customer VARCHAR(20) NOT NULL,
    customer_name VARCHAR(60) NOT NULL,
    country VARCHAR(30) NOT NULL,
    adress VARCHAR(80),
    PRIMARY KEY (id_customer)
    );
    
-- Creación tabla contracts
CREATE TABLE contracts (
	ico_number VARCHAR(15) NOT NULL,
    contract_number VARCHAR(10) NOT NULL,
    customer VARCHAR(20) NOT NULL,
    oficial_date DATE NOT NULL,
    delivery_date DATE NOT NULL,
    weight FLOAT NOT NULL,
    unit_price FLOAT NOT NULL,
    PRIMARY KEY (ico_number),
    FOREIGN KEY (customer) REFERENCES customers(id_customer)
    );
    
-- Creación tabla threshing_result
CREATE TABLE threshing_result (
	id_threshing VARCHAR(8) NOT NULL,
    ico_number VARCHAR(15) NOT NULL,
    threshing_date DATE NOT NULL,
    warehouse VARCHAR(4) NOT NULL, 
    weight FLOAT NOT NULL,
    PRIMARY KEY (id_threshing),
    FOREIGN KEY (ico_number) REFERENCES contracts(ico_number),
    FOREIGN KEY (warehouse) REFERENCES purchase_warehouse(id_warehouse)
    );
    
-- Creación tabla threshing_detail
CREATE TABLE threshing_detail (
	id_threshing VARCHAR(8) NOT NULL,
    lot VARCHAR(12) NOT NULL,
    weight FLOAT NOT NULL,
    PRIMARY KEY (id_threshing, lot),
    FOREIGN KEY (id_threshing) REFERENCES threshing_result(id_threshing),
    FOREIGN KEY (lot) REFERENCES purchases_detail(id_lot)
    );
    
-- Creación tabla invoice_master
CREATE TABLE invoice_master (
	invoice_number VARCHAR(7) NOT NULL,
    invoice_date DATE NOT NULL,
    customer VARCHAR(20) NOT NULL, 
    total_price FLOAT NOT NULL,
    product VARCHAR(7) NOT NULL,
    weight FLOAT NOT NULL, 
    PRIMARY KEY (invoice_number),
    FOREIGN KEY (customer) REFERENCES customers(id_customer),
    FOREIGN KEY (product) REFERENCES product(id_product)
    );
    
-- Creación tabla invoice_detail
CREATE TABLE invoice_detail (
	invoice_number VARCHAR(7) NOT NULL,
    ico_number VARCHAR(15) NOT NULL,
    PRIMARY KEY (invoice_number, ico_number),
    FOREIGN KEY (invoice_number) REFERENCES invoice_master(invoice_number),
    FOREIGN KEY (ico_number) REFERENCES contracts(ico_number)
    );