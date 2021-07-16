SELECT o.id, o.order_date, c.name, c.phone_number, o.type, SUM(od.qty * i.price) AS Total, GROUP_CONCAT(CONCAT(od.qty, 'x ', i.name) SEPARATOR ', ') AS Orders
FROM orders o 
JOIN users c ON o.user_id = c.id
JOIN order_details od ON od.order_id = o.id
JOIN items i ON i.id = od.item_id
GROUP BY o.id