USE wynajem_db
GO

CREATE PROCEDURE CreateBot
    @ranga integer,
    @param varchar(255),
    @cechy varchar(255),
    @nazwa_gry varchar(20),
    @ilosc_botow integer,
    @login varchar(20),
    @wygrany_1 integer,
    @wygrany_2 integer
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @botID integer;
    DECLARE @meczID integer;

    BEGIN TRY
        -- Start a transaction
        BEGIN TRANSACTION;

        -- Create a new bot
        INSERT INTO bot
        (ranga, param, cechy, nazwa_gry, mecz)
    VALUES
        (@ranga, @param, @cechy, @nazwa_gry, NULL);

        -- Get the ID of the newly created bot
        SET @botID = SCOPE_IDENTITY();

        -- Check if a match already exists for the specified game
        SELECT @meczID = id
    FROM mecz
    WHERE nazwa_gry = @nazwa_gry AND status = 0;

        BEGIN
        INSERT INTO mecz
            (wygrany_1, wygrany_2, wynik, status, nazwa_gry)
        VALUES
            (@wygrany_1, @wygrany_2, 0, 0, @nazwa_gry);

        SET @meczID = SCOPE_IDENTITY();
    END

        -- Update the bot's match association
        UPDATE bot
        SET mecz = @meczID
        WHERE id = @botID;

        -- Update the environment's bot count
        UPDATE srodowisko
        SET ilosc_botow = @ilosc_botow + 1
        WHERE nazwa_gry = @nazwa_gry;

        -- Commit the transaction
        COMMIT;
    END TRY
    BEGIN CATCH
        -- An error occurred, rollback the transaction
        ROLLBACK;
        -- Raise an error or handle it as per your application's needs
        THROW;
    END CATCH;
END;
GO

-- DECLARE @ranga integer = 1;
-- DECLARE @param varchar(255) = '1 2 8 9 10 100 43 1';
-- DECLARE @cechy varchar(255) = '1 82 1 11 1 223 1';
-- DECLARE @nazwa_gry varchar(20) = 'FoodFiesta';
-- DECLARE @ilosc_botow integer = 1;
-- DECLARE @login varchar(20) = 'puzzleSolver';
-- DECLARE @wygrany_1 integer = 13;
-- DECLARE @wygrany_2 integer = 15;
-- EXEC CreateBot @ranga, @param, @cechy, @nazwa_gry, @ilosc_botow, @login, @wygrany_1, @wygrany_2;
-- GO

-- IF EXISTS (SELECT *
-- FROM sys.objects
-- WHERE type = 'P' AND name = 'CreateBot')
-- BEGIN
--     DROP PROCEDURE CreateBot
-- END