USE PrintingCompany;
GO

-- 8a. Filtering Query - Get all high-value orders (>3000) from last month
SELECT 
    o.order_id,
    c.client_name,
    o.order_date,
    o.total_cost
FROM 
    orders o
    JOIN clients c ON o.client_id = c.client_id
WHERE 
    o.total_cost > 3000
    AND o.order_date >= DATEADD(month, -1, GETDATE())
ORDER BY 
    o.total_cost DESC;
GO

-- 8b. Sorting Query - List all employees sorted by position then name
SELECT 
    employee_id,
    full_name,
    position,
    email
FROM 
    employees
ORDER BY 
    position ASC,
    full_name ASC;
GO

-- 8c. Grouping Query - Show product popularity by order count
SELECT 
    p.product_name,
    COUNT(oi.item_id) AS order_count,
    SUM(oi.quantity) AS total_quantity
FROM 
    product_types p
    LEFT JOIN order_items oi ON p.product_type_id = oi.product_type_id
GROUP BY 
    p.product_name
ORDER BY 
    order_count DESC;
GO

-- 8d. Multi-table Query - Detailed order report with services
SELECT 
    o.order_id,
    c.client_name,
    p.product_name,
    oi.quantity,
    oi.format,
    s.service_name,
    e.full_name AS assigned_employee,
    os.cost AS service_cost,
    os.status
FROM 
    orders o
    JOIN clients c ON o.client_id = c.client_id
    JOIN order_items oi ON o.order_id = oi.order_id
    JOIN product_types p ON oi.product_type_id = p.product_type_id
    JOIN order_services os ON oi.item_id = os.item_id
    JOIN services s ON os.service_type_id = s.service_id
    LEFT JOIN employees e ON os.employee_id = e.employee_id
WHERE 
    o.order_date >= '2023-01-01'
ORDER BY 
    o.order_date DESC;
GO

-- 8e. Subquery - Find clients with above-average spending
SELECT 
    c.client_id,
    c.client_name,
    COUNT(o.order_id) AS order_count,
    SUM(o.total_cost) AS total_spent
FROM 
    clients c
    JOIN orders o ON c.client_id = o.client_id
GROUP BY 
    c.client_id, c.client_name
HAVING 
    SUM(o.total_cost) > (
        SELECT AVG(total_cost) 
        FROM orders
        WHERE order_date >= DATEADD(year, -1, GETDATE())
    )
ORDER BY 
    total_spent DESC;
GO