USE wynajem_db
GO

CREATE PROCEDURE UpdateUserInformation
    @login varchar(20),
    @newEmail varchar(50),
    @newPassword varchar(20),
    @newDaneBankowe varchar(26)
AS
BEGIN
    SET NOCOUNT ON;

    -- Check if the user exists
    IF EXISTS (SELECT 1
    FROM konto
    WHERE login = @login)
    BEGIN
        -- Hash the new password for security (you should use a strong hashing algorithm)
        DECLARE @hashedPassword nvarchar(64)
        SET @hashedPassword = HASHBYTES('SHA2_256', @newPassword);

        -- Update user information in the konto table
        UPDATE konto
        SET email = @newEmail,
            haslo = @hashedPassword,
            dane_bankowe = @newDaneBankowe
        WHERE login = @login;

        -- Return success status (1 for success, 0 for failure)
        SELECT 1 AS 'Status', 'User information updated successfully.' AS 'Message';
    END
    ELSE
    BEGIN
        -- Return failure status if the user does not exist
        SELECT 0 AS 'Status', 'User not found. Information update failed.' AS 'Message';
    END
END
GO

-- DECLARE @login varchar(20) = 'monkeyDluffy'
-- DECLARE @newEmail varchar(50) = 'funky@lake.pl'
-- DECLARE @newPassword varchar(20) = 'strawhat'
-- DECLARE @newDaneBankowe varchar(26) = '12345678901234567890123456'
-- EXEC UpdateUserInformation @login, @newEmail, @newPassword, @newDaneBankowe
-- GO

-- IF EXISTS (SELECT *
-- FROM sys.objects
-- WHERE type = 'P' AND name = 'UpdateUserInformation')
-- BEGIN
--     DROP PROCEDURE UpdateUserInformation
-- END