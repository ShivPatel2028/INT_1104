
create database ECommerce 
use ECommerce

create table customers(
customer_id INT PRIMARY KEY,
full_name VARCHAR(100) NOT NULL,
email VARCHAR(100) NOT NULL UNIQUE,
phone VARCHAR(15) UNIQUE,
city VARCHAR(100) NOT NULL,
state VARCHAR(100) NOT NULL ,
registration_date DATE DEFAULT CURRENT_DATE,
gender CHAR(1) CHECK (gender IN ('M','F','O'))
)

create table categories(
category_id INT PRIMARY KEY,
category_name VARCHAR(100) NOT NULL  UNIQUE ,
parent_category_id INT FOREIGN key references categories(category_id),
description TEXT DEFAULT NULL)

create table products(
product_id INT PRIMARY KEY,
product_name VARCHAR(200) NOT NULL,
category_id INT FOREIGN KEY references categories(category_id),
price DECIMAL(10,2) NOT NULL,
stock_quantity INT NOT NULL DEFAULT 0 ,
brand VARCHAR(100) NOT NULL,
rating DECIMAL(2,1) CHECK (rating between 0.0 and 5.0) 
)
create table orders(
order_id INT PRIMARY KEY,
customer_id INT FOREIGN KEY references customers(customer_id),
order_date DATETIME DEFAULT CURRENT_TIMESTAMP,
delivery_date DATE DEFAULT NULL ,
order_status VARCHAR(20) CHECK (order_status in ('Pending','Shipped','Delivered','Cancelled')), 
shipping_address VARCHAR(255) NOT NULL )

create table order_items(
item_id INT PRIMARY KEY,
order_id INT FOREIGN KEY references orders(order_id),
product_id INT FOREIGN KEY references products(product_id),
quantity INT NOT NULL CHECK (quantity>0) ,
unit_price DECIMAL(10,2) NOT NULL ,
discount DECIMAL(4,2) DEFAULT 0.00 )

create table payments(
payment_id INT PRIMARY KEY,
order_id INT FOREIGN KEY references orders(order_id),
payment_date DATETIME NOT NULL,
amount DECIMAL(10,2) NOT NULL ,
payment_method VARCHAR(30) CHECK (payment_method in('upi','Card','NetBanking','COD','Wallet')),
payment_status VARCHAR(20) CHECK (payment_status in('Success','Failed','Refunded','Pending'))) 


-- ============================================================
-- TABLE 1: customers  (30 records)
-- ============================================================

