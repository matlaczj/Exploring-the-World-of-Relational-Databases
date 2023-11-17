DELIMITER //

CREATE PROCEDURE CreateNewUserAccount(
    IN p_login VARCHAR(20),
    IN p_email VARCHAR(50),
    IN p_password VARCHAR(20),
    IN p_dane_bankowe VARCHAR(26)
)
BEGIN
    DECLARE hashedPassword CHAR(64);
    DECLARE userCount INT;

    -- Check if the login is unique
    SELECT COUNT(*) INTO userCount
    FROM konto
    WHERE login = p_login;

    IF userCount = 0 THEN
        -- Hash the password for security (using SHA-256 hash function)
        SET hashedPassword = SHA2(p_password, 256);

        -- Insert user data into the konto table
        INSERT INTO konto (login, email, haslo, dane_bankowe, srodki)
        VALUES (p_login, p_email, hashedPassword, p_dane_bankowe, 0);

        -- Return success status (1 for success, 0 for failure)
        SELECT 1 AS Status, 'User account created successfully.' AS Message;
    ELSE
        -- Return failure status if the login is not unique
        SELECT 0 AS Status, 'User account creation failed. Login already exists.' AS Message;
    END IF;
END //

DELIMITER ;
DELIMITER //

CREATE PROCEDURE UpdateUserInformation(
    IN p_login VARCHAR(20),
    IN p_newEmail VARCHAR(50),
    IN p_newPassword VARCHAR(20),
    IN p_newDaneBankowe VARCHAR(26)
)
BEGIN
    DECLARE userCount INT;
    DECLARE hashedPassword CHAR(64);

    -- Check if the user exists
    SELECT COUNT(*) INTO userCount
    FROM konto
    WHERE login = p_login;

    IF userCount > 0 THEN
        -- Hash the new password for security (using SHA-256 hash function)
        SET hashedPassword = SHA2(p_newPassword, 256);

        -- Update user information in the konto table
        UPDATE konto
        SET email = p_newEmail,
            haslo = hashedPassword,
            dane_bankowe = p_newDaneBankowe
        WHERE login = p_login;

        -- Return success status (1 for success, 0 for failure)
        SELECT 1 AS Status, 'User information updated successfully.' AS Message;
    ELSE
        -- Return failure status if the user does not exist
        SELECT 0 AS Status, 'User not found. Information update failed.' AS Message;
    END IF;
END //

DELIMITER ;
DELIMITER //

CREATE PROCEDURE UsunSlabeBoty()
BEGIN
    DECLARE MinimalnaOcena INT;
    SET MinimalnaOcena = 2;

    DELETE FROM bot
    WHERE id IN (
        SELECT b.id
        FROM bot b
        LEFT JOIN recenzja r ON b.id = r.bot
        GROUP BY b.id
        HAVING AVG(IFNULL(r.ocena, 0)) < MinimalnaOcena
    );
END //

DELIMITER ;
DELIMITER //

CREATE PROCEDURE CreateBot(
    IN p_ranga INT,
    IN p_param VARCHAR(255),
    IN p_cechy VARCHAR(255),
    IN p_nazwa_gry VARCHAR(20),
    IN p_ilosc_botow INT,
    IN p_login VARCHAR(20),
    IN p_wygrany_1 INT,
    IN p_wygrany_2 INT
)
BEGIN
    DECLARE botID INT;
    DECLARE meczID INT;

    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
    BEGIN
        -- An error occurred, rollback the transaction
        ROLLBACK;
        -- Raise an error or handle it as per your application's needs
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error occurred during transaction';
    END;

    -- Start a transaction
    START TRANSACTION;

    -- Create a new bot
    INSERT INTO bot (ranga, param, cechy, nazwa_gry, mecz)
    VALUES (p_ranga, p_param, p_cechy, p_nazwa_gry, NULL);

    -- Get the ID of the newly created bot
    SET botID = LAST_INSERT_ID();

    -- Check if a match already exists for the specified game
    SELECT id INTO meczID
    FROM mecz
    WHERE nazwa_gry = p_nazwa_gry AND status = 0;

    IF meczID IS NULL THEN
        -- Create a new match
        INSERT INTO mecz (wygrany_1, wygrany_2, wynik, status, nazwa_gry)
        VALUES (p_wygrany_1, p_wygrany_2, 0, 0, p_nazwa_gry);

        -- Get the ID of the newly created match
        SET meczID = LAST_INSERT_ID();
    END IF;

    -- Update the bot's match association
    UPDATE bot
    SET mecz = meczID
    WHERE id = botID;

    -- Update the environment's bot count
    UPDATE srodowisko
    SET ilosc_botow = p_ilosc_botow + 1
    WHERE nazwa_gry = p_nazwa_gry;

    -- Commit the transaction
    COMMIT;
