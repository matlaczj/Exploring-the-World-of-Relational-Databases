USE wynajem_db
GO

CREATE PROCEDURE DodajWynajem
    @status bit,
    @kwota integer,
    @czas_trwania integer,
    @data datetime,
    @login varchar(20),
    @bot integer
AS
BEGIN
    INSERT INTO wynajem
        (status, kwota, czas_trwania, data, login, bot)
    VALUES
        (@status, @kwota, @czas_trwania, @data, @login, @bot)
END
GO

-- DECLARE @status bit
-- DECLARE @kwota integer
-- DECLARE @czas_trwania integer
-- DECLARE @data datetime
-- DECLARE @login varchar(20)
-- DECLARE @bot integer
-- SET @status = 1
-- -- Ustawienie statusu wynajmu
-- SET @kwota = 500
-- -- Ustawienie kwoty wynajmu
-- SET @czas_trwania = 30
-- -- Ustawienie czasu trwania wynajmu (w minutach)
-- SET @data = GETDATE()
-- -- Ustawienie aktualnej daty i czasu
-- SET @login = 'triviaExpert'
-- SET @bot = 1
-- -- Ustawienie identyfikatora bota, który jest wynajmowany
-- EXEC DodajWynajem @status, @kwota, @czas_trwania, @data, @login, @bot
-- GO

-- IF EXISTS (SELECT *
-- FROM sys.objects
-- WHERE type = 'P' AND name = 'DodajWynajem')
-- BEGIN
--     DROP PROCEDURE DodajWynajem
-- END
-- GO
