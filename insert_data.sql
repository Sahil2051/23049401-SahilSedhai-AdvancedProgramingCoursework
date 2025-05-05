-- Insert admin data
INSERT INTO admin (admin_id, admin_name, admin_email, access_level, created_date) 
VALUES (1, 'Sahil', 'sahil@admin.com', 'super_admin', CURRENT_DATE());

-- Insert admin credentials
INSERT INTO admin_credentials (admin_id, username, password) 
VALUES (1, 'sahil', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi'); -- This is the hashed version of 'abcd'

-- Insert some sample categories
INSERT INTO category (category_id, category_name, category_description, department) VALUES
(1, 'Groceries', 'Basic food items and household supplies', 'Food'),
(2, 'Electronics', 'Electronic devices and accessories', 'Electronics'),
(3, 'Beverages', 'Drinks and refreshments', 'Food'),
(4, 'Snacks', 'Chips, cookies, and other snacks', 'Food'),
(5, 'Household', 'Cleaning supplies and household items', 'Home');

-- Insert some sample suppliers
INSERT INTO supplier (supplier_id, supplier_name, supplier_contact, supplier_email, supplier_address) VALUES
(1, 'ABC Foods', '1234567890', 'abc@foods.com', '123 Food Street, City'),
(2, 'XYZ Electronics', '9876543210', 'xyz@electronics.com', '456 Tech Road, City'),
(3, 'Fresh Produce Co.', '5555555555', 'fresh@produce.com', '789 Farm Lane, City');

-- Insert some sample products
INSERT INTO product (product_id, product_name, product_price, expiration_date, category_id, supplier_id) VALUES
(1, 'Rice 5kg', 29.99, '2024-12-31', 1, 1),
(2, 'Smartphone', 499.99, NULL, 2, 2),
(3, 'Cola 2L', 2.99, '2024-06-30', 3, 1),
(4, 'Potato Chips', 1.99, '2024-03-31', 4, 1),
(5, 'Dish Soap', 3.99, '2024-12-31', 5, 3);

-- Insert inventory data
INSERT INTO inventory (product_id, product_quantity) VALUES
(1, 100),
(2, 50),
(3, 200),
(4, 150),
(5, 75);

-- Insert sample customer
INSERT INTO customer (customer_id, customer_name, contact_info, customer_email, customer_address) VALUES
(1, 'John Doe', '1112223333', 'john@example.com', '123 Main St, City'),
(2, 'Jane Smith', '4445556666', 'jane@example.com', '456 Oak Ave, City');

-- Insert sample user
INSERT INTO users (user_id, username, password, user_email, phone, admin_id) VALUES
(1, 'sahil', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'sahil@example.com', '7778889999', 1); 