DELIMITER //

CREATE TRIGGER tr_dodawanie_wynajmu
AFTER INSERT
ON wynajem FOR EACH ROW
BEGIN
    IF NEW.status = 1 THEN
        UPDATE konto
        SET srodki = srodki - NEW.kwota
        WHERE login = NEW.login;
    END IF;
END //

DELIMITER ;
DELIMITER //

CREATE TRIGGER tr_doladowanie_konta
AFTER INSERT
ON doladowanie FOR EACH ROW
BEGIN
    UPDATE konto
    SET srodki = srodki + NEW.kwota
    WHERE login = NEW.login;
END //

DELIMITER ;
DELIMITER //

CREATE TRIGGER tr_obliczanie_sredniej_oceny
AFTER INSERT
ON recenzja FOR EACH ROW
BEGIN
    DECLARE avg_ocena DECIMAL(10,2);
    
    SELECT AVG(ocena) INTO avg_ocena
    FROM recenzja
    WHERE bot = NEW.bot;

    UPDATE bot
    SET ranga = avg_ocena
    WHERE id = NEW.bot;
END //

DELIMITER ;
DELIMITER //

CREATE TRIGGER tr_zmiana_statusu_meczu
AFTER UPDATE
ON mecz FOR EACH ROW
BEGIN
    DECLARE wygrany_1_score INT;
    DECLARE wygrany_2_score INT;

    SELECT SUM(wygrany_1), SUM(wygrany_2) INTO wygrany_1_score, wygrany_2_score
    FROM inserted
    WHERE id = NEW.id;

    UPDATE mecz
    SET wynik = wygrany_1_score + wygrany_2_score
    WHERE id = NEW.id;
END //

DELIMITER ;
