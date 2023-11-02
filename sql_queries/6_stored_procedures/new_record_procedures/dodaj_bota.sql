USE wynajem_db
GO

CREATE PROCEDURE DodajBota
    @ranga integer,
    @param varchar(255),
    @cechy varchar(255),
    @nazwa_gry varchar(20),
    @mecz integer
AS
BEGIN
    INSERT INTO bot
        (ranga, param, cechy, nazwa_gry, mecz)
    VALUES
        (@ranga, @param, @cechy, @nazwa_gry, @mecz)
END
GO

-- DECLARE @ranga integer
-- DECLARE @param varchar(255)
-- DECLARE @cechy varchar(255)
-- DECLARE @nazwa_gry varchar(20)
-- DECLARE @mecz integer
-- SET @ranga = 1
-- SET @param = 'Parametry testowe'
-- SET @cechy = 'Cechy testowe'
-- SET @nazwa_gry = 'FoodFiesta'
-- SET @mecz = 1
-- EXEC DodajBota @ranga, @param, @cechy, @nazwa_gry, @mecz
-- GO

-- IF EXISTS (SELECT *
-- FROM sys.objects
-- WHERE type = 'P' AND name = 'DodajBota')
-- BEGIN
--     DROP PROCEDURE DodajBota
-- END
-- GO
