USE wynajem_db
GO

CREATE TRIGGER tr_obliczanie_sredniej_oceny
ON recenzja
AFTER INSERT
AS
BEGIN
    UPDATE bot
    SET ranga = (SELECT AVG(ocena)
    FROM recenzja
    WHERE bot = i.bot)
    FROM bot
        INNER JOIN inserted i ON bot.id = i.bot;
END;
GO

SELECT ranga
FROM bot
WHERE id = 1;
GO

INSERT INTO recenzja
    (ocena, komentarz, data, login, bot)
VALUES
    (10000, 'Bardzo dobry bot!', GETDATE(), 'cardPlayer', 1);

INSERT INTO recenzja
    (ocena, komentarz, data, login, bot)
VALUES
    (4, 'Dobry bot, ale jeszcze ma miejsce na poprawę.', GETDATE(), 'gameMaster', 1);
GO

SELECT ranga
FROM bot
WHERE id = 1;
GO
