USE wynajem_db
GO

CREATE PROCEDURE DodajDoladowanie
    @kwota integer,
    @data datetime,
    @login varchar(20)
AS
BEGIN
    INSERT INTO doladowanie
        (kwota, data, login)
    VALUES
        (@kwota, @data, @login)
END
GO

-- DECLARE @kwota integer
-- DECLARE @data datetime
-- DECLARE @login varchar(20)
-- SET @kwota = 100
-- SET @data = GETDATE()
-- SET @login = 'strategyGuru'
-- EXEC DodajDoladowanie @kwota, @data, @login
-- GO

-- IF EXISTS (SELECT *
-- FROM sys.objects
-- WHERE type = 'P' AND name = 'DodajDoladowanie')
-- BEGIN
--     DROP PROCEDURE DodajDoladowanie
-- END
-- GO
