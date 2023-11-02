USE wynajem_db
GO

CREATE PROCEDURE DodajPrzedmiot
    @nazwa_os varchar(20),
    @nazwa_przedmiotu varchar(20),
    @jakosc integer
AS
BEGIN
    INSERT INTO przedmiot
        (nazwa_os, nazwa_przedmiotu, jakosc)
    VALUES
        (@nazwa_os, @nazwa_przedmiotu, @jakosc)
END
GO

DECLARE @nazwa_os varchar(20)
DECLARE @nazwa_przedmiotu varchar(20)
DECLARE @jakosc integer
SET @nazwa_os = 'FoodFiesta'
SET @nazwa_przedmiotu = 'Bookworms Collection'
SET @jakosc = 1
EXEC DodajPrzedmiot @nazwa_os, @nazwa_przedmiotu, @jakosc
GO

IF EXISTS (SELECT *
FROM sys.objects
WHERE type = 'P' AND name = 'DodajPrzedmiot')
BEGIN
    DROP PROCEDURE DodajPrzedmiot
END
GO
