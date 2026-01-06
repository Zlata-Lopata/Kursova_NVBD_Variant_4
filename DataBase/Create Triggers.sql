USE Excursions;
GO

GO
CREATE TRIGGER trg_UpdateInvoiceAfterPayment
ON Payments
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE i
    SET 
        total_amount = ISNULL(p.sum_amount, 0),
        status = 
            CASE 
                WHEN ISNULL(p.sum_amount, 0) = 0 THEN 'не оплачено'
                WHEN ISNULL(p.sum_amount, 0) < e.price THEN 'частково'
                ELSE 'оплачено'
            END
    FROM Invoices i
    JOIN Excursions e ON i.excursion_id = e.excursion_id
    LEFT JOIN (
        SELECT invoice_id, SUM(amount) AS sum_amount
        FROM Payments
        GROUP BY invoice_id
    ) p ON i.invoice_id = p.invoice_id
    WHERE i.invoice_id IN (
        SELECT invoice_id FROM inserted
        UNION
        SELECT invoice_id FROM deleted
    );
END;
GO


GO
CREATE TRIGGER trg_CreateInvoiceAfterExcursion
ON Excursions
AFTER INSERT
AS
BEGIN
    INSERT INTO Invoices (excursion_id, invoice_date, total_amount, status)
    SELECT 
        excursion_id,
        GETDATE(),
        0,
        'не оплачено'
    FROM inserted;
END;
GO
