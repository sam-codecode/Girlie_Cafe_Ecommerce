-- ————————————————————————————————————————
--  GIRLIES CAFE SYSTEM - DATABASE SCHEMA  
-- ————————————————————————————————————————

-- [ RESET DATABASE ]

DROP DATABASE IF EXISTS girlies_cafe;
CREATE DATABASE IF NOT EXISTS girlies_cafe;
USE girlies_cafe;

-- [ MODULE 1 : ACCOUNT MANAGEMENT MODULE ]

-- [ ADMIN TABLE ]
CREATE TABLE admin (
	admin_id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
	name VARCHAR (100) NOT NULL,
	username VARCHAR (100) UNIQUE NOT NULL,
	password VARCHAR (255) NOT NULL
);

-- [ USER TABLE ]
CREATE TABLE user (
	user_id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
	name VARCHAR (100) NOT NULL,
	email VARCHAR (100) UNIQUE NOT NULL,
	password VARCHAR (255) NOT NULL,
	phone VARCHAR (20) NOT NULL,
	address VARCHAR (255) NOT NULL
);

-- [ MODULE 2 : MENU AND PRODUCT MANAGEMENT MODULE ]

-- [ CATEGORIES TABLE ]
CREATE TABLE categories (
	category_id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
	category_name VARCHAR (100) UNIQUE NOT NULL,
	description TEXT NULL,
	image_name VARCHAR (255) NULL
);

-- [ PRODUCTS TABLE ]
CREATE TABLE products (
	product_id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
	category_id INT NOT NULL,
	name VARCHAR (100) NOT NULL,
	description TEXT NULL,
	price DECIMAL (10, 2) NOT NULL,
	stock INT NOT NULL,
	image_name VARCHAR (255) NULL,
	FOREIGN KEY (category_id) REFERENCES categories (category_id)
);

-- [ MODULE 3 : ORDER AND PAYMENT PROCESSING MODULE ]

-- [ ORDERS TABLE ]
CREATE TABLE orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    user_id INT NOT NULL,
    order_date DATETIME NOT NULL,
    total_amount DECIMAL(10, 2) NOT NULL,
    order_status VARCHAR(20) NOT NULL,
    payment_status VARCHAR(20) NOT NULL,
    shipping_address VARCHAR(255) NOT NULL,
    note TEXT NULL,
    FOREIGN KEY (user_id) REFERENCES user(user_id)
);

-- [ ORDER_ITEMS TABLE ]
CREATE TABLE order_items (
	order_item_id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
	order_id INT NOT NULL,
	product_id INT NOT NULL,
	quantity INT NOT NULL,
	price DECIMAL (10, 2) NOT NULL,
	FOREIGN KEY (order_id ) REFERENCES orders (order_id),
	FOREIGN KEY (product_id) REFERENCES products (product_id)
);

-- [ PAYMENTS TABLE ]
CREATE TABLE payments (
	payment_id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
	order_id INT NOT NULL,
	payment_date DATETIME NOT NULL,
	payment_method VARCHAR (50) NOT NULL,
	amount DECIMAL (10, 2) NOT NULL,
	FOREIGN KEY (order_id) REFERENCES orders (order_id)
);


