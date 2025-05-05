-- First, drop all existing tables if they exist
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

-- Create admin table first (no foreign key dependencies)
CREATE TABLE admin (
    admin_id INT(11) NOT NULL PRIMARY KEY,
    admin_name VARCHAR(100) NOT NULL,
    admin_email VARCHAR(100) NOT NULL,
    access_level VARCHAR(50) NOT NULL,
    created_date DATE NOT NULL
);

-- Create admin_credentials table (depends on admin)
CREATE TABLE admin_credentials (
    admin_id INT(11) NOT NULL PRIMARY KEY,
    username VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    FOREIGN KEY (admin_id) REFERENCES admin(admin_id) ON DELETE CASCADE
);

-- Create category table (no foreign key dependencies)
CREATE TABLE category (
    category_id INT(11) NOT NULL PRIMARY KEY,
    category_name VARCHAR(100) NOT NULL,
    category_description TEXT,
    department VARCHAR(100)
);

-- Create supplier table (no foreign key dependencies)
CREATE TABLE supplier (
    supplier_id INT(11) NOT NULL PRIMARY KEY,
    supplier_name VARCHAR(100) NOT NULL,
    supplier_contact VARCHAR(100),
    supplier_email VARCHAR(100),
    supplier_address TEXT
);

-- Create product table (depends on category and supplier)
CREATE TABLE product (
    product_id INT(11) NOT NULL PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    product_price DECIMAL(10,2) NOT NULL,
    expiration_date DATE,
    category_id INT(11),
    supplier_id INT(11),
    FOREIGN KEY (category_id) REFERENCES category(category_id) ON DELETE SET NULL,
    FOREIGN KEY (supplier_id) REFERENCES supplier(supplier_id) ON DELETE SET NULL
);

-- Create inventory table (depends on product)
CREATE TABLE inventory (
    product_id INT(11) NOT NULL PRIMARY KEY,
    product_quantity INT(11) NOT NULL DEFAULT 0,
    FOREIGN KEY (product_id) REFERENCES product(product_id) ON DELETE CASCADE
);

-- Create customer table (no foreign key dependencies)
CREATE TABLE customer (
    customer_id INT(11) NOT NULL PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    contact_info VARCHAR(100),
    customer_email VARCHAR(100),
    customer_address TEXT
);

-- Create users table (depends on admin)
CREATE TABLE users (
    user_id INT(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    user_email VARCHAR(100) NOT NULL UNIQUE,
    phone VARCHAR(15),
    admin_id INT(11),
    FOREIGN KEY (admin_id) REFERENCES admin(admin_id) ON DELETE SET NULL
);

-- Create remember_me_tokens table (no foreign key dependencies)
CREATE TABLE remember_me_tokens (
    id INT(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL,
    token VARCHAR(255) NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    INDEX (username),
    INDEX (token)
);

-- Create sale table (depends on customer and users)
CREATE TABLE sale (
    sale_id INT(11) NOT NULL PRIMARY KEY,
    sale_date DATE NOT NULL,
    total_amount DECIMAL(10,2) NOT NULL,
    customer_id INT(11),
    user_id INT(11),
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id) ON DELETE SET NULL,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE SET NULL
);

-- Create sale_item table (depends on sale and product)
CREATE TABLE sale_item (
    sale_item_id INT(11) NOT NULL PRIMARY KEY,
    sale_id INT(11) NOT NULL,
    product_id INT(11) NOT NULL,
    quantity INT(11) NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (sale_id) REFERENCES sale(sale_id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES product(product_id) ON DELETE CASCADE
);

-- Create cart table (depends on customer)
CREATE TABLE cart (
    cart_id INT(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
    customer_id INT(11),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id) ON DELETE SET NULL
);

-- Create cart_items table (depends on cart and product)
CREATE TABLE cart_items (
    cart_item_id INT(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
    cart_id INT(11) NOT NULL,
    product_id INT(11) NOT NULL,
    quantity INT(11) NOT NULL,
    FOREIGN KEY (cart_id) REFERENCES cart(cart_id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES product(product_id) ON DELETE CASCADE
);

-- Create orders table (depends on customer)
CREATE TABLE orders (
    order_id INT(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
    customer_id INT(11),
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    total_amount DECIMAL(10,2) NOT NULL,
    status VARCHAR(50) DEFAULT 'pending',
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id) ON DELETE SET NULL
);

-- Create order_items table (depends on orders and product)
CREATE TABLE order_items (
    order_item_id INT(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
    order_id INT(11) NOT NULL,
    product_id INT(11) NOT NULL,
    quantity INT(11) NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(order_id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES product(product_id) ON DELETE CASCADE
); 