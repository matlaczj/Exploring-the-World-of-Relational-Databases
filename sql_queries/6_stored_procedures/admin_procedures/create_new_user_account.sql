USE wynajem_db
GO

CREATE PROCEDURE CreateNewUserAccount
    @login varchar(20),
    @email varchar(50),
    @password varchar(20),
    @dane_bankowe varchar(26)
AS
BEGIN
    SET NOCOUNT ON;

    -- Check if the login is unique
    IF NOT EXISTS (SELECT 1
    FROM konto
    WHERE login = @login)
    BEGIN
        -- Hash the password for security (you should use a strong hashing algorithm)
        -- For example, using SHA-256 hash function
        DECLARE @hashedPassword nvarchar(64)
        SET @hashedPassword = HASHBYTES('SHA2_256', @password);

        -- Insert user data into the konto table
        INSERT INTO konto
            (login, email, haslo, dane_bankowe, srodki)
        VALUES
            (@login, @email, @hashedPassword, @dane_bankowe, 0);

        -- Return success status (1 for success, 0 for failure)
        SELECT 1 AS 'Status', 'User account created successfully.' AS 'Message';
    END
    ELSE
    BEGIN
        -- Return failure status if the login is not unique
        SELECT 0 AS 'Status', 'User account creation failed. Login already exists.' AS 'Message';
    END
END
GO

-- DECLARE @login varchar(20) = 'monkeyDluffy'
-- DECLARE @email varchar(50) = 'monkey@luffy.op'
-- DECLARE @password varchar(20) = 'strawhat'
-- DECLARE @dane_bankowe varchar(26) = '12345678901234567890123456'
-- EXEC CreateNewUserAccount @login, @email, @password, @dane_bankowe
-- GO

-- IF EXISTS (SELECT *
-- FROM sys.objects
-- WHERE type = 'P' AND name = 'CreateNewUserAccount')
-- BEGIN
--     DROP PROCEDURE CreateNewUserAccount
-- END