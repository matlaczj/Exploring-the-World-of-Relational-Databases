-- Create temporary tables
CREATE TEMPORARY TABLE BeforeUpdate (
    operation VARCHAR(20),
    login VARCHAR(20),
    srodki_before INT
);

CREATE TEMPORARY TABLE AfterUpdate (
    operation VARCHAR(20),
    login VARCHAR(20),
    srodki_after INT
);

-- Populate BeforeUpdate table
INSERT INTO BeforeUpdate
    (operation, login, srodki_before)
SELECT 'Before Update', login, srodki
FROM konto
WHERE login = 'fitnessFanatic';

-- Insert into wynajem table
INSERT INTO wynajem
    (status, kwota, czas_trwania, data, login, bot)
VALUES
    (1, 100, 30, NOW(), 'fitnessFanatic', 1);

-- Populate AfterUpdate table
INSERT INTO AfterUpdate
    (operation, login, srodki_after)
SELECT 'After Update', login, srodki
FROM konto
WHERE login = 'fitnessFanatic';

-- Retrieve data from temporary tables
SELECT * FROM BeforeUpdate
UNION ALL
SELECT * FROM AfterUpdate;

-- Drop temporary tables (optional, they will be automatically dropped when the session ends)
DROP TEMPORARY TABLE IF EXISTS BeforeUpdate;
DROP TEMPORARY TABLE IF EXISTS AfterUpdate;

-- Retrieve srodki before doladowanie
SELECT srodki AS przed_doladowaniem
FROM konto
WHERE login = 'fitnessFanatic';

-- Perform doladowanie
INSERT INTO doladowanie
    (kwota, data, login)
VALUES
    (100, NOW(), 'fitnessFanatic');

-- Retrieve srodki after doladowanie
SELECT srodki AS po_doladowaniu
FROM konto
WHERE login = 'fitnessFanatic';

-- Retrieve ranga before recenzja insertion
SELECT ranga
FROM bot
WHERE id = 1;

-- Insert first recenzja
INSERT INTO recenzja
    (ocena, komentarz, data, login, bot)
VALUES
    (10000, 'Bardzo dobry bot!', NOW(), 'cardPlayer', 1);

-- Insert second recenzja
INSERT INTO recenzja
    (ocena, komentarz, data, login, bot)
VALUES
    (4, 'Dobry bot, ale jeszcze ma miejsce na poprawę.', NOW(), 'gameMaster', 1);

-- Retrieve ranga after recenzja insertion
SELECT ranga
FROM bot
WHERE id = 1;

-- Insert new mecz
INSERT INTO mecz
    (wygrany_1, wygrany_2, wynik, status, nazwa_gry)
VALUES
    (1, 2, 0, 0, 'GymGalaxy');

-- Select mecz information before update
SELECT id, wygrany_1, wygrany_2, wynik
FROM mecz
WHERE nazwa_gry = 'GymGalaxy' AND status = 0;

-- Update mecz information
UPDATE mecz
SET wygrany_1 = 3, wygrany_2 = 2
WHERE nazwa_gry = 'GymGalaxy' AND status = 0;

-- Select mecz information after update
SELECT id, wygrany_1, wygrany_2, wynik
FROM mecz
WHERE nazwa_gry = 'GymGalaxy' AND status = 0;

-- Insert new mecz
INSERT INTO mecz
    (wygrany_1, wygrany_2, wynik, status, nazwa_gry)
VALUES
    (1, 2, 0, 0, 'GymGalaxy');

-- Select mecz information before update
SELECT id, wygrany_1, wygrany_2, wynik
FROM mecz
WHERE nazwa_gry = 'GymGalaxy' AND status = 0;

-- Update mecz information
UPDATE mecz
SET wygrany_1 = 3, wygrany_2 = 2
WHERE nazwa_gry = 'GymGalaxy' AND status = 0;

-- Select mecz information after update
SELECT id, wygrany_1, wygrany_2, wynik
FROM mecz
WHERE nazwa_gry = 'GymGalaxy' AND status = 0;

