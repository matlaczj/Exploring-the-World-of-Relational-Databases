USE wynajem_db
GO

CREATE TRIGGER tr_zmiana_statusu_meczu
ON mecz
AFTER UPDATE
AS
BEGIN
    UPDATE mecz
    SET wynik = i.wygrany_1_score + i.wygrany_2_score
    FROM mecz
        INNER JOIN (SELECT id, wygrany_1_score = SUM(wygrany_1), wygrany_2_score = SUM(wygrany_2)
        FROM inserted
        GROUP BY id) i ON mecz.id = i.id;
END;
GO

INSERT INTO mecz
    (wygrany_1, wygrany_2, wynik, status, nazwa_gry)
VALUES
    (1, 2, 0, 0, 'GymGalaxy');
GO

SELECT id, wygrany_1, wygrany_2, wynik
FROM mecz
WHERE nazwa_gry = 'GymGalaxy' AND status = 0;
GO

UPDATE mecz
SET wygrany_1 = 3, wygrany_2 = 2
WHERE nazwa_gry = 'GymGalaxy' AND status = 0;
GO

SELECT id, wygrany_1, wygrany_2, wynik
FROM mecz
WHERE nazwa_gry = 'GymGalaxy' AND status = 0;
GO