INSERT INTO customers (customer_id, full_name, email, phone, city, state, registration_date, gender) VALUES
(1,  'Aarav Sharma',      'aarav.sharma@gmail.com',     '9876543210', 'Mumbai',      'Maharashtra',  '2021-03-15', 'M'),
(2,  'Priya Mehta',       'priya.mehta@yahoo.com',      '9823456781', 'Delhi',       'Delhi',        '2021-06-20', 'F'),
(3,  'Rahul Verma',       'rahul.verma@gmail.com',      '9712345682', 'Bangalore',   'Karnataka',    '2021-09-10', 'M'),
(4,  'Sneha Patel',       'sneha.patel@gmail.com',      '9634567893', 'Ahmedabad',   'Gujarat',      '2021-12-05', 'F'),
(5,  'Vikram Singh',      'vikram.singh@outlook.com',   '9545678904', 'Chennai',     'Tamil Nadu',   '2022-01-18', 'M'),
(6,  'Ananya Iyer',       'ananya.iyer@gmail.com',      '9456766015', 'Hyderabad',   'Telangana',    '2022-03-22', 'F'),
(7,  'Karan Kapoor',      'karan.kapoor@gmail.com',     '9367990126', 'Pune',        'Maharashtra',  '2022-05-14', 'M'),
(8,  'Divya Nair',        'divya.nair@gmail.com',       '9278111237', 'Kochi',       'Kerala',       '2022-07-08', 'F'),
(9,  'Rohan Desai',       'rohan.desai@gmail.com',      '91890442348', 'Mumbai',      'Maharashtra',  '2022-09-03', 'M'),
(10, 'Meera Krishnan',    'meera.k@gmail.com',          '9090123459', 'Bangalore',   'Karnataka',    '2022-11-25', 'F'),
(11, 'Arjun Reddy',       'arjun.reddy@gmail.com',      '9901234560', 'Hyderabad',   'Telangana',    '2023-01-08', 'M'),
(12, 'Nisha Agarwal',     'nisha.agarwal@gmail.com',    '9812345671', 'Jaipur',      'Rajasthan',    '2023-02-14', 'F'),
(13, 'Siddharth Joshi',   'siddharth.j@gmail.com',      '9723456782', 'Pune',        'Maharashtra',  '2023-03-20', 'M'),
(14, 'Lakshmi Rao',       'lakshmi.rao@gmail.com',      '9114567893', 'Chennai',     'Tamil Nadu',   '2023-05-11', 'F'),
(15, 'Amit Trivedi',      'amit.trivedi@gmail.com',     '9549978904', 'Delhi',       'Delhi',        '2023-06-18', 'M'),
(16, 'Pooja Gupta',       'pooja.gupta@yahoo.com',      '9456789015', 'Lucknow',     'Uttar Pradesh','2023-07-25', 'F'),
(17, 'Manish Tiwari',     'manish.t@gmail.com',         '9367890126', 'Kolkata',     'West Bengal',  '2023-08-30', 'M'),
(18, 'Riya Malhotra',     'riya.malhotra@gmail.com',    '9278551237', 'Chandigarh',  'Punjab',       '2023-09-15', 'F'),
(19, 'Suresh Babu',       'suresh.babu@gmail.com',      '9189772348', 'Bangalore',   'Karnataka',    '2023-10-22', 'M'),
(20, 'Kavitha Menon',     'kavitha.menon@gmail.com',    '9090773459', 'Kochi',       'Kerala',       '2023-11-28', 'F'),
(21, 'Deepak Kumar',      'deepak.kumar@gmail.com',     '9901884570', 'Patna',       'Bihar',        '2023-12-10', 'M'),
(22, 'Swati Jain',        'swati.jain@yahoo.com',       '9812275681', 'Indore',      'Madhya Pradesh','2024-01-05', 'F'),
(23, 'Rajesh Pillai',     'rajesh.pillai@gmail.com',    '9723456792', 'Mumbai',      'Maharashtra',  '2024-01-18', 'M'),
(24, 'Neha Kulkarni',     'neha.kulkarni@gmail.com',    '9634567803', 'Pune',        'Maharashtra',  '2024-02-08', 'F'),
(25, 'Aditya Saxena',     'aditya.saxena@outlook.com',  '9545678914', 'Delhi',       'Delhi',        '2024-02-22', 'M'),
(26, 'Shruti Yadav',      'shruti.yadav@gmail.com',     '9456559025', 'Noida',       'Uttar Pradesh','2024-03-10', 'F'),
(27, 'Varun Malhotra',    'varun.malhotra@gmail.com',   '9367660136', 'Gurgaon',     'Haryana',      '2024-03-20', 'M'),
(28, 'Anjali Chopra',     'anjali.chopra@yahoo.com',    '9278551247', 'Ludhiana',    'Punjab',       '2024-04-05', 'F'),
(29, 'NoOrderCustomer',   'noorder@gmail.com',          '9189452358', 'Surat',       'Gujarat',      '2019-05-10', 'M'),
(30, 'InactiveCustomer',  'inactive@gmail.com',         '9090113469', 'Vadodara',    'Gujarat',      '2019-08-15', 'F');

-- ============================================================
-- TABLE 2: categories  (15 records — with sub-categories)
-- ============================================================

INSERT INTO categories (category_id, category_name, parent_category_id, description) VALUES
(1,  'Electronics',         NULL, 'Electronic gadgets and devices'),
(2,  'Fashion',             NULL, 'Clothing and accessories'),
(3,  'Home & Kitchen',      NULL, 'Home appliances and kitchen tools'),
(4,  'Books',               NULL, 'Educational and recreational books'),
(5,  'Sports & Fitness',    NULL, 'Sports equipment and fitness gear'),
(6,  'Mobile Phones',       1,    'Smartphones and accessories'),
(7,  'Laptops',             1,    'Laptops and computers'),
(8,  'Cameras',             1,    'Digital cameras and photography'),
(9,  'Men Clothing',        2,    'Shirts, trousers, and menswear'),
(10, 'Women Clothing',      2,    'Kurtas, sarees, and womenswear'),
(11, 'Footwear',            2,    'Shoes and sandals'),
(12, 'Kitchen Appliances',  3,    'Mixers, cookers, and appliances'),
(13, 'Furniture',           3,    'Tables, chairs, sofas'),
(14, 'Fiction Books',       4,    'Novels and story books'),
(15, 'Gym Equipment',       5,    'Dumbbells, treadmills, yoga mats');


