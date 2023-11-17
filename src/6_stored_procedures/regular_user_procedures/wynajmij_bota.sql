USE wynajem_db
GO

CREATE PROCEDURE WynajmijBota
    @login varchar(20),
    @bot_id integer,
    @czas_trwania integer,
    @kwota integer,
    @nazwa_gry varchar(20),
    @wygrany_1 integer,
    @wygrany_2 integer,
    @wynik integer
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION; -- Rozpocznij transakcję
        -- Wynajmij bota
        DECLARE @data datetime
        SET @data = GETDATE()
        EXEC DodajWynajem 1, @kwota, @czas_trwania, @data, @login, @bot_id;
        -- Dodaj nowy mecz
        EXEC DodajMecz @wygrany_1, @wygrany_2, @wynik, 1, @nazwa_gry;
        COMMIT; -- Potwierdź transakcję
        PRINT 'Operacja zakończona pomyślnie.';
    END TRY
    BEGIN CATCH
        ROLLBACK; -- Cofnij transakcję w przypadku błędu
        PRINT 'Wystąpił błąd podczas operacji. Transakcja została cofnięta.';
        -- Obsługa błędu: można tutaj obsłużyć błąd, np. logując go do tabeli logów
    END CATCH
END
GO

DECLARE @login varchar(20)
DECLARE @bot_id integer
DECLARE @czas_trwania integer
DECLARE @kwota integer
DECLARE @nazwa_gry varchar(20)
DECLARE @wygrany_1 integer
DECLARE @wygrany_2 integer
DECLARE @wynik integer
SET @login = 'triviaExpert'
SET @bot_id = 1
SET @czas_trwania = 30
SET @kwota = 500
SET @nazwa_gry = 'BookLand'
SET @wygrany_1 = 2
SET @wygrany_2 = 3
SET @wynik = 2
EXEC WynajmijBota @login, @bot_id, @czas_trwania, @kwota, @nazwa_gry, @wygrany_1, @wygrany_2, @wynik
GO

IF EXISTS (SELECT *
FROM sys.objects
WHERE type = 'P' AND name = 'WynajmijBota')
BEGIN
    DROP PROCEDURE WynajmijBota
END