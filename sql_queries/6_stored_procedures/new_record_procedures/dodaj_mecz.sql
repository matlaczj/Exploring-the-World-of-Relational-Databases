USE wynajem_db
GO

CREATE PROCEDURE DodajMecz
    @wygrany_1 integer,
    @wygrany_2 integer,
    @wynik integer,
    @status bit,
    @nazwa_gry varchar(20)
AS
BEGIN
    INSERT INTO mecz
        (wygrany_1, wygrany_2, wynik, status, nazwa_gry)
    VALUES
        (@wygrany_1, @wygrany_2, @wynik, @status, @nazwa_gry)
END
GO

DECLARE @wygrany_1 integer
DECLARE @wygrany_2 integer
DECLARE @wynik integer
DECLARE @status bit
DECLARE @nazwa_gry varchar(20)
SET @wygrany_1 = 1
SET @wygrany_2 = 2
SET @wynik = 3
SET @status = 1
SET @nazwa_gry = 'BookLand'
EXEC DodajMecz @wygrany_1, @wygrany_2, @wynik, @status, @nazwa_gry
GO

IF EXISTS (SELECT *
FROM sys.objects
WHERE type = 'P' AND name = 'DodajMecz')
BEGIN
    DROP PROCEDURE DodajMecz
END
GO
