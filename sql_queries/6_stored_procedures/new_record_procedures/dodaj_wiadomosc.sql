USE wynajem_db
GO

CREATE PROCEDURE DodajWiadomosc
    @nadawca varchar(20),
    @odbiorca varchar(20),
    @tresc varchar(100),
    @data datetime,
    @status bit
AS
BEGIN
    INSERT INTO wiadomosc
        (nadawca, odbiorca, tresc, data, status)
    VALUES
        (@nadawca, @odbiorca, @tresc, @data, @status)
END
GO

DECLARE @nadawca varchar(20)
DECLARE @odbiorca varchar(20)
DECLARE @tresc varchar(100)
DECLARE @data datetime
DECLARE @status bit
SET @nadawca = 'gameMaster'
SET @odbiorca = 'musicLover'
SET @tresc = 'To jest testowa wiadomość.'
SET @data = GETDATE()
SET @status = 0
EXEC DodajWiadomosc @nadawca, @odbiorca, @tresc, @data, @status
GO

IF EXISTS (SELECT *
FROM sys.objects
WHERE type = 'P' AND name = 'DodajWiadomosc')
BEGIN
    DROP PROCEDURE DodajWiadomosc
END
GO