-- ============================================================
-- TABLE 3: products  (40 records)
-- ============================================================

INSERT INTO products (product_id, product_name, category_id, price, stock_quantity, brand, rating) VALUES
(1,  'Samsung Galaxy S23',           6,  74999.00,  50, 'Samsung',     4.5),
(2,  'Apple iPhone 15',              6, 109999.00,  30, 'Apple',       4.8),
(3,  'OnePlus 12R',                  6,  39999.00,  80, 'OnePlus',     4.3),
(4,  'Redmi Note 13 Pro',            6,  24999.00, 120, 'Xiaomi',      4.2),
(5,  'Dell Inspiron 15',             7,  65000.00,  25, 'Dell',        4.2),
(6,  'HP Pavilion x360',             7,  72000.00,  20, 'HP',          4.1),
(7,  'Lenovo IdeaPad Slim 5',        7,  58000.00,  35, 'Lenovo',      4.4),
(8,  'Canon EOS 1500D',              8,  45000.00,  15, 'Canon',       4.6),
(9,  'Nikon D3500',                  8,  42000.00,  12, 'Nikon',       4.5),
(10, 'Raymond Formal Shirt',         9,   1499.00, 200, 'Raymond',     4.0),
(11, 'Levis 511 Slim Jeans',       9,   2999.00, 150,		'Levi',     4.3),
(12, 'Fabindia Cotton Kurta',       10,   1299.00, 180, 'Fabindia',    4.2),
(13, 'W Women Anarkali Kurta',      10,   1799.00, 120, 'W',           4.1),
(14, 'Nike Running Shoes',          11,   5999.00,  90, 'Nike',        4.7),
(15, 'Adidas Ultraboost',           11,   8999.00,  60, 'Adidas',      4.6),
(16, 'Prestige Mixer Grinder',      12,   4500.00,  60, 'Prestige',    4.3),
(17, 'Instant Pot Duo 7-in-1',      12,   9999.00,  40, 'Instant Pot', 4.6),
(18, 'Study Table Wooden',          13,   8500.00,  30, 'DuPure',      4.0),
(19, 'Office Chair Ergonomic',      13,  12000.00,  25, 'Featherlite', 4.4),
(20, 'Physics NCERT Class 12',      14,    350.00, 500, 'NCERT',       4.7),
(21, 'Data Structures by Cormen',   14,    799.00, 300, 'MIT Press',   4.8),
(22, 'Harry Potter Collection',     14,   2499.00, 150, 'Bloomsbury',  4.9),
(23, 'Dumbbell Set 20kg',           15,   3500.00,  75, 'Kore',        4.2),
(24, 'Yoga Mat Anti-Slip',          15,    899.00, 200, 'Boldfit',     4.4),
(25, 'Treadmill Motorized',         15,  45000.00,  10, 'Powermax',    4.5),
(26, 'Boat Airdopes 141',            6,   1499.00, 300, 'Boat',        4.1),
(27, 'JBL Bluetooth Speaker',        1,   5999.00,  85, 'JBL',         4.6),
(28, 'Sony Headphones WH-1000XM5',   1,  29999.00,  40, 'Sony',        4.8),
(29, 'Puma Sports T-Shirt',          9,    999.00, 250, 'Puma',        4.0),
(30, 'Reebok Track Pants',           9,   1499.00, 180, 'Reebok',      4.1),
(31, 'Fastrack Analog Watch',        2,   1999.00, 100, 'Fastrack',    4.2),
(32, 'Titan Smart Watch',            2,  12999.00,  50, 'Titan',       4.5),
(33, 'Philips Air Fryer',           12,   8999.00,  45, 'Philips',     4.7),
(34, 'LG Microwave Oven',           12,  11000.00,  30, 'LG',          4.4),
(35, 'Sofa Set 3 Seater',           13,  35000.00,  15, 'Urban Ladder',4.3),
(36, 'Dining Table 6 Seater',       13,  28000.00,  20, 'Pepperfry',   4.2),
(37, 'The Alchemist Novel',         14,    399.00, 400, 'HarperCollins',4.8),
(38, 'Rich Dad Poor Dad',           14,    499.00, 350, 'Penguin',     4.7),
(39, 'Resistance Bands Set',        15,    799.00, 150, 'Amazon Basics',4.3),
(40, 'OutOfStock Product',           5,   1999.00,   0, 'Unavailable', 0.0);


