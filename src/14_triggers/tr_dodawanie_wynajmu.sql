USE wynajem_db
GO

CREATE TRIGGER tr_dodawanie_wynajmu
ON wynajem
AFTER INSERT
AS
BEGIN
    UPDATE konto
    SET srodki = srodki - i.kwota
    FROM konto
        INNER JOIN inserted i ON konto.login = i.login
    WHERE i.status = 1;
END;
GO

DECLARE @BeforeUpdate TABLE (
    login varchar(20),
    srodki_before int
);

DECLARE @AfterUpdate TABLE (
    login varchar(20),
    srodki_after int
);

INSERT INTO @BeforeUpdate
    (login, srodki_before)
SELECT login, srodki
FROM konto
WHERE login = 'fitnessFanatic';

INSERT INTO wynajem
    (status, kwota, czas_trwania, data, login, bot)
VALUES
    (1, 100, 30, GETDATE(), 'fitnessFanatic', 1);

INSERT INTO @AfterUpdate
    (login, srodki_after)
SELECT login, srodki
FROM konto
WHERE login = 'fitnessFanatic';

    SELECT 'Before Update' AS operation, *
    FROM @BeforeUpdate
UNION ALL
    SELECT 'After Update' AS operation, *
    FROM @AfterUpdate;
GO