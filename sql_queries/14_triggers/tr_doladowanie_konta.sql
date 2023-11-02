USE wynajem_db
GO

CREATE TRIGGER tr_doladowanie_konta
ON doladowanie
AFTER INSERT
AS
BEGIN
    UPDATE konto
    SET srodki = srodki + i.kwota
    FROM konto
        INNER JOIN inserted i ON konto.login = i.login;
END;
GO

SELECT srodki AS przed_doladowaniem
FROM konto
WHERE login = 'fitnessFanatic';
GO

INSERT INTO doladowanie
    (kwota, data, login)
VALUES
    (100, GETDATE(), 'fitnessFanatic');
GO

SELECT srodki AS po_doladowaniu
FROM konto
WHERE login = 'fitnessFanatic';
GO