-- ============================================================
-- TABLE 4: orders  (35 records)
-- ============================================================

INSERT INTO orders (order_id, customer_id, order_date, delivery_date, order_status, shipping_address) VALUES
(1,  1,  '2024-01-05 10:30:00', '2024-01-08', 'Delivered',  'Flat 201, Andheri West, Mumbai - 400053'),
(2,  2,  '2024-01-10 14:15:00', '2024-01-13', 'Delivered',  'A-12, Karol Bagh, Delhi - 110005'),
(3,  3,  '2024-01-15 09:00:00', '2024-01-18', 'Delivered',  '45, Koramangala, Bangalore - 560034'),
(4,  4,  '2024-01-20 16:45:00', '2024-01-24', 'Delivered',  'B-7, Navrangpura, Ahmedabad - 380009'),
(5,  5,  '2024-02-01 11:00:00', '2024-02-04', 'Delivered',  '32, T Nagar, Chennai - 600017'),
(6,  6,  '2024-02-05 13:30:00', '2024-02-09', 'Shipped',    '10, Banjara Hills, Hyderabad - 500034'),
(7,  7,  '2024-02-10 08:45:00', '2024-02-14', 'Delivered',  '22, Kothrud, Pune - 411038'),
(8,  8,  '2024-02-15 17:00:00', NULL,          'Cancelled',  '5, MG Road, Kochi - 682016'),
(9,  9,  '2024-02-18 10:15:00', '2024-02-22', 'Delivered',  'Flat 8, Dadar, Mumbai - 400014'),
(10, 10, '2024-02-22 12:30:00', '2024-02-26', 'Delivered',  '88, Indiranagar, Bangalore - 560038'),
(11, 1,  '2024-03-01 09:30:00', '2024-03-05', 'Delivered',  'Flat 201, Andheri West, Mumbai - 400053'),
(12, 2,  '2024-03-05 15:00:00', NULL,          'Pending',    'A-12, Karol Bagh, Delhi - 110005'),
(13, 11, '2024-03-08 11:00:00', '2024-03-12', 'Delivered',  '14, Jubilee Hills, Hyderabad - 500033'),
(14, 12, '2024-03-10 14:45:00', '2024-03-14', 'Delivered',  'C-9, Vaishali Nagar, Jaipur - 302021'),
(15, 3,  '2024-03-12 10:00:00', NULL,          'Shipped',    '45, Koramangala, Bangalore - 560034'),
(16, 13, '2024-03-15 16:30:00', '2024-03-19', 'Delivered',  '18, Shivajinagar, Pune - 411005'),
(17, 5,  '2024-03-18 09:00:00', NULL,          'Pending',    '32, T Nagar, Chennai - 600017'),
(18, 14, '2024-03-20 13:00:00', '2024-03-24', 'Delivered',  '7, Anna Nagar, Chennai - 600040'),
(19, 15, '2024-03-22 10:30:00', NULL,          'Cancelled',  'D-5, Lajpat Nagar, Delhi - 110024'),
(20, 19, '2024-03-25 14:00:00', '2024-03-29', 'Delivered',  '33, Whitefield, Bangalore - 560066'),
(21, 1,  '2024-04-01 11:00:00', '2024-04-05', 'Delivered',  'Flat 201, Andheri West, Mumbai - 400053'),
(22, 16, '2024-04-03 10:00:00', '2024-04-07', 'Delivered',  '45, Gomti Nagar, Lucknow - 226010'),
(23, 17, '2024-04-05 14:30:00', '2024-04-09', 'Delivered',  '12, Salt Lake, Kolkata - 700091'),
(24, 18, '2024-04-08 09:30:00', NULL,          'Shipped',    '8, Sector 17, Chandigarh - 160017'),
(25, 20, '2024-04-10 16:00:00', '2024-04-14', 'Delivered',  '22, Marine Drive, Kochi - 682031'),
(26, 4,  '2024-04-12 11:30:00', '2024-04-16', 'Delivered',  'B-7, Navrangpura, Ahmedabad - 380009'),
(27, 21, '2024-04-15 10:00:00', '2024-04-19', 'Delivered',  '5, Gandhi Maidan, Patna - 800001'),
(28, 22, '2024-04-18 13:00:00', NULL,          'Pending',    '18, Vijay Nagar, Indore - 452010'),
(29, 23, '2024-04-20 15:30:00', '2024-04-24', 'Delivered',  '88, Bandra West, Mumbai - 400050'),
(30, 24, '2024-04-22 09:00:00', '2024-04-26', 'Delivered',  '10, Pimpri, Pune - 411018'),
(31, 6,  '2024-04-25 12:00:00', '2024-04-29', 'Delivered',  '10, Banjara Hills, Hyderabad - 500034'),
(32, 25, '2023-05-10 10:00:00', '2023-05-14', 'Cancelled',  'G-12, Connaught Place, Delhi - 110001'),
(33, 11, '2024-04-28 14:00:00', NULL,          'Shipped',    '14, Jubilee Hills, Hyderabad - 500033'),
(34, 26, '2024-05-01 11:00:00', '2024-05-05', 'Delivered',  '22, Sector 62, Noida - 201301'),
(35, 27, '2024-05-03 10:30:00', NULL,          'Pending',    '15, DLF Phase 2, Gurgaon - 122002');
-- Note: customer_id 29 and 30 have no orders


