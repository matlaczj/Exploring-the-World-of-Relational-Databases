USE wynajem_db
GO

CREATE PROCEDURE RentBot
    @login varchar(20),
    @botID integer,
    @rentalDuration integer
AS
BEGIN
    -- Calculate the rental fee
    DECLARE @botRentalFee integer = 10 * @rentalDuration
    -- Check if the user has sufficient funds
    IF (SELECT [srodki]
    FROM [konto]
    WHERE [login] = @login) >= @botRentalFee
    BEGIN
        -- Deduct the rental fee from user's balance
        UPDATE [konto] SET [srodki] = [srodki] - @botRentalFee WHERE [login] = @login

        -- Assign the bot to the user for the specified duration
        INSERT INTO [wynajem]
            ([status], [kwota], [czas_trwania], [data], [login], [bot])
        VALUES
            (1, @botRentalFee, @rentalDuration, GETDATE(), @login, @botID)

        SELECT 'Bot rented successfully' AS [Status]
    END
    ELSE
    BEGIN
        SELECT 'Insufficient funds' AS [Status]
    END
END
GO

-- DECLARE @login varchar(20) = 'adventureSeeker'
-- DECLARE @botID integer = 1
-- DECLARE @rentalDuration integer = 1
-- EXEC RentBot @login, @botID, @rentalDuration
-- GO

-- IF EXISTS (SELECT *
-- FROM sys.objects
-- WHERE type = 'P' AND name = 'RentBot')
-- BEGIN
--     DROP PROCEDURE RentBot
-- END