END //

DELIMITER ;
DELIMITER //

CREATE PROCEDURE RentBot(
    IN p_login VARCHAR(20),
    IN p_botID INT,
    IN p_rentalDuration INT
)
BEGIN
    -- Calculate the rental fee
    SET @botRentalFee = 10 * p_rentalDuration;

    -- Get user's balance
    SET @userBalance = (SELECT srodki FROM konto WHERE login = p_login);

    -- Check if the user has sufficient funds
    IF @userBalance >= @botRentalFee THEN
        -- Deduct the rental fee from user's balance
        UPDATE konto SET srodki = srodki - @botRentalFee WHERE login = p_login;

        -- Assign the bot to the user for the specified duration
        INSERT INTO wynajem (status, kwota, czas_trwania, data, login, bot)
        VALUES (1, @botRentalFee, p_rentalDuration, NOW(), p_login, p_botID);

        SELECT 'Bot rented successfully' AS Status;
    ELSE
        SELECT 'Insufficient funds' AS Status;
    END IF;
END //

DELIMITER ;
DELIMITER //

CREATE PROCEDURE SendMessage(
    IN p_sender VARCHAR(20),
    IN p_recipient VARCHAR(20),
    IN p_messageText VARCHAR(100)
)
BEGIN
    -- Send a message to the recipient
    INSERT INTO wiadomosc (nadawca, odbiorca, tresc, data, status)
    VALUES (p_sender, p_recipient, p_messageText, NOW(), 0);

    SELECT 'Message sent successfully' AS Status;
END //

DELIMITER ;
DELIMITER //

CREATE PROCEDURE ViewTransactionHistory(
    IN p_login VARCHAR(20)
)
BEGIN
    -- View transaction history for the user
    SELECT id, kwota, data, 'Doladowanie' AS TransactionType
    FROM doladowanie
    WHERE login = p_login
    UNION ALL
    SELECT id, kwota, data, 'Wynajem' AS TransactionType
    FROM wynajem
    WHERE login = p_login;
    -- Add other relevant columns and tables for transaction history as needed
END //

DELIMITER ;
DELIMITER //

CREATE PROCEDURE WynajmijBota(
    IN p_login VARCHAR(20),
    IN p_bot_id INT,
    IN p_czas_trwania INT,
    IN p_kwota INT,
    IN p_nazwa_gry VARCHAR(20),
    IN p_wygrany_1 INT,
    IN p_wygrany_2 INT,
    IN p_wynik INT
)
BEGIN
    DECLARE error_occurred BOOLEAN DEFAULT FALSE;
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
        SET error_occurred := TRUE;

    -- Rozpocznij transakcję
    START TRANSACTION;

    -- Wynajmij bota
    CALL DodajWynajem(1, p_kwota, p_czas_trwania, NOW(), p_login, p_bot_id);

    -- Dodaj nowy mecz
    CALL DodajMecz(p_wygrany_1, p_wygrany_2, p_wynik, 1, p_nazwa_gry);

    -- Sprawdź, czy wystąpiły błędy
    IF error_occurred THEN
        -- W razie błędu cofnij transakcję
        ROLLBACK;
        SIGNAL SQLSTATE '45001'
        SET MESSAGE_TEXT = 'Wystąpił błąd podczas operacji. Transakcja została cofnięta.';
    ELSE
        -- Zakończ transakcję
        COMMIT;
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Operacja zakończona pomyślnie.';
    END IF;
END //

DELIMITER ;
DELIMITER //

CREATE PROCEDURE DodajBota(
    IN p_ranga INT,
    IN p_param VARCHAR(255),
    IN p_cechy VARCHAR(255),
    IN p_nazwa_gry VARCHAR(20),
    IN p_mecz INT
)
BEGIN
    INSERT INTO bot (ranga, param, cechy, nazwa_gry, mecz)
    VALUES (p_ranga, p_param, p_cechy, p_nazwa_gry, p_mecz);
