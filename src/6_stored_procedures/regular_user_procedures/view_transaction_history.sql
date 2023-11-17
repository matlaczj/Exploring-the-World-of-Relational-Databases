USE wynajem_db
GO

CREATE PROCEDURE ViewTransactionHistory
    @login varchar(20)
AS
BEGIN
    -- View transaction history for the user
            SELECT [id], [kwota], [data], 'Doladowanie' AS [TransactionType]
        FROM [doladowanie]
        WHERE [login] = @login
    UNION ALL
        SELECT [id], [kwota], [data], 'Wynajem' AS [TransactionType]
        FROM [wynajem]
        WHERE [login] = @login
-- Add other relevant columns for transaction history as needed
END
GO

-- DECLARE @login varchar(20) = 'adventureSeeker'
-- EXEC ViewTransactionHistory @login
-- GO

-- IF EXISTS (SELECT *
-- FROM sys.objects
-- WHERE type = 'P' AND name = 'ViewTransactionHistory')
-- BEGIN
--     DROP PROCEDURE ViewTransactionHistory
-- END
-- GO
