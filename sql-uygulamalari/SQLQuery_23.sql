CREATE database magaza

use magaza

CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    salary DECIMAL(10, 2),
    department_id INT,
    hire_date DATE
)


CREATE TABLE departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(50)
)



CREATE TABLE sales (
    sale_id INT PRIMARY KEY,
    employee_id INT,
    product_id INT,
    quantity INT,
    sale_date DATE
)



CREATE TABLE stores (
    store_id INT PRIMARY KEY,
    total_sales DECIMAL(10, 2),
    location_id INT
)



CREATE TABLE locations (
    location_id INT PRIMARY KEY,
    city VARCHAR(50),
    store_id INT
)



CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(50),
    price DECIMAL(10, 2),
    category_id INT
)



CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50)
)



CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    total_amount DECIMAL(10, 2)
)


CREATE TABLE order_items (
    order_item_id INT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT
)


CREATE TABLE inventory (
    inventory_id INT PRIMARY KEY,
    product_id INT,
    quantity INT
)



INSERT INTO employees (employee_id, first_name, last_name, salary, department_id, hire_date) VALUES
(1, 'John', 'Doe', 5000.00, 1, '2020-01-15'),
(2, 'Jane', 'Smith', 6000.00, 2, '2019-03-12'),
(3, 'Jim', 'Brown', 4500.00, 1, '2021-07-23'),
(4, 'Lucy', 'Green', 7000.00, 3, '2018-11-30')



INSERT INTO departments (department_id, department_name) VALUES
(1, 'Sales'),
(2, 'Marketing'),
(3, 'IT')


INSERT INTO sales (sale_id, employee_id, product_id, quantity, sale_date) VALUES
(1, 1, 1, 10, '2023-05-01'),
(2, 2, 2, 5, '2023-05-02'),
(3, 1, 3, 7, '2023-05-03'),
(4, 3, 1, 2, '2023-05-04')


INSERT INTO stores (store_id, total_sales, location_id) VALUES
(1, 10000.00, 1),
(2, 20000.00, 2),
(3, 15000.00, 3)



INSERT INTO locations (location_id, city, store_id) VALUES
(1, 'Istanbul', 1),
(2, 'Ankara', 2),
(3, 'Izmir', 3)


INSERT INTO products (product_id, product_name, price, category_id) VALUES
(1, 'Product A', 50.00, 1),
(2, 'Product B', 30.00, 2),
(3, 'Product C', 40.00, 3)


INSERT INTO customers (customer_id, first_name, last_name) VALUES
(1, 'Alice', 'White'),
(2, 'Bob', 'Brown'),
(3, 'Charlie', 'Black')


INSERT INTO orders (order_id, customer_id, order_date, total_amount) VALUES
(1, 1, '2023-01-15', 500.00),
(2, 2, '2023-02-20', 300.00),
(3, 1, '2023-03-25', 700.00),
(4, 3, '2023-04-30', 1000.00)


INSERT INTO order_items (order_item_id, order_id, product_id, quantity) VALUES
(1, 1, 1, 5),
(2, 1, 2, 3),
(3, 2, 3, 2),
(4, 3, 1, 7),
(5, 4, 2, 10)


INSERT INTO inventory (inventory_id, product_id, quantity) VALUES
(1, 1, 100),
(2, 2, 200),
(3, 3, 150)


