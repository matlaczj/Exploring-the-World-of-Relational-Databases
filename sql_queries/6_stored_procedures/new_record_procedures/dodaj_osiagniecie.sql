USE wynajem_db
GO

CREATE PROCEDURE DodajOsiagniecie
    @przedmiot integer,
    @czas_os datetime,
    @login varchar(20),
    @bot integer
AS
BEGIN
    INSERT INTO osiagniecie
        (przedmiot, czas_os, login, bot)
    VALUES
        (@przedmiot, @czas_os, @login, @bot)
END
GO

DECLARE @przedmiot integer
DECLARE @czas_os datetime
DECLARE @login varchar(20)
DECLARE @bot integer
SET @przedmiot = 1
SET @czas_os = GETDATE()
SET @login = 'puzzleSolver'
SET @bot = 1
EXEC DodajOsiagniecie @przedmiot, @czas_os, @login, @bot
GO

IF EXISTS (SELECT *
FROM sys.objects
WHERE type = 'P' AND name = 'DodajOsiagniecie')
BEGIN
    DROP PROCEDURE DodajOsiagniecie
END
GO