-- ============================================================
-- TABLE 5: order_items  (70 records)
-- ============================================================

INSERT INTO order_items (item_id, order_id, product_id, quantity, unit_price, discount) VALUES
(1,  1,  2,  1, 109999.00, 5.00),
(2,  1,  26, 2,   1499.00, 0.00),
(3,  1,  14, 1,   5999.00, 0.00),
(4,  2,  10, 3,   1499.00, 10.00),
(5,  2,  11, 2,   2999.00, 5.00),
(6,  3,  5,  1,  65000.00, 8.00),
(7,  3,  21, 2,    799.00, 0.00),
(8,  4,  12, 3,   1299.00, 5.00),
(9,  4,  13, 2,   1799.00, 0.00),
(10, 5,  1,  1,  74999.00, 3.00),
(11, 5,  24, 1,    899.00, 0.00),
(12, 6,  17, 1,   9999.00, 10.00),
(13, 6,  16, 1,   4500.00, 5.00),
(14, 7,  20, 5,    350.00, 0.00),
(15, 7,  37, 3,    399.00, 0.00),
(16, 8,  3,  1,  39999.00, 0.00),
(17, 9,  7,  1,  58000.00, 7.00),
(18, 9,  23, 1,   3500.00, 0.00),
(19, 10, 6,  1,  72000.00, 5.00),
(20, 11, 14, 2,   5999.00, 0.00),
(21, 11, 24, 1,    899.00, 10.00),
(22, 12, 2,  1, 109999.00, 5.00),
(23, 13, 1,  1,  74999.00, 0.00),
(24, 13, 26, 1,   1499.00, 5.00),
(25, 14, 10, 4,   1499.00, 10.00),
(26, 15, 5,  1,  65000.00, 0.00),
(27, 16, 21, 2,    799.00, 0.00),
(28, 16, 38, 1,    499.00, 0.00),
(29, 17, 16, 1,   4500.00, 5.00),
(30, 18, 12, 2,   1299.00, 0.00),
(31, 20, 7,  1,  58000.00, 8.00),
(32, 21, 28, 1,  29999.00, 5.00),
(33, 21, 27, 1,   5999.00, 0.00),
(34, 22, 4,  2,  24999.00, 10.00),
(35, 22, 30, 1,   1499.00, 0.00),
(36, 23, 8,  1,  45000.00, 5.00),
(37, 23, 9,  1,  42000.00, 5.00),
(38, 24, 15, 1,   8999.00, 0.00),
(39, 25, 33, 1,   8999.00, 10.00),
(40, 26, 3,  1,  39999.00, 5.00),
(41, 27, 22, 1,   2499.00, 0.00),
(42, 28, 31, 2,   1999.00, 0.00),
(43, 29, 32, 1,  12999.00, 8.00),
(44, 30, 19, 1,  12000.00, 5.00),
(45, 31, 34, 1,  11000.00, 0.00),
(46, 33, 25, 1,  45000.00, 10.00),
(47, 34, 35, 1,  35000.00, 5.00),
(48, 35, 36, 1,  28000.00, 0.00),
(49, 1,  29, 2,    999.00, 0.00),
(50, 3,  10, 1,   1499.00, 0.00),
(51, 5,  11, 1,   2999.00, 5.00),
(52, 9,  15, 1,   8999.00, 10.00),
(53, 10, 27, 1,   5999.00, 0.00),
(54, 13, 14, 1,   5999.00, 0.00),
(55, 16, 39, 2,    799.00, 0.00),
(56, 18, 24, 2,    899.00, 0.00),
(57, 20, 23, 1,   3500.00, 0.00),
(58, 21, 26, 3,   1499.00, 10.00),
(59, 22, 29, 3,    999.00, 0.00),
(60, 23, 20, 10,   350.00, 0.00),
(61, 25, 16, 1,   4500.00, 5.00),
(62, 26, 13, 1,   1799.00, 0.00),
(63, 27, 37, 2,    399.00, 0.00),
(64, 29, 6,  1,  72000.00, 12.00),
(65, 30, 18, 1,   8500.00, 0.00),
(66, 31, 17, 1,   9999.00, 8.00),
(67, 34, 19, 1,  12000.00, 10.00),
(68, 11, 15, 1,   8999.00, 5.00),
(69, 13, 23, 1,   3500.00, 0.00),
(70, 20, 33, 1,   8999.00, 5.00);
-- Note: Some products have never been ordered (useful for LEFT JOIN)


