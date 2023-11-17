USE wynajem_db
GO

CREATE PROCEDURE DodajRecenzje
    @ocena integer,
    @komentarz varchar(100),
    @data datetime,
    @login varchar(20),
    @bot integer
AS
BEGIN
    INSERT INTO recenzja
        (ocena, komentarz, data, login, bot)
    VALUES
        (@ocena, @komentarz, @data, @login, @bot)
END
GO

-- DECLARE @ocena integer
-- DECLARE @komentarz varchar(100)
-- DECLARE @data datetime
-- DECLARE @login varchar(20)
-- DECLARE @bot integer
-- SET @ocena = 4
-- SET @komentarz = 'Bardzo dobra obsługa. Polecam!'
-- SET @data = GETDATE()
-- SET @login = 'wordsmith'
-- SET @bot = 10
-- EXEC DodajRecenzje @ocena, @komentarz, @data, @login, @bot
-- GO

-- IF EXISTS (SELECT *
-- FROM sys.objects
-- WHERE type = 'P' AND name = 'DodajRecenzje')
-- BEGIN
--     DROP PROCEDURE DodajRecenzje
-- END
-- GO
