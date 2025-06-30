-- Create the database
CREATE DATABASE PrintingCompany;
GO

USE PrintingCompany;
GO

-- Clients table
CREATE TABLE clients (
    client_id INT IDENTITY(1,1) PRIMARY KEY,
    client_name NVARCHAR(100) NOT NULL,
    contact_person NVARCHAR(100) NULL,
    phone NVARCHAR(20) NOT NULL,
    email NVARCHAR(100) NULL,
    address NVARCHAR(200) NULL,
    registration_date DATE DEFAULT GETDATE()
);
GO

-- Product types table
CREATE TABLE product_types (
    product_type_id INT IDENTITY(1,1) PRIMARY KEY,
    product_name NVARCHAR(50) NOT NULL,
    description NVARCHAR(200) NULL
);
GO

-- Services table
CREATE TABLE services (
    service_id INT IDENTITY(1,1) PRIMARY KEY,
    service_name NVARCHAR(50) NOT NULL,
    description NVARCHAR(200) NULL,
    unit_of_measure NVARCHAR(20) NOT NULL
);
GO

-- Employees table
CREATE TABLE employees (
    employee_id INT IDENTITY(1,1) PRIMARY KEY,
    full_name NVARCHAR(100) NOT NULL,
    position NVARCHAR(50) NOT NULL,
    phone NVARCHAR(20) NULL,
    email NVARCHAR(100) NULL,
    specialization NVARCHAR(200) NULL
);
GO

-- Orders table
CREATE TABLE orders (
    order_id INT IDENTITY(1,1) PRIMARY KEY,
    client_id INT NOT NULL,
    order_date DATETIME DEFAULT GETDATE(),
    deadline DATE NOT NULL,
    status NVARCHAR(20) DEFAULT 'New',
    total_cost DECIMAL(10,2) NOT NULL,
    manager NVARCHAR(100) NULL,
    CONSTRAINT FK_orders_clients FOREIGN KEY (client_id) 
        REFERENCES clients(client_id)
);
GO

-- Order items table
CREATE TABLE order_items (
    item_id INT IDENTITY(1,1) PRIMARY KEY,
    order_id INT NOT NULL,
    product_type_id INT NOT NULL,
    quantity INT NOT NULL,
    format NVARCHAR(20) NULL,
    material NVARCHAR(50) NULL,
    color_mode NVARCHAR(20) NULL,
    special_requirements NVARCHAR(500) NULL,
    CONSTRAINT FK_order_items_orders FOREIGN KEY (order_id) 
        REFERENCES orders(order_id),
    CONSTRAINT FK_order_items_product_types FOREIGN KEY (product_type_id) 
        REFERENCES product_types(product_type_id)
);
GO

-- Order services table
CREATE TABLE order_services (
    service_id INT IDENTITY(1,1) PRIMARY KEY,
    item_id INT NOT NULL,
    service_type_id INT NOT NULL,
    employee_id INT NULL,
    amount DECIMAL(10,2) NOT NULL,
    cost DECIMAL(10,2) NOT NULL,
    start_date DATE NULL,
    end_date DATE NULL,
    status NVARCHAR(20) DEFAULT 'Not started',
    CONSTRAINT FK_order_services_order_items FOREIGN KEY (item_id) 
        REFERENCES order_items(item_id),
    CONSTRAINT FK_order_services_services FOREIGN KEY (service_type_id) 
        REFERENCES services(service_id),
    CONSTRAINT FK_order_services_employees FOREIGN KEY (employee_id) 
        REFERENCES employees(employee_id)
);
GO

-- Insert initial data into product types
INSERT INTO product_types (product_name, description)
VALUES 
    ('Business Cards', 'Printed business cards'),
    ('Brochures', 'A4 brochures folded 2-3 times'),
    ('Catalogs', 'Multi-page printed catalogs'),
    ('Flyers', 'Promotional flyers A5-A4 format'),
    ('Booklets', 'Softcover booklets');
GO

-- Insert initial data into services
INSERT INTO services (service_name, description, unit_of_measure)
VALUES 
    ('Design', 'Design layout development', 'hour'),
    ('Printing', 'Digital/offset printing', 'sheet'),
    ('Post-press', 'Lamination, cutting, folding', 'operation'),
    ('Delivery', 'Finished product delivery', 'order'),
    ('Consultation', 'Project consultation', 'hour');
GO

-- Insert initial data into employees
INSERT INTO employees (full_name, position, phone, email, specialization)
VALUES 
    ('Ivan Ivanov', 'Designer', '79101234567', 'design@example.com', 'Graphic design'),
    ('Petr Petrov', 'Printer', '79107654321', 'print@example.com', 'Offset printing'),
    ('Maria Sidorova', 'Technician', '79105554433', 'tech@example.com', 'Post-press processing'),
    ('Alexey Kuznetsov', 'Manager', '79103332211', 'manager@example.com', 'Project management');
GO 