-- ============================================================
-- TABLE 6: payments  (30 records — orders 8, 19, 32 cancelled)
-- ============================================================

INSERT INTO payments (payment_id, order_id, payment_date, amount, payment_method, payment_status) VALUES
(1,  1,  '2024-01-05 10:35:00', 120495.10, 'Card',       'Success'),
(2,  2,  '2024-01-10 14:18:00',   9343.65, 'UPI',        'Success'),
(3,  3,  '2024-01-15 09:05:00',  62268.00, 'NetBanking', 'Success'),
(4,  4,  '2024-01-20 16:50:00',   7295.05, 'UPI',        'Success'),
(5,  5,  '2024-02-01 11:05:00',  78646.03, 'Card',       'Success'),
(6,  6,  '2024-02-05 13:35:00',  13724.50, 'Wallet',     'Success'),
(7,  7,  '2024-02-10 08:50:00',   2947.00, 'COD',        'Success'),
(8,  9,  '2024-02-18 10:20:00',  64809.00, 'Card',       'Success'),
(9,  10, '2024-02-22 12:35:00',  74399.00, 'UPI',        'Success'),
(10, 11, '2024-03-01 09:35:00',  20546.10, 'UPI',        'Success'),
(11, 12, '2024-03-05 15:05:00', 104499.05, 'Card',       'Pending'),
(12, 13, '2024-03-08 11:05:00',  80497.05, 'UPI',        'Success'),
(13, 14, '2024-03-10 14:50:00',   5396.40, 'COD',        'Success'),
(14, 15, '2024-03-12 10:05:00',  65000.00, 'NetBanking', 'Success'),
(15, 16, '2024-03-15 16:35:00',   2097.00, 'UPI',        'Success'),
(16, 17, '2024-03-18 09:05:00',   4275.00, 'Wallet',     'Pending'),
(17, 18, '2024-03-20 13:05:00',   4396.00, 'UPI',        'Success'),
(18, 20, '2024-03-25 14:05:00',  66384.00, 'Card',       'Success'),
(19, 21, '2024-04-01 11:05:00',  37557.30, 'Card',       'Success'),
(20, 22, '2024-04-03 10:05:00',  48496.10, 'UPI',        'Success'),
(21, 23, '2024-04-05 14:35:00',  86150.00, 'Card',       'Success'),
(22, 24, '2024-04-08 09:35:00',   8999.00, 'Wallet',     'Pending'),
(23, 25, '2024-04-10 16:05:00',  12374.05, 'UPI',        'Success'),
(24, 26, '2024-04-12 11:35:00',  39798.05, 'Card',       'Success'),
(25, 27, '2024-04-15 10:05:00',   2499.00, 'COD',        'Success'),
(26, 28, '2024-04-18 13:05:00',   3998.00, 'UPI',        'Pending'),
(27, 29, '2024-04-20 15:35:00',  75351.08, 'Card',       'Success'),
(28, 30, '2024-04-22 09:05:00',  19900.00, 'NetBanking', 'Success'),
(29, 31, '2024-04-25 12:05:00',  10119.08, 'UPI',        'Success'),
(30, 33, '2024-04-28 14:05:00',  40500.00, 'Card',       'Pending');
-- Note: Orders 8, 19, 32, 34, 35 have no payment records



