USE supermarket_management_system;

-- Drop all tables in correct order (respecting foreign key constraints)
DROP TABLE IF EXISTS order_items;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS cart_items;
DROP TABLE IF EXISTS cart;
DROP TABLE IF EXISTS sale_item;
DROP TABLE IF EXISTS sale;
DROP TABLE IF EXISTS remember_me_tokens;
DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS inventory;
DROP TABLE IF EXISTS product;
DROP TABLE IF EXISTS admin_credentials;
DROP TABLE IF EXISTS admin;
DROP TABLE IF EXISTS customer;
DROP TABLE IF EXISTS category;
DROP TABLE IF EXISTS supplier;

-- Create admin table
CREATE TABLE admin (
    admin_id INT(11) NOT NULL PRIMARY KEY,
    admin_name VARCHAR(100),
    admin_email VARCHAR(100),
    access_level VARCHAR(50),
    created_date DATE
);

-- Create admin_credentials table
CREATE TABLE admin_credentials (
    admin_id INT(11) NOT NULL PRIMARY KEY,
    username VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    FOREIGN KEY (admin_id) REFERENCES admin(admin_id)
);

-- Create category table
CREATE TABLE category (
    category_id INT(11) NOT NULL PRIMARY KEY,
    category_name VARCHAR(100) NOT NULL,
    category_description TEXT,
    department VARCHAR(100)
);

-- Create supplier table
CREATE TABLE supplier (
    supplier_id INT(11) NOT NULL PRIMARY KEY,
    supplier_name VARCHAR(100) NOT NULL,
    supplier_contact VARCHAR(100),
    supplier_email VARCHAR(100),
    supplier_address TEXT
);

-- Create product table
CREATE TABLE product (
    product_id INT(11) NOT NULL PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    product_price DECIMAL(10,2) NOT NULL,
    expiration_date DATE,
    category_id INT(11),
    supplier_id INT(11),
    FOREIGN KEY (category_id) REFERENCES category(category_id),
    FOREIGN KEY (supplier_id) REFERENCES supplier(supplier_id)
);

-- Create inventory table
CREATE TABLE inventory (
    product_id INT(11) NOT NULL PRIMARY KEY,
    product_quantity INT(11) NOT NULL,
    FOREIGN KEY (product_id) REFERENCES product(product_id)
);

-- Create customer table
CREATE TABLE customer (
    customer_id INT(11) NOT NULL PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    contact_info VARCHAR(100),
    customer_email VARCHAR(100),
    customer_address TEXT
);

-- Create users table
CREATE TABLE users (
    user_id INT(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    user_email VARCHAR(100) NOT NULL UNIQUE,
    phone VARCHAR(15),
    admin_id INT(11),
    FOREIGN KEY (admin_id) REFERENCES admin(admin_id)
);

-- Create remember_me_tokens table
CREATE TABLE remember_me_tokens (
    id INT(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL,
    token VARCHAR(255) NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    INDEX (username),
    INDEX (token)
);

-- Create sale table
CREATE TABLE sale (
    sale_id INT(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
    sale_date DATE NOT NULL,
    total_amount DECIMAL(10,2) NOT NULL,
    customer_id INT(11) NULL,
    user_id INT(11) NULL,
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id) ON DELETE SET NULL,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE SET NULL
);

-- Modify sale table to make sale_id auto-increment
ALTER TABLE sale MODIFY sale_id INT(11) NOT NULL AUTO_INCREMENT;

-- Create sale_item table
CREATE TABLE sale_item (
    sale_item_id INT(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
    sale_id INT(11),
    product_id INT(11),
    quantity INT(11) NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (sale_id) REFERENCES sale(sale_id),
    FOREIGN KEY (product_id) REFERENCES product(product_id)
);

-- Create cart table
CREATE TABLE cart (
    cart_id INT(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
    customer_id INT(11),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id)
);

-- Create cart_items table
CREATE TABLE cart_items (
    cart_item_id INT(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
    cart_id INT(11),
    product_id INT(11),
    quantity INT(11) NOT NULL,
    FOREIGN KEY (cart_id) REFERENCES cart(cart_id),
    FOREIGN KEY (product_id) REFERENCES product(product_id)
);

-- Create orders table
CREATE TABLE orders (
    order_id INT(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
    customer_id INT(11),
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    total_amount DECIMAL(10,2) NOT NULL,
    status VARCHAR(50) DEFAULT 'pending',
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id)
);

-- Create order_items table
CREATE TABLE order_items (
    order_item_id INT(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
    order_id INT(11),
    product_id INT(11),
    quantity INT(11) NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES product(product_id)
); 