END //

DELIMITER ;
DELIMITER //

CREATE PROCEDURE DodajDoladowanie(
    IN p_kwota INT,
    IN p_data DATETIME,
    IN p_login VARCHAR(20)
)
BEGIN
    INSERT INTO doladowanie (kwota, data, login)
    VALUES (p_kwota, p_data, p_login);
END //

DELIMITER ;
DELIMITER //

CREATE PROCEDURE DodajKonto(
    IN p_login VARCHAR(20),
    IN p_email VARCHAR(50),
    IN p_haslo VARCHAR(20),
    IN p_dane_bankowe VARCHAR(26),
    IN p_srodki INT
)
BEGIN
    INSERT INTO konto (login, email, haslo, dane_bankowe, srodki)
    VALUES (p_login, p_email, p_haslo, p_dane_bankowe, p_srodki);
END //

DELIMITER ;
DELIMITER //

CREATE PROCEDURE DodajMecz(
    IN p_wygrany_1 INT,
    IN p_wygrany_2 INT,
    IN p_wynik INT,
    IN p_status TINYINT,
    IN p_nazwa_gry VARCHAR(20)
)
BEGIN
    INSERT INTO mecz (wygrany_1, wygrany_2, wynik, status, nazwa_gry)
    VALUES (p_wygrany_1, p_wygrany_2, p_wynik, p_status, p_nazwa_gry);
END //

DELIMITER ;
DELIMITER //

CREATE PROCEDURE DodajOsiagniecie(
    IN p_przedmiot INT,
    IN p_czas_os DATETIME,
    IN p_login VARCHAR(20),
    IN p_bot INT
)
BEGIN
    INSERT INTO osiagniecie (przedmiot, czas_os, login, bot)
    VALUES (p_przedmiot, p_czas_os, p_login, p_bot);
END //

DELIMITER ;
DELIMITER //

CREATE PROCEDURE DodajPrzedmiot(
    IN p_nazwa_os VARCHAR(20),
    IN p_nazwa_przedmiotu VARCHAR(20),
    IN p_jakosc INT
)
BEGIN
    INSERT INTO przedmiot (nazwa_os, nazwa_przedmiotu, jakosc)
    VALUES (p_nazwa_os, p_nazwa_przedmiotu, p_jakosc);
END //

DELIMITER ;
DELIMITER //

CREATE PROCEDURE DodajRecenzje(
    IN p_ocena INT,
    IN p_komentarz VARCHAR(100),
    IN p_data DATETIME,
    IN p_login VARCHAR(20),
    IN p_bot INT
)
BEGIN
    INSERT INTO recenzja (ocena, komentarz, data, login, bot)
    VALUES (p_ocena, p_komentarz, p_data, p_login, p_bot);
END //

DELIMITER ;
DELIMITER //

CREATE PROCEDURE DodajSrodowisko(
    IN p_nazwa_gry VARCHAR(20),
    IN p_ilosc_botow INT
)
BEGIN
    INSERT INTO srodowisko (nazwa_gry, ilosc_botow)
    VALUES (p_nazwa_gry, p_ilosc_botow);
END //

DELIMITER ;
DELIMITER //

CREATE PROCEDURE DodajWiadomosc(
    IN p_nadawca VARCHAR(20),
    IN p_odbiorca VARCHAR(20),
    IN p_tresc VARCHAR(100),
    IN p_data DATETIME,
    IN p_status BIT
)
BEGIN
    INSERT INTO wiadomosc (nadawca, odbiorca, tresc, data, status)
    VALUES (p_nadawca, p_odbiorca, p_tresc, p_data, p_status);
END //

DELIMITER ;
DELIMITER //

CREATE PROCEDURE DodajWynajem(
    IN p_status BIT,
    IN p_kwota INTEGER,
    IN p_czas_trwania INTEGER,
    IN p_data DATETIME,
    IN p_login VARCHAR(20),
    IN p_bot INTEGER
)
BEGIN
    INSERT INTO wynajem (status, kwota, czas_trwania, data, login, bot)
    VALUES (p_status, p_kwota, p_czas_trwania, p_data, p_login, p_bot);
END //

DELIMITER ;