--Q21. Find all products where price is greater than 1000 and less than or equal to 5000.

SELECT *
FROM products
WHERE price > 1000 
  AND price <= 5000;

 --Q22. Retrieve all orders where order_status is NOT 'Cancelled'.

 SELECT *
FROM orders
WHERE order_status <> 'Cancelled';

--Q23. List all customers whose city is either 'Mumbai' OR 'Delhi'.

SELECT *
FROM customers
WHERE city = 'Mumbai'
   OR city = 'Delhi';

--Q24. Find all products where stock_quantity is between 10 and 100 (inclusive).

SELECT *
FROM products
WHERE stock_quantity BETWEEN 10 AND 100;

--Q25. Display all customers whose email ends with '@gmail.com'.

SELECT *
FROM customers
WHERE email LIKE '%@gmail.com';

--Q26. Retrieve all products where brand starts with 'Sam'

SELECT *
FROM products
WHERE brand LIKE 'Sam%';

--Q27. Find all orders where delivery_date IS NULL.

SELECT *
FROM orders
WHERE delivery_date IS NULL;	

--Q28. List all payments where payment_method is IN ('UPI', 'Card', 'Wallet').

SELECT *
FROM payments
WHERE payment_method IN ('UPI', 'Card', 'Wallet');

--Q29. Display all products where rating IS NOT NULL and rating >= 4.0.

SELECT *
FROM products
WHERE rating IS NOT NULL
  AND rating >= 4.0;

--Q30. Find all customers where full_name contains the word 'Kumar' anywhere in the name.

  SELECT *
  FROM customers
  WHERE full_name LIKE '%Kumar%';

 --Q31. Retrieve all customers from the state 'Maharashtra'

 SELECT *
 FROM customers
 WHERE state = 'Maharashtra';

 --Q32. Find all products with a price greater than 2000.

 SELECT *
 FROM products
 WHERE price > 2000;

--Q33. List all orders placed on '2024-03-15'

SELECT *
FROM orders
WHERE cast(order_date as date) = '2024-03-15';


--Q34. Display all order_items where discount is greater than 5.0.

SELECT *
FROM order_items
WHERE discount > 5.0;


--Q35. Find all payments where amount is less than or equal to 500.

SELECT *
FROM payments
WHERE amount <= 500;


--Q36. Retrieve all products where category_id = 3 and stock_quantity >20.

SELECT *
FROM products
WHERE category_id = 3
  AND stock_quantity > 20;


--Q37. List all customers who registered after '2023-01-01'.

SELECT *
FROM customers
WHERE registration_date > '2023-01-01';

--Q38. Find all orders where order_status = 'Delivered'; and delivery_date is before '2024-02-01'.

SELECT *
FROM orders
WHERE order_status = 'Delivered'
  AND delivery_date < '2024-02-01';


--Q39. Display all products where brand = 'Apple' and rating >= 4.5.

SELECT *
FROM products
WHERE brand = 'Apple'
  AND rating >= 4.5;


--Q40. Retrieve all payments where payment_status = 'Success' and payment_method = 'UPI'.

SELECT *
FROM payments
WHERE payment_status = 'Success'
  AND payment_method = 'UPI';


--Q41. List all products ordered by price in descending order.

SELECT *
FROM products
ORDER BY price DESC;

--Q42. Display all customers ordered by registration_date in ascending order.

SELECT *
FROM customers
ORDER BY registration_date ASC;


--Q43. Retrieve all orders ordered by order_date in descending order (most recent first).

SELECT *
FROM orders
ORDER BY order_date DESC;


--Q44. List all products ordered by rating in descending order, then by price in ascending order.

SELECT *
FROM products
ORDER BY rating DESC, price ASC;

--Q45. Display the top 10 most expensive products. Use ORDER BY with LIMIT.

SELECT  top (10)
* FROM products
ORDER BY price DESC


