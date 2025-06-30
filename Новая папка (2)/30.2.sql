USE PrintingCompany;
GO

IF EXISTS (SELECT * FROM sys.tables WHERE name = 'clients')
AND NOT EXISTS (SELECT 1 FROM clients)
BEGIN
    INSERT INTO clients (client_name, contact_person, phone, email, address)
    VALUES 
        ('ABC Corporation', 'John Smith', '79101112233', 'john@abc.com', '123 Main St'),
        ('XYZ Ltd', 'Sarah Johnson', '79104445566', 'sarah@xyz.com', '456 Oak Ave'),
        ('Global Print', 'Mike Brown', '79107778899', 'mike@global.com', '789 Pine Rd'),
        ('Creative Solutions', 'Anna Wilson', '79101231234', 'anna@creative.com', '321 Elm Blvd'),
        ('Premium Brands', 'David Lee', '79105675678', 'david@premium.com', '654 Maple Dr');
    PRINT '5 client records inserted successfully.';
END
ELSE IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'clients')
BEGIN
    PRINT 'Error: Clients table does not exist in the database.';
END
ELSE
BEGIN
    PRINT 'Clients table already contains data. No records inserted.';
END
GO

-- Insert sample orders (only if table exists and is empty)
IF EXISTS (SELECT * FROM sys.tables WHERE name = 'orders')
AND NOT EXISTS (SELECT 1 FROM orders)
BEGIN
    -- First ensure we have clients to reference
    IF EXISTS (SELECT 1 FROM clients WHERE client_id IN (1,2,3,4,5))
    BEGIN
        INSERT INTO orders (client_id, deadline, total_cost, manager)
        VALUES 
            (1, DATEADD(day, 7, GETDATE()), 2500.00, 'Alexey Kuznetsov'),
            (2, DATEADD(day, 5, GETDATE()), 1800.00, 'Alexey Kuznetsov'),
            (3, DATEADD(day, 10, GETDATE()), 3200.00, 'Alexey Kuznetsov'),
            (4, DATEADD(day, 3, GETDATE()), 950.00, 'Alexey Kuznetsov'),
            (5, DATEADD(day, 14, GETDATE()), 4100.00, 'Alexey Kuznetsov');
        PRINT '5 order records inserted successfully.';
    END
    ELSE
    BEGIN
        PRINT 'Error: Required client records not found. Cannot insert orders.';
    END
END
ELSE IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'orders')
BEGIN
    PRINT 'Error: Orders table does not exist in the database.';
END
ELSE
BEGIN
    PRINT 'Orders table already contains data. No records inserted.';
END
GO

-- Insert sample order items (only if table exists and is empty)
IF EXISTS (SELECT * FROM sys.tables WHERE name = 'order_items')
AND NOT EXISTS (SELECT 1 FROM order_items)
BEGIN
    -- First ensure we have orders and products to reference
    IF EXISTS (SELECT 1 FROM orders WHERE order_id IN (1,2,3,4,5))
    AND EXISTS (SELECT 1 FROM product_types WHERE product_type_id IN (1,2,3,4,5))
    BEGIN
        INSERT INTO order_items (order_id, product_type_id, quantity, format, material, color_mode)
        VALUES 
            (1, 1, 500, '90x50mm', 'Premium Cardstock', '4/4 CMYK'),
            (1, 2, 1000, 'A4', 'Glossy Paper', '4/0 CMYK'),
            (2, 3, 200, 'A5', 'Matte Paper', '4/4 CMYK'),
            (3, 4, 5000, 'A6', 'Recycled Paper', '1/1 Pantone'),
            (4, 5, 100, 'A5', 'Premium Uncoated', '4/4 CMYK'),
            (5, 1, 1000, '85x55mm', 'Linen Cardstock', '4/4 CMYK');
        PRINT '6 order item records inserted successfully.';
    END
    ELSE
    BEGIN
        PRINT 'Error: Required order or product records not found. Cannot insert order items.';
    END
END
ELSE IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'order_items')
BEGIN
    PRINT 'Error: Order_items table does not exist in the database.';
END
ELSE
BEGIN
    PRINT 'Order_items table already contains data. No records inserted.';
END
GO

IF EXISTS (SELECT * FROM sys.tables WHERE name = 'order_services')
AND NOT EXISTS (SELECT 1 FROM order_services)
BEGIN
    -- First ensure we have order items, services and employees to reference
    IF EXISTS (SELECT 1 FROM order_items WHERE item_id IN (1,2,3,4,5,6))
    AND EXISTS (SELECT 1 FROM services WHERE service_id IN (1,2,3))
    AND EXISTS (SELECT 1 FROM employees WHERE employee_id IN (1,2,3))
    BEGIN
        INSERT INTO order_services (item_id, service_type_id, employee_id, amount, cost, status)
        VALUES 
            (1, 1, 1, 5, 500.00, 'Completed'),
            (1, 2, 2, 500, 750.00, 'Completed'),
            (1, 3, 3, 1, 250.00, 'Completed'),
            (2, 1, 1, 8, 800.00, 'In Progress'),
            (2, 2, 2, 1000, 1000.00, 'Not Started'),
            (3, 1, 1, 6, 600.00, 'Completed'),
            (4, 2, 2, 5000, 2500.00, 'In Progress'),
            (5, 1, 1, 3, 300.00, 'Not Started'),
            (6, 1, 1, 10, 1000.00, 'Not Started');
        PRINT '9 order service records inserted successfully.';
    END
    ELSE
    BEGIN
        PRINT 'Error: Required order items, services or employee records not found. Cannot insert order services.';
    END
END
ELSE IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'order_services')
BEGIN
    PRINT 'Error: Order_services table does not exist in the database.';
END
ELSE
BEGIN
    PRINT 'Order_services table already contains data. No records inserted.';
END
GO

-- Verify all inserts
PRINT 'Data insertion process completed. Verification:';
SELECT 
    (SELECT COUNT(*) FROM clients) AS client_count,
    (SELECT COUNT(*) FROM orders) AS order_count,
    (SELECT COUNT(*) FROM order_items) AS order_item_count,
    (SELECT COUNT(*) FROM order_services) AS order_service_count;
GO