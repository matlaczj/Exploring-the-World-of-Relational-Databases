USE wynajem_db
GO

CREATE PROCEDURE DodajSrodowisko
    @nazwa_gry varchar(20),
    @ilosc_botow integer
AS
BEGIN
    INSERT INTO srodowisko
        (nazwa_gry, ilosc_botow)
    VALUES
        (@nazwa_gry, @ilosc_botow)
END
GO

DECLARE @nazwa_gry varchar(20)
DECLARE @ilosc_botow integer
SET @nazwa_gry = 'Gra_testowa'
SET @ilosc_botow = 10
EXEC DodajSrodowisko @nazwa_gry, @ilosc_botow
GO

IF EXISTS (SELECT *
FROM sys.objects
WHERE type = 'P' AND name = 'DodajSrodowisko')
BEGIN
    DROP PROCEDURE DodajSrodowisko
END
GO
