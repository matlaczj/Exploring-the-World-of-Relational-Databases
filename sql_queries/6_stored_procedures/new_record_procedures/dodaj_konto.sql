USE wynajem_db
GO

CREATE PROCEDURE DodajKonto
    @login varchar(20),
    @email varchar(50),
    @haslo varchar(20),
    @dane_bankowe varchar(26),
    @srodki integer
AS
BEGIN
    INSERT INTO konto
        (login, email, haslo, dane_bankowe, srodki)
    VALUES
        (@login, @email, @haslo, @dane_bankowe, @srodki)
END
GO

DECLARE @login varchar(20)
DECLARE @email varchar(50)
DECLARE @haslo varchar(20)
DECLARE @dane_bankowe varchar(26)
DECLARE @srodki integer
SET @login = 'nowy_uzytkownik2'
SET @email = 'nowy_uzytkownik@example.com'
SET @haslo = 'haslo123'
SET @dane_bankowe = '1234567890'
SET @srodki = 1000
EXEC DodajKonto @login, @email, @haslo, @dane_bankowe, @srodki
GO

IF EXISTS (SELECT *
FROM sys.objects
WHERE type = 'P' AND name = 'DodajKonto')
BEGIN
    DROP PROCEDURE DodajKonto
END
GO