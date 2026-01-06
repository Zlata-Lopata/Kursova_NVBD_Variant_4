UPDATE i
SET i.total_amount = p.sum_amount
FROM Invoices i
JOIN (
    SELECT invoice_id, SUM(amount) AS sum_amount
    FROM Payments
    GROUP BY invoice_id
) p ON i.invoice_id = p.invoice_